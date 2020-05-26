Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F88BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374742068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaCph69E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374742068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZtD-0008TY-FX
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZn0-0001UW-HY
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:38:42 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZmz-0007Ys-Lg
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:38:42 -0400
Received: by mail-ej1-x642.google.com with SMTP id h21so23851262ejq.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s5CBopJZnvfibCq+ilG9571o+ICq6OtGHBFCGWSJyWk=;
 b=YaCph69EY+0awUAPYPsmKZvAXSJU0PL4vAA1yrpI9kRJ2dgn8fkNRp3Rz4kbPMGCWp
 BjT0+f2h63su7wHzibBArBjRcj9N+7xH3NWEwk71b7MoEg9pE3+TEIB0KjDijk7tM6s6
 QQThieC4Eux3kMQO2oDiJOopL4l2t1CSUJ5Z36l/ZBnfNJrhAsf8JVemOKl3RP4w9fgL
 nGFaMldF+LDOeKBqtEURKf71KH7UeZsGsH4SrRNwFwgG9Aw9SDZqVk0NY1gUBryzgptb
 tmp+2O/rvrCD9oSbnSwS7ZIBF2PAanirfkhxgsd2Lhvo66bmOcz5AEmVI+jVlVar6fb0
 Tzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s5CBopJZnvfibCq+ilG9571o+ICq6OtGHBFCGWSJyWk=;
 b=S3wMVsMyI55egXIw5/CU7CMwlsf3gP4dPh1YTOMJRjdpeGAcht1rdRW/Lc2cO5wHKR
 omv8EcjxpPbWtwjTpnok5dkpMwJ+P+IDhxAbDcTZ7lYY/g/qnJMNifr5/25W74TFcKtD
 eHQXrrOGpiboQz4UlGWfznDm3Nl6w7Hph9G9ivIXNbAd75mmzApiaoc0uPuEUM8EaYvv
 JrHjRm4foQ/9rtV3PofIN3gAZt1XCaBZk5kkIr/pVvUn9VMqskyvzssPOpAZB2vyjAeQ
 TZojMa7TsYHloQWpiHxTVpMXVRZz23MKIkfJMdik0TlHQYrMbHP2rhuxFfqrC8vpMFab
 pzPg==
X-Gm-Message-State: AOAM530QQ+2ibUZbCbfWypWeDzTr1JxEk9TaAHHUh3j34zA+ngUF6dhy
 7ZPsCEQo/quhQQgdPbu1Cxs=
X-Google-Smtp-Source: ABdhPJxiHPABUGxI2DcHajMaS+JTMpuEWEMio6xQsJ1ioIojS880Rml6KiGc/ZrLJf/9H7RoGyxHjA==
X-Received: by 2002:a17:906:13ca:: with SMTP id
 g10mr1167577ejc.493.1590500319870; 
 Tue, 26 May 2020 06:38:39 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b14sm18260962edx.93.2020.05.26.06.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 06:38:37 -0700 (PDT)
Subject: Re: [PATCH 00/14] hw/mips: patch queue for 2020-05-26
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200526104726.11273-1-f4bug@amsat.org>
 <CAHiYmc7_Td7hCPbkboMUZpy5HQH47DR1Jh-ux9t7MW+kt=o6Eg@mail.gmail.com>
 <CAHiYmc5ir9JDULc2ssNLx+DQZ7jm7oY_UxYiotHV4Yh+pJH7vw@mail.gmail.com>
 <d343aa59-625e-28c4-315d-aab79d668a95@amsat.org>
 <CAHiYmc43oy4N++bZeTzB93Uk09eYtmcvKJNSnDtzgoFd6m6zbg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <98af6a40-f041-48bb-294f-60da6a222c81@amsat.org>
