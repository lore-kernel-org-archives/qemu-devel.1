Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F851C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA7D2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hS5lzMte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA7D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklha-0001Fs-Jg
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jklgN-0000OM-VL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:45:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jklgL-0006cR-M0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592214332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wPYHGoO4CqXANlsjYaA0wi7JY1jGlu8qGNaNIzAKLVU=;
 b=hS5lzMte1EEFGB1sYC/FkvsKKPm3TBq76Va0mUzHx7gpy5I/QNXLOAkFzT4/R2dKunIQvS
 0MEPaUhNR95YmvlSJlDx8VGmR82nNM3HikiK/jsmpHgQOafxMXRRL9iwPetaUV3Z4TqDTw
 6EsrS5cwhoQ2z+qlEYKueWj8WWcgBP0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-L2m1QFy-P06MjPUbAYMZPg-1; Mon, 15 Jun 2020 05:45:20 -0400
X-MC-Unique: L2m1QFy-P06MjPUbAYMZPg-1
Received: by mail-wr1-f72.google.com with SMTP id c14so6805919wrm.15
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wPYHGoO4CqXANlsjYaA0wi7JY1jGlu8qGNaNIzAKLVU=;
 b=mie/TTv0HNstFMOWnd9nBlnUBNsQpMLZG7RYdgXIQJY3wwwBD7G5uU4WAWNMMWKueR
 KpAHfO7CVPcvDRg+zQjCjVwctjVR6ZW3fRlpo/844YWtdTtOIGvTH3qisNWnSyKpAO1w
 AHwgdnXuBtMd7/oMjagH5hWoCtkXYf2oRzuU9cPtZrscwVeQVkl2+/zahzgmaqngE8g9
 mMWjWEbav0lALuB1uo0QPXHXolhkkEF051caeDCULm7BsvPNrshdmWRC0tfuz1K1G85I
 vUiMX/w+yGrqWuTrA0GNPVvEOs0NGP+Wk4hwmyvhGGiAmNyZK91prueONj6ptEwIZMH2
 Ha6A==
X-Gm-Message-State: AOAM532d2KQeH1PMpgoJeXBtoABZCqM7tE0wATG9NeJOwjoj/BJnDOqY
 sUguCKGboU8DJRjUDRVNJSjWw47DJDWlDeZ5DG17/3MGgKITVximlr2QpmNSF/ylzFUxlgf6ueD
 AJr243gkoqM6ejbs=
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr11781374wmk.28.1592214319245; 
 Mon, 15 Jun 2020 02:45:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn+FystiLDSdZvtb92afzanp5cDdPGI+hwQhERDcbUh9bLPMJUYaRW7Lqv+qRdPdvvdEIfcA==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr11781362wmk.28.1592214319037; 
 Mon, 15 Jun 2020 02:45:19 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j16sm28049543wre.21.2020.06.15.02.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 02:45:18 -0700 (PDT)
Subject: Re: KVM call for 2016-06-16
To: quintela@redhat.com, kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
References: <87wo48n047.fsf@secure.mitica>
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
Message-ID: <6324140e-8cc1-074d-8c02-ccce2f48a094@redhat.com>
Date: Mon, 15 Jun 2020 11:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87wo48n047.fsf@secure.mitica>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Hi Juan,

On 6/15/20 11:34 AM, Juan Quintela wrote:
> 
> Hi
> 
> Please, send any topic that you are interested in covering.
> There is already a topic from last call:

This topic was already discussed in the last call :)

> 
> Last minute suggestion after recent IRC chat with Alex Bennée and
> Thomas Huth:
> 
> "Move some of the build/CI infrastructure to GitLab."
> 
> Pro/Con?
> 
>  - GitLab does not offer s390x/ppc64el => keep Travis for these?
> 
> How to coordinate efforts?
> 
> What we want to improve? Priorities?
> 
> Who can do which task / is motivated.
> 
> What has bugged us recently:
> - Cross-build images (currently rebuilt all the time on Shippable)
> 
> Long term interests:
> 
> - Collect quality metrics
>   . build time
>   . test duration
>   . performances
>   . binary size
>   . runtime memory used
> 
> - Collect code coverage
> 
> Note, this is orthogonal to the "Gating CI" task Cleber is working on:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg688150.html
> 
> 
> 
> 
> At the end of Monday I will send an email with the agenda or the
> cancellation of the call, so hurry up.
> 
> After discussions on the QEMU Summit, we are going to have always open a
> KVM call where you can add topics.
> 
>  Call details:
> 
> By popular demand, a google calendar public entry with it
> 
>   https://www.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> 
> (Let me know if you have any problems with the calendar entry.  I just
> gave up about getting right at the same time CEST, CET, EDT and DST).
> 
> If you need phone number details,  contact me privately
> 
> Thanks, Juan.
> 
> 


