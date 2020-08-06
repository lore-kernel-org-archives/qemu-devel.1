Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453A423117
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6GpbIH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453A423117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hcR-0006NJ-7O
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hZe-0004X1-Us
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:12:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hZc-0000pu-Gj
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596726771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C41PX+o3aCnTRmhexRhBMXfITZ25Fb4SoJfgxvWG4Og=;
 b=d6GpbIH4hJMbI7vttfbAP0un8IC3IurMz2FXD7MHdO0UMEvMS99l/PYxv8bA5ZUvQ5ZIcE
 w8DmXq0kIOw+g5ts/ge76d4AFVEbdbL7rt7FAzPfPb7hjkw2mbK+oNmFM0zpOf6OS38qUe
 N8FLoNUTy39eDv1DKpg2Bej8QQPjoAQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-qWA41IXtM1qRdhGf4VJ0eg-1; Thu, 06 Aug 2020 11:12:47 -0400
X-MC-Unique: qWA41IXtM1qRdhGf4VJ0eg-1
Received: by mail-wm1-f71.google.com with SMTP id f74so4267582wmf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 08:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C41PX+o3aCnTRmhexRhBMXfITZ25Fb4SoJfgxvWG4Og=;
 b=OHJWL9ImeCJ9/8OyI80A/EvVVttyg906pi7KBI0H34QuFFedQI8kqYzLWuIUOaO2Lc
 +quKbnCHHPet4JH/mQdLRphHj7uGSiiJJ9H4UUA3IlbsBnwM8g/Bg7T5lWQRBxEg6Hyc
 1JN22EUVI65VIL3hADA22Y2nWCQsSCif+XapNf/w9L+hDQv+81GHtHkcxaLSfoqJZBOw
 fjbUzcEMslombW/AhTw8fwenZRF6t2096+WwoIVUtAMtfuH4iQ4CDna8wqAji0WivgOu
 cETmTU1rFLSdxVrgvjgJo9L1SR2z/eF33BjiWx1j79foHPmg8AZ6U2/kT6zKiWkOLVli
 VJnQ==
X-Gm-Message-State: AOAM532tkb1c/LC8KS3uRAXlSXkoxDNMRfucK8DPlUHg2rCu+y2Ms+8j
 YHiM+w/+82nU3msM5QUIkRjjnEdp6JUnlJ1+PUMihcpmFfM+qOJ3vzHcpcMu2UYPfM466aZhEZl
 e0OLG7Es9BECeGDg=
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr8844357wmm.135.1596726766169; 
 Thu, 06 Aug 2020 08:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxogWu8y0qrFFuNLCQGsuMZHwzDmYs96ljqSS/TbI7tTggfTtPVMyPyqXo0nYC/K1dMmg8yNg==
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr8844345wmm.135.1596726766002; 
 Thu, 06 Aug 2020 08:12:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v12sm6761376wrs.2.2020.08.06.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 08:12:45 -0700 (PDT)
Subject: Re: [qemu]: How to use qemu to run 64MB bmc image?
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 www <ouyangxuan10@163.com>, andrew@aj.id.au, joel@jms.id.au,
 qemu-devel@nongnu.org
References: <7c834989.1a25.173c17e115d.Coremail.ouyangxuan10@163.com>
 <1f2df783-caf0-a5da-11f2-bb99d006b961@kaod.org>
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
Message-ID: <248a1877-66a6-9a4b-f1f0-92819aa9a072@redhat.com>
Date: Thu, 6 Aug 2020 17:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1f2df783-caf0-a5da-11f2-bb99d006b961@kaod.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:54 PM, Cédric Le Goater wrote:
> Hello,
> 
> On 8/6/20 3:58 AM, www wrote:
>> Hi Joel Stanley, Andrew Jeffery, Cédric Le Goater,
>>
>> How to modify it so that QEMU can run 64MB BMC image?
> 
> You can increase the FW image file size with 'dd' or with :
> 
>   cat foo foo > bar
> 
> if the expected size is 128MB

You can use 'truncate' from coreutils:

$ truncate -s 128M image.bin

> 
> C.
> 
>> In addition, how to learn the source code of QEMU? Are there any guidelines and reference documents?
>>
>> thanks，
>> Byron
>>
>>
>>  
>>
> 
> 