Date: Tue, 26 May 2020 15:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc43oy4N++bZeTzB93Uk09eYtmcvKJNSnDtzgoFd6m6zbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 3:29 PM, Aleksandar Markovic wrote:
> уто, 26. мај 2020. у 15:20 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> On 5/26/20 3:14 PM, Aleksandar Markovic wrote:
>>> уто, 26. мај 2020. у 13:06 Aleksandar Markovic
>>> <aleksandar.qemu.devel@gmail.com> је написао/ла:
>>>>
>>>> уто, 26. мај 2020. у 12:47 Philippe Mathieu-Daudé <f4bug@amsat.org> је
>>>> написао/ла:
>>>>>
>>>>> Hi,
>>>>>
>>>>> This is the current state of my hw/mips/next tree.
>>>>>
>>>>> - MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
>>>>>   and update Aleksandar Rikalo's email address,
>>>>>
>>>>> - Trivial improvements in the Bonito64 North Bridge and the
>>>>>   Fuloong 2e machine,
>>>>>
>>>>> - MIPS Machines names unified without 'mips_' prefix.
>>>>>
>>>>> The following patches need review:
>>>>>
>>>>> - #6  "hw/pci-host/bonito: Map the different PCI ranges more detailled"
>>>>> - #10 "hw/mips/fuloong2e: Fix typo in Fuloong machine name"
>>>>>
>>>>
>>>> I agreed with these two patches, thanks for your help, patch 6 looks
>>>> much better now.
>>>>
>>>> Hope you will be able to send pull request sooner rather than later.
>>>> Please work with Gerd to speed up the process, resolving the
>>>> dependencies efficiently.
>>>>
>>>
>>> Hi, Gerd,
>>>
>>> My understanding is that a rather trivial issue (removing an #include)
>>> from a mips-specific file, makes your potential pull request, and this
>>> Philippe's pull request dependent between themself. I think actually
>>> Philippe is waiting for your pull request to be sent and applied.
>>> Could you update us on the planned timing of your pull request?
>>
>> Don't worry, Gerd sent his pullreq and Peter is testing it. I'm waiting
>> Peter's testing done to rebase/send. No hurry anyway ;)
>>
> 
> Peter accepted Gerd's pull request 17 mins ago.
> 
> There is a hurry, Philippe, because, some other pending series needs
> to be rebased because of file name changes in this series, and I
> really would not like to prolong and complicate your efforts in case
> we clash with some other pull request over such trivial stuff. i
> advice you to send a pull request as soon as you do your regular
> preparation and tests - I would really appreciate today, if possible.

Sorry I took a 30min break to eat something for lunch.

The pull request is now sent, thanks for your patience.

Regards,

Phil.

> Thanks for for your involvement, and meticulousness regarding all
> patches in this series and future pull request!
> 
> Aleksandar
> 
> 
>>>
>>> Thanks,
>>> Aleksandar
>>>
>>> P.S Too bad such trivial issues from time to time cause stalls in our
>>> workflows, but I guess it is sometimes unavoidable, and we have to
>>> live with that.
>>>
>>>
>>>> Yours,
>>>> Aleksandar
>>>>
>>>>
>>>>
>>>>
>>>>> Aleksandar Markovic (3):
>>>>>   hw/mips: Rename malta/mipssim/r4k/jazz files
>>>>>   hw/mips/malta: Add some logging for bad register offset cases
>>>>>   MAINTAINERS: Change Aleksandar Rikalo's email address
>>>>>
>>>>> Huacai Chen (1):
>>>>>   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
>>>>>
>>>>> Philippe Mathieu-Daudé (10):
>>>>>   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
>>>>>   hw/pci-host/bonito: Fix DPRINTF() format strings
>>>>>   hw/pci-host/bonito: Map peripheral using physical address
>>>>>   hw/pci-host/bonito: Map all the Bonito64 I/O range
>>>>>   hw/pci-host/bonito: Map the different PCI ranges more detailled
>>>>>   hw/pci-host/bonito: Better describe the I/O CS regions
>>>>>   hw/pci-host/bonito: Set the Config register reset value with
>>>>>     FIELD_DP32
>>>>>   hw/mips/fuloong2e: Move code and update a comment
>>>>>   hw/mips/fuloong2e: Fix typo in Fuloong machine name
>>>>>   hw/mips/mips_int: De-duplicate KVM interrupt delivery
>>>>>
>>>>>  docs/system/deprecated.rst               |  5 ++
>>>>>  docs/system/target-mips.rst              |  2 +-
>>>>>  default-configs/mips64el-softmmu.mak     |  2 +-
>>>>>  hw/isa/vt82c686.c                        |  2 +-
>>>>>  hw/mips/{mips_fulong2e.c => fuloong2e.c} | 48 ++++++-------
>>>>>  hw/mips/{mips_jazz.c => jazz.c}          |  0
>>>>>  hw/mips/{mips_malta.c => malta.c}        | 14 ++--
>>>>>  hw/mips/mips_int.c                       | 11 +--
>>>>>  hw/mips/{mips_mipssim.c => mipssim.c}    |  0
>>>>>  hw/mips/{mips_r4k.c => r4k.c}            |  0
>>>>>  hw/pci-host/bonito.c                     | 87 +++++++++++++++++++-----
>>>>>  tests/qtest/endianness-test.c            |  2 +-
>>>>>  .mailmap                                 |  3 +-
>>>>>  MAINTAINERS                              | 26 +++----
>>>>>  hw/mips/Kconfig                          |  3 +-
>>>>>  hw/mips/Makefile.objs                    | 10 +--
>>>>>  hw/pci-host/Kconfig                      |  5 ++
>>>>>  hw/pci-host/Makefile.objs                |  2 +-
>>>>>  18 files changed, 142 insertions(+), 80 deletions(-)
>>>>>  rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)
>>>>>  rename hw/mips/{mips_jazz.c => jazz.c} (100%)
>>>>>  rename hw/mips/{mips_malta.c => malta.c} (99%)
>>>>>  rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
>>>>>  rename hw/mips/{mips_r4k.c => r4k.c} (100%)
>>>>>
>>>>> --
>>>>> 2.21.3
>>>>>
>>>
> 

