Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E356C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C650D20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWZJO1AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C650D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0yI-00052D-Q9
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0xQ-0003xg-9N
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0xN-0006F5-9a
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601567839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lLhgaKsAuj+WKn4W+SZti0pTbhlGxZy5ViL6pDcCLoA=;
 b=PWZJO1AEkhA2JrDzzYqRyS79trwiK71v4plYBBIObmD4D9uHNEraSi14xq6Z/f5RGm+ZqJ
 S9ZsDvfdjZB0zik6P4owzpyrBM/mKq5tmLvW4oPdQ7bHrVroo0nLhTeieeWm1AnRLsk7l6
 NKGM4LmQfq67+N+p1cZgLDTu5pFLVcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-s3YCCS9kPNuRWVFnxJ11Dg-1; Thu, 01 Oct 2020 11:57:17 -0400
X-MC-Unique: s3YCCS9kPNuRWVFnxJ11Dg-1
Received: by mail-wm1-f70.google.com with SMTP id b14so1050190wmj.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lLhgaKsAuj+WKn4W+SZti0pTbhlGxZy5ViL6pDcCLoA=;
 b=hGT0iu7elJPDV0cFP95/VAgd13Rfmrg5M7Kfglp8Bgc/clxhmvg560brvHRgFE4vQk
 hRBXkTNhu7z2AYnAWoROu7Mdp6+a67G0TG5vjsLBMWZTtj4g1m9DvMfO17mdX9/iwFXy
 3yNwIbq+VZD/gy9XsRyPnQtrp8YHH3QvMxY25G084CC2eSTPZW9C9TyC9Z0ZXECH9nA3
 MGIX5epmG8RTGZL7simJdZ6wdSZ1F0jeUsv1SKYrUjPPSsB/IgZstNX+hYwYX+V6eWmx
 IkO+3UU97SO4CCizJQbmpqpSPr6JUFbBujDocVhhi38NXLCLZJxYqpCnaBnDuvDs3951
 4O5Q==
X-Gm-Message-State: AOAM530pz8qlzwL0n/d2HlBvvvGd+tfxNlwoYCuye73a8XnnsfBElIug
 n1og2Vf8AqrmzzishXk/M3melMm+Ptx4618T/eDw+t88t3Rv5/rEnQIpWDs9TGTNTaTvvNWmdXh
 TrSPehvr0t4mFEkg=
X-Received: by 2002:adf:9e05:: with SMTP id u5mr9727480wre.78.1601567836535;
 Thu, 01 Oct 2020 08:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQEO+Y5GSTTvkuXghNOAb2mRIpDjMduEfLv4gfNel/GPq/wqac1HqmXRMEmQe/hIdZKcZvmA==
X-Received: by 2002:adf:9e05:: with SMTP id u5mr9727448wre.78.1601567836269;
 Thu, 01 Oct 2020 08:57:16 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k15sm10196060wrv.90.2020.10.01.08.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:57:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] target/i386/cpu: Restrict some of feature-words
 uses to system-mode
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-3-philmd@redhat.com>
 <933089b7-a088-d142-bf0c-55cae3e9bd70@redhat.com>
 <53758e35-f596-8e17-12cf-58b1a81f98e3@redhat.com>
 <20201001153725.GD3717385@habkost.net>
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
Message-ID: <0766785b-29a5-b145-2685-781fbee86add@redhat.com>
Date: Thu, 1 Oct 2020 17:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001153725.GD3717385@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 5:37 PM, Eduardo Habkost wrote:
> On Thu, Oct 01, 2020 at 05:27:32PM +0200, Philippe Mathieu-Daudé wrote:
>> On 10/1/20 5:14 PM, Paolo Bonzini wrote:
>>> On 01/10/20 16:41, Philippe Mathieu-Daudé wrote:
>>>> The feature-words properties are not used in user-mode emulation,
>>>> restrict it to system-mode.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>
>>> This seems a bit pointless honestly.  It's going to be a few KBs of code
>>> at most.  I would end the work with the patches that have already been
>>> queued.
>>
>> I'll let Eduardo and you discuss that, as he suggested the #ifdef
>> instead of the stub. The two options are on the list, whichever
>> you guys prefer :)
> 
> Having neither the stub or the #ifdef is even better.  :)
> 
> I assumed the stub was necessary as a means for an end, but now I
> don't understand why the stub was necessary in the first place.

x86_cpu_get_feature_words() calls QAPI-generated
visit_type_X86CPUFeatureWordInfoList().

Since "Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors", this code is unreachable on user-mode.

I tried to get a "no ifdef/no stub" codebase by not removing the
QAPI uses from user-mode code, and build it without QAPI-generated
files. I could only start the work and realized it is a huge effort.
In particular since nobody sees the point of doing this cleanup...

Regards,

Phil.


