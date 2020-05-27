Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7249C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16482084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddcarAVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16482084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyuj-00031T-Tc
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdyuA-0001ue-LT
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdyu8-0000el-Pt
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590596863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ALSuv+5kXS7HH0hlWY4qxf/Fg25cinI9XLLLOWDBbII=;
 b=ddcarAVrytJQlj/el5LuiI7CKYBlWxyuY6I3l5T4txqYr5+CR0ae1JsYi87s8Pu9XqS6UO
 jPhbqE9frHaaiD/44io9oMtPjF8eLYIFh+359DHYMD4twFjv3+UbTBbH4WIps2qqK69unY
 SqOIYLHfzdwfgQeu7+1Ly5tnt24VuxE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-bDuEcyXoN625yScQRFl2aA-1; Wed, 27 May 2020 12:27:42 -0400
X-MC-Unique: bDuEcyXoN625yScQRFl2aA-1
Received: by mail-ej1-f69.google.com with SMTP id f17so9123327ejc.7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ALSuv+5kXS7HH0hlWY4qxf/Fg25cinI9XLLLOWDBbII=;
 b=E5Tauj2yh7ty2JKJKoikGYOz+hVof7YnuFWjk0oCuItlszQCwNcZ5LGzkOIUt1KOo3
 MV9Cya1zDs8HdfLNHn1pDGuhSoABbGrbDcFjUWf3kKvhmteiQ9CkXG6kxEbqSChjqodd
 R7U57QvWI6AISO1s0H9W57d5ZsyzTbkRGLgjVZEbtC/7eUt+8iPbmr0jr8todVDiwNEk
 Aut5sPQd5eif/zlARjN39hUBcvmnMdc9U2zwMhfGgrGQVO/sz3vZhXFwTACwQi8CE9my
 3eheHmG7PKzapBK2FUy+bkBd+Kv9WNaX2f8kwCX7NtjSXonWpciE8xFOrgkkdrVrTOG4
 mb5Q==
X-Gm-Message-State: AOAM5305qwCua7B/fOWSf9uAvrb7R1mMUtMLAz8u0MPK0v8PEloZ0AZU
 Ctj3ExAf12VVSQIvxZauYOkHAhFUPAmtQg442Jmxs/x1KBrYjIfy/LprxNJyWhGnEbFW50vVEsD
 8azTsYK9YRzBw/V0=
X-Received: by 2002:a50:f18f:: with SMTP id x15mr7377649edl.228.1590596860782; 
 Wed, 27 May 2020 09:27:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXGIezUJP5wxQC/3ees+Dt4YulD8Du4rqPCmi1/IBgGBk/xSJlbeHn7Zh8ynMJaK2NMcYPvw==
X-Received: by 2002:a50:f18f:: with SMTP id x15mr7377631edl.228.1590596860581; 
 Wed, 27 May 2020 09:27:40 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id cm26sm2483017edb.87.2020.05.27.09.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 09:27:39 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
To: Peter Xu <peterx@redhat.com>
References: <20200526173542.28710-1-philmd@redhat.com>
 <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
 <24f88212-9b32-b6dc-fcd4-685cde8bf5d7@redhat.com>
 <864ac8ab-e21e-393e-d1eb-08b3c4579bbf@redhat.com>
 <20200527161603.GF1194141@xz-x1>
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
Message-ID: <3e364895-e5e5-09fe-ee8c-782f3632e2b8@redhat.com>
Date: Wed, 27 May 2020 18:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527161603.GF1194141@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 6:16 PM, Peter Xu wrote:
> On Wed, May 27, 2020 at 05:53:16PM +0200, Philippe Mathieu-Daudé wrote:
>>>>> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
>>>>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
>>>>> +            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].name);
>>>> Just wondering why you want to trace the type as you now have the name
>>>> string.
>>>
>>> You are right :)
>>>
>>>>> +            return iommu[i].type;
>>>>>          }
>>>>>      }
>>>>> +    trace_vfio_get_iommu_type(-1, "Not available or not supported");
>>>> nit: from a debugging pov, this may be not needed as
>>>> vfio_get_group/vfio_connect_container() fails and this leads to an error
>>>> output.
>>
>> But you can reach this for example using No-IOMMU. If you don't mind, I
>> find having this information in the trace log clearer.
> 
> I kinda agree with Eric - AFAICT QEMU vfio-pci don't work with no-iommu, then
> it seems meaningless to trace it...
> 
> I'm not sure whether this trace is extremely helpful because syscalls like this
> could be easily traced by things like strace or bpftrace as general tools (and
> this information should be a one-time thing rather than dynamically changing),
> no strong opinion though.  Also, if we want to dump something, maybe it's
> better to do in vfio_init_container() after vfio_get_iommu_type() succeeded, so
> we dump which container is enabled with what type of iommu.

OK. I'm a recent VFIO user so maybe I am not using the good information.

This trace helps me while working on a new device feature, I didn't
thought about gathering it in a production because there I'd expect
things to work.

Now in my case what I want is to know is if I'm using a v1 or v2 type.
Maybe this information is already available in /proc or /sys and we
don't need this patch...


