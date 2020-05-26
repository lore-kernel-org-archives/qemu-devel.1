Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CDEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B436207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+nXypRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B436207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZWN-000091-Ht
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZVJ-0007yA-O1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:20:25 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZVI-0003tz-Ql
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:20:25 -0400
Received: by mail-ed1-x543.google.com with SMTP id be9so17624355edb.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zNS5pllvNuW6vOVdMC3Q5yI0uFFsp0HH+3GKgpUmxdU=;
 b=s+nXypRJ7Z8T7wXT1s+ua79V8A5+OjIek2b3UJwput8Pc/eF1fwS23GxaFAyTEDRKD
 IAuriZ486HjLvg/CFsvrD/WVR1glZaAGHnCLCyzhqYo3Ts8GlJJ8BIyFQgAFOslGOxnu
 wBBT9VSM+oLv6dAPFGlmkzYWl9ioH+3O6ae2kYuSIc54cFsWve2vTUUuXxb+K/lXngVj
 +S3A1j1hg5gDUPCXj2x4zb7fb2meY94PfR9Ikc9gEno8w8csLC58nx750GdnTJ5o1tzt
 3uxu7BTJVPDXlhpoAFvSi7tsqn7m+InMvsZt1DQ5sO0y08ZDZmKji9DJqsKslJIZjo7Y
 K3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zNS5pllvNuW6vOVdMC3Q5yI0uFFsp0HH+3GKgpUmxdU=;
 b=GrNrbBeqPUeP3A6WxYNGkhOMOC4dPE2nN3991WBG43u6brSJ0AuDEOZYd9zZcOQqTv
 Ps/uNy9u7sd4JeXVTUgeFrB671p9X00mGr0sr+EeJ93zTDpVMkOfAROfoottwExo3/aD
 kjQS5bJD70b53aspvCPXqFiVxE7Sr4DTMxA2iqYFl4sEPX+m4WIuFcRi5XeB16qRd4pC
 57gX0/2zYxhGG/hDfDPs3a2T0UkrERRQNqHoPgy6iUwnSY91iwRkd2Cz948GBcamJ0PK
 8Rl3tiAfage5BTeiw73CEt+2+0yygSSBJTO061YCSqFS9tlTdG8qrxYYb7P0MHZrFDYF
 bSpQ==
X-Gm-Message-State: AOAM532qwB8Ea3Dq8pQwYtUMb/q6EZGTURrCxF7fuRNSM4CLIk6KATdh
 2fP7py+GlcbMCUberoVyQvc=
X-Google-Smtp-Source: ABdhPJzsarsnjbLkDtQIat1CcnhBLE01u40rFcIDtUjk3clSVc/zFDzgk/rAcWJv35WLntjzQlDvJA==
X-Received: by 2002:a05:6402:cb1:: with SMTP id
 cn17mr19462007edb.382.1590499223303; 
 Tue, 26 May 2020 06:20:23 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id f13sm19065735edk.36.2020.05.26.06.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 06:20:22 -0700 (PDT)
Subject: Re: [PATCH 00/14] hw/mips: patch queue for 2020-05-26
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200526104726.11273-1-f4bug@amsat.org>
 <CAHiYmc7_Td7hCPbkboMUZpy5HQH47DR1Jh-ux9t7MW+kt=o6Eg@mail.gmail.com>
 <CAHiYmc5ir9JDULc2ssNLx+DQZ7jm7oY_UxYiotHV4Yh+pJH7vw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d343aa59-625e-28c4-315d-aab79d668a95@amsat.org>
