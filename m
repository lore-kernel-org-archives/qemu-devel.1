Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B54C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3744239D2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMYZ9/6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3744239D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKejq-0003V2-O3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKeie-0002Cn-8s
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKeia-0007XE-H7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600767370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NfzWaBbZ+E6DY3ROfkMxATltOWsH6J4q8EfxbayomvI=;
 b=cMYZ9/6TDvhXvT//+mbYytB4xQ8ova1XwS8Esb0RUKpH/i2q+Iyj5wWXlZCChg2PN6KRBL
 BqSeJNIv/UxQOzYA83CZ3SOXBlkTGtpVa9cpgXOVejLZqxrGuTvV2Fc7cZdDm67nLFLcle
 5Te7ZH9kcyj149K9Zai/YawTOjb7t7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-6HSgF04nOI24wjb9DDOUMA-1; Tue, 22 Sep 2020 05:36:06 -0400
X-MC-Unique: 6HSgF04nOI24wjb9DDOUMA-1
Received: by mail-wr1-f71.google.com with SMTP id r16so7137565wrm.18
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NfzWaBbZ+E6DY3ROfkMxATltOWsH6J4q8EfxbayomvI=;
 b=Q3FyJfoepj36QUm1OlbQ2W+0rb9ZRMvHvJ67NETFmveBljhjn0KPkNVLTkE6mVUIeb
 6MrhxbMFyO0dXQVl+qkUdu4q24MN9WeZLboMfloxv8zlg9LINBZg4mT0lqwDPUy+YjIW
 S8WHKNtaVz/Ggir2mKjzo9niamrjZfX35TOFb0r6osyNlog6m613fY8JMbSEv9fTWBVU
 58w10pbix4TVIFI4p9KGXgo6c5aujoNrNlsZ5rfeiUJEXug7ryS9Eg5+OmgXqIBi7BML
 dmZLToan3G9O6kPFHd+eb41YkeYnaYyy3lDAB0830PCotCZIIitIhQHKjIU0ygAFnm+N
 tJeQ==
X-Gm-Message-State: AOAM5313ybhnU9AE5VpYgTKWz2JZiyTHU4wCwZHccI9yFh9V+6aG3JIp
 VFVKzjHjWB1TjZkHMft8f5PbvQgpQWHlkZRlNhqxTGx8Gki3cal32SvkdEJrvYHEf6Pp9vmlV6t
 riSl3rZW9ul9/zTo=
X-Received: by 2002:adf:e44b:: with SMTP id t11mr4463772wrm.101.1600767365501; 
 Tue, 22 Sep 2020 02:36:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnKZe66gbBxV/jlrtQLtQkhgE5qcqwaYKx/dhTD2PCDnGvE2jfbnx+u01qb7nJwHmqm10v3Q==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr4463738wrm.101.1600767365244; 
 Tue, 22 Sep 2020 02:36:05 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u186sm3784246wmu.34.2020.09.22.02.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:36:04 -0700 (PDT)
Subject: Re: [PATCH 2/6] block/nvme: Map doorbells pages write-only
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200921162949.553863-1-philmd@redhat.com>
 <20200921162949.553863-3-philmd@redhat.com>
 <6ea4b96862a0dac22205592b6c8d9e21ab57189a.camel@euphon.net>
 <22dab788-06f1-3686-51f3-24ee7ce77fda@redhat.com>
 <bd7e17f6-95cb-e697-731b-e61ac3a64d30@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <4e8fa9f5-9563-dc76-b2a0-0a7630b4a1d8@redhat.com>
Date: Tue, 22 Sep 2020 11:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <bd7e17f6-95cb-e697-731b-e61ac3a64d30@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 11:04 AM, Paolo Bonzini wrote:
> On 22/09/20 10:41, Philippe Mathieu-Daudé wrote:
>>> Besides looking more correct in access mode, is there any side effect
>>> of WO mapping?
>> TBH I don't have enough knowledge to answer this question.
>> I tested successfully on X86. I'm writing more tests.
> 
> No problem with doing this, but PROT_WRITE does not work at all on x86.
> :)  PROT_EXEC works if you have a machine with PKRU, but PROT_WRITE
> silently becomes PROT_READ|PROT_WRITE because the processor does not
> support it.

Ah this is why it works the same way in my testing.

I'll run tests on ARM.

Thanks,

Phil.

> 
> Paolo
> 


