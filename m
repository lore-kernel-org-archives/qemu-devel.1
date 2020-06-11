Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680DB2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAPSHOB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680DB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNIz-000054-NE
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjNHh-0007W0-PG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:30:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33078)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjNHg-0002Q5-Pc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:30:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id j198so6979404wmj.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kqYKbxGVd/v0esdzhHu/QIYmuJku+0ChCwQhvoX6nes=;
 b=cAPSHOB9pmVhHeXy69FjOR6x0bRM5+CR9r9qBOIXSAUStE6JOsW/1JEeov99kXfHD/
 vhnAsxSvAfIMIEFrlGYmp7g9okPbt4QN/3dU2wQjkhjhAu9CHRI9tAgz/ebwmVvgo/xI
 6ofbpgHU+HhA/VbT5mJMplW1FKNKwU1M5uaBBl4JILB97KKK23FZGTlRGqBnpDuiks/L
 SGXTb/eglnm8i3jvDE52r037QEp87mO1irVA0NaKCbCLm5S6pZxIKJfMAjDw+sdSg1oh
 z1HjD6G6Rb3atgdMWSpaz09rEr10/IkhfvvEMzzfJNYoGbm8XeZp9+mNq5THHSP3LRnd
 4ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kqYKbxGVd/v0esdzhHu/QIYmuJku+0ChCwQhvoX6nes=;
 b=fegK6sogp/b/ksDx9J1wy0zqe5gXKbHKn+EUm8WBcPlTmzl1I3JQajTQx8AZV9ZKrp
 peBxQKMrlhk+mKqDHFjBTSiGLAQNfQi2RtOI9slpmuE9tvt68nVSMUzf8GegzEm1k8FF
 rNANU8R+R89qzFfLHQu9ntx0CJRtX3KJGUkevo8BLK+aMWTRJ9x9MTQRMDoq4SU32WHC
 Cxxr7HXPMVtOng1tiEAwWnqjeJ0pCIaIbit3/zPMiJJud7WoINFB/6OXHCkDymmCVgCT
 udllwFDFFYCVZ4ywMFs5Mnr0fi698vatRphwVMdyCd0gBQWsUCv1qeu03fRwIzdLJpDc
 CQug==
X-Gm-Message-State: AOAM532nQOElzaWfbYWGSfBdNHB7dxtN+RoKVxC9Uvj7BDi5QRRHTEM2
 5DNgS/Iyxx20MSCO6asyQN4=
X-Google-Smtp-Source: ABdhPJx6aPkrIBoL4yt0v18PoM699bP9DMImLT4vKKkZuHfNStiO55B7lkn3s58XC57NBrFfN/SyHQ==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr8525625wmg.181.1591882213701; 
 Thu, 11 Jun 2020 06:30:13 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm4015660wmc.0.2020.06.11.06.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 06:30:12 -0700 (PDT)
Subject: Re: [PULL 00/16] SPARC patches for 2020-06-09
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20200609073214.14079-1-f4bug@amsat.org>
 <da5851a4-953b-8915-7bc8-37c20a23805f@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c2cfa843-ca76-8aa7-7b74-1ad261222c3e@amsat.org>
Date: Thu, 11 Jun 2020 15:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <da5851a4-953b-8915-7bc8-37c20a23805f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 10:55 PM, Mark Cave-Ayland wrote:
> On 09/06/2020 08:31, Philippe Mathieu-Daudé wrote:
> 
>> Hi Peter,
>>
>> These are the latest SPARC patches sent to the list.
>>
>> This pull request is with authorization of Artyom and Mark:
>> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710154.html
>> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710156.html
>>
>> Frederic doesn't have his GPG key signed:
>> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg706509.html
>>
>> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-=
>> request' into staging (2020-06-08 11:04:57 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/philmd/qemu.git tags/sparc-next-20200609
>>
>> for you to fetch changes up to 86e8c353f705f14f2f2fd7a6195cefa431aa24d9:
>>
>>   target/sparc/int32_helper: Extract and use excp_name_str() (2020-06-09 09:2=
>> 1:10 +0200)
>>
>> ----------------------------------------------------------------
>> SPARC patches
>>
>> HW:
>> - Use UNIMP device instead of EMPTY_SLOT
>> - Make EMPTY_SLOT similar to UNIMP device
>> - Map UART devices unconditionally
>> - Pair of fixes for AHB PnP
>> - Add trace events to AHB PnP
>>
>> TCG:
>> - Improve exception logging
>>
>> CI:
>> - https://gitlab.com/philmd/qemu/-/pipelines/154231191
>> - https://travis-ci.org/github/philmd/qemu/builds/696321130
>>
>> ----------------------------------------------------------------
>>
>> Philippe Mathieu-Daud=C3=A9 (16):
>>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
>>   hw/misc/empty_slot: Lower address space priority
>>   hw/misc/empty_slot: Convert 'size' field as qdev property
>>   hw/misc/empty_slot: Add a 'name' qdev property
>>   hw/misc/empty_slot: Convert debug printf() to trace event
>>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
>>   hw/misc/empty_slot: Name the slots when created
>>   hw/sparc/leon3: Map the UART device unconditionally
>>   hw/sparc64/niagara: Map the UART device unconditionally
>>   hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE definition
>>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>     registers
>>   hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>>   hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>   hw/timer/grlib_gptimer: Display frequency in decimal
>>   target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>   target/sparc/int32_helper: Extract and use excp_name_str()
>>
>>  include/hw/empty_slot.h        |  9 -------
>>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
>>  hw/mips/malta.c                |  4 +--
>>  hw/{core =3D> misc}/empty_slot.c | 47 +++++++++++++++++++---------------
>>  hw/misc/grlib_ahb_apb_pnp.c    | 24 +++++++++++++++--
>>  hw/sparc/leon3.c               | 18 ++++++-------
>>  hw/sparc/sun4m.c               | 23 +++++++++++------
>>  hw/sparc64/niagara.c           |  7 ++---
>>  target/sparc/int32_helper.c    | 23 +++++++++--------
>>  MAINTAINERS                    |  7 +++++
>>  hw/core/Makefile.objs          |  1 -
>>  hw/misc/Makefile.objs          |  1 +
>>  hw/misc/trace-events           |  8 ++++++
>>  hw/sparc/Kconfig               |  1 +
>>  hw/timer/trace-events          |  2 +-
>>  15 files changed, 124 insertions(+), 70 deletions(-)
>>  delete mode 100644 include/hw/empty_slot.h
>>  create mode 100644 include/hw/misc/empty_slot.h
>>  rename hw/{core =3D> misc}/empty_slot.c (66%)
>>
>> --=20
>> 2.21.3
> 
> Philippe, thanks so much for handling this - things are really busy here at the
> moment, so the help is greatly appreciated :)

I know you were busy, and the patches are just cleanups, so no problem.

Before sending, I tested with all the images I could grab from
https://wiki.qemu.org/Documentation/Platforms/SPARC
and
https://www.qemu.org/docs/master/system/target-sparc64.html

I might add more acceptance tests later to automate that.

Regards,

Phil.