Date: Tue, 26 May 2020 15:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5ir9JDULc2ssNLx+DQZ7jm7oY_UxYiotHV4Yh+pJH7vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhc@lemote.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 3:14 PM, Aleksandar Markovic wrote:
> уто, 26. мај 2020. у 13:06 Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> је написао/ла:
>>
>> уто, 26. мај 2020. у 12:47 Philippe Mathieu-Daudé <f4bug@amsat.org> је
>> написао/ла:
>>>
>>> Hi,
>>>
>>> This is the current state of my hw/mips/next tree.
>>>
>>> - MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
>>>   and update Aleksandar Rikalo's email address,
>>>
>>> - Trivial improvements in the Bonito64 North Bridge and the
>>>   Fuloong 2e machine,
>>>
>>> - MIPS Machines names unified without 'mips_' prefix.
>>>
>>> The following patches need review:
>>>
>>> - #6  "hw/pci-host/bonito: Map the different PCI ranges more detailled"
>>> - #10 "hw/mips/fuloong2e: Fix typo in Fuloong machine name"
>>>
>>
>> I agreed with these two patches, thanks for your help, patch 6 looks
>> much better now.
>>
>> Hope you will be able to send pull request sooner rather than later.
>> Please work with Gerd to speed up the process, resolving the
>> dependencies efficiently.
>>
> 
> Hi, Gerd,
> 
> My understanding is that a rather trivial issue (removing an #include)
> from a mips-specific file, makes your potential pull request, and this
> Philippe's pull request dependent between themself. I think actually
> Philippe is waiting for your pull request to be sent and applied.
> Could you update us on the planned timing of your pull request?

Don't worry, Gerd sent his pullreq and Peter is testing it. I'm waiting
Peter's testing done to rebase/send. No hurry anyway ;)

> 
> Thanks,
> Aleksandar
> 
> P.S Too bad such trivial issues from time to time cause stalls in our
> workflows, but I guess it is sometimes unavoidable, and we have to
> live with that.
> 
> 
>> Yours,
>> Aleksandar
>>
>>
>>
>>
>>> Aleksandar Markovic (3):
>>>   hw/mips: Rename malta/mipssim/r4k/jazz files
>>>   hw/mips/malta: Add some logging for bad register offset cases
>>>   MAINTAINERS: Change Aleksandar Rikalo's email address
>>>
>>> Huacai Chen (1):
>>>   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
>>>
>>> Philippe Mathieu-Daudé (10):
>>>   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
>>>   hw/pci-host/bonito: Fix DPRINTF() format strings
>>>   hw/pci-host/bonito: Map peripheral using physical address
>>>   hw/pci-host/bonito: Map all the Bonito64 I/O range
>>>   hw/pci-host/bonito: Map the different PCI ranges more detailled
>>>   hw/pci-host/bonito: Better describe the I/O CS regions
>>>   hw/pci-host/bonito: Set the Config register reset value with
>>>     FIELD_DP32
>>>   hw/mips/fuloong2e: Move code and update a comment
>>>   hw/mips/fuloong2e: Fix typo in Fuloong machine name
>>>   hw/mips/mips_int: De-duplicate KVM interrupt delivery
>>>
>>>  docs/system/deprecated.rst               |  5 ++
>>>  docs/system/target-mips.rst              |  2 +-
>>>  default-configs/mips64el-softmmu.mak     |  2 +-
>>>  hw/isa/vt82c686.c                        |  2 +-
>>>  hw/mips/{mips_fulong2e.c => fuloong2e.c} | 48 ++++++-------
>>>  hw/mips/{mips_jazz.c => jazz.c}          |  0
>>>  hw/mips/{mips_malta.c => malta.c}        | 14 ++--
>>>  hw/mips/mips_int.c                       | 11 +--
>>>  hw/mips/{mips_mipssim.c => mipssim.c}    |  0
>>>  hw/mips/{mips_r4k.c => r4k.c}            |  0
>>>  hw/pci-host/bonito.c                     | 87 +++++++++++++++++++-----
>>>  tests/qtest/endianness-test.c            |  2 +-
>>>  .mailmap                                 |  3 +-
>>>  MAINTAINERS                              | 26 +++----
>>>  hw/mips/Kconfig                          |  3 +-
>>>  hw/mips/Makefile.objs                    | 10 +--
>>>  hw/pci-host/Kconfig                      |  5 ++
>>>  hw/pci-host/Makefile.objs                |  2 +-
>>>  18 files changed, 142 insertions(+), 80 deletions(-)
>>>  rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)
>>>  rename hw/mips/{mips_jazz.c => jazz.c} (100%)
>>>  rename hw/mips/{mips_malta.c => malta.c} (99%)
>>>  rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
>>>  rename hw/mips/{mips_r4k.c => r4k.c} (100%)
>>>
>>> --
>>> 2.21.3
>>>
> 

