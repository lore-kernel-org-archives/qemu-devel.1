Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00102C04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 18:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE95216C4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 18:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ft1lIHnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE95216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPWNN-00063X-Rx
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 14:05:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPWMO-0005bV-5j
	for qemu-devel@nongnu.org; Sat, 11 May 2019 14:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPWMM-0002Rc-WA
	for qemu-devel@nongnu.org; Sat, 11 May 2019 14:04:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPWMM-0002QH-Mq
	for qemu-devel@nongnu.org; Sat, 11 May 2019 14:04:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id w8so8574494wrl.6
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ZkvUf5Hj12cIlJwyquElwcTj+b6mH1VKWrPlAIcigaE=;
	b=ft1lIHnuvXKvWiQP0cqIptIPULMeaQxL2tkqyoA5PNXDXj5QPtyKOZz+yN30sS6tSz
	Us/1W2cE3HNyy0V5OpF4kWH81mtE0uSMvRF3/vpPgPZL7fY9MkrBI2l1s/tVjTivnt5v
	S2uKjzHPisTwWUOv7GxYDRdIOm3CPNrJoadB7xXz3/P8Yg1dnRk2/Su5K/ZtW8gLHrLA
	Xx0BgXGV4NCxD0nNI9bfuWXCPAhB2oB0JiZ9USwkd7ebCVu8p39yt8zvQjbQLpaq0DOZ
	AvsZn0loFDFUiJMF6Qi4r1ACpgk+RspkwGxwicpPVlfeBMYtaoPkYaxhyggZQolvuzHk
	SLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ZkvUf5Hj12cIlJwyquElwcTj+b6mH1VKWrPlAIcigaE=;
	b=KRTUeaswGNkVa1eJrJJLbXYkS2WDWumE0bERHIdOOLCRLdi237OG/na4AGG9ACcvEm
	4YV9VbpJzHi/gq/RH2sjU31sQMvdX+GemSpXy0hA/RF/R5i76XVuA+6TFyWwoiMUA1Ln
	eM2zZVP4SyiuD/tAcBJPtlhpt1gXDd3Hg05S3YKMj6bEFOqXdRM/UP7iqEiiq+DhMINI
	ZF3GAIF2aNb6v0tXVRP4yLMwavDYgd3iE7ckNDpGzZUDeTxTIqTdMGKRtNRf3Qcwdzxq
	pHuZzSOgf6SsW8TAttF9HD9yAPCBr3QNenAPyulahinvPlWjVZDm/qKzBJ9CuetBNVJv
	QCBQ==
X-Gm-Message-State: APjAAAVS+s/FzYZn1cezdmA59xKf1h1TiAX7B39yt6o6hB3EziEGIQFo
	8/iDt1khbV0Nnwm1aRAF2fxr7A==
X-Google-Smtp-Source: APXvYqx/mHLhaB6fjJwz9lAheUPf7Of+MRBWV4e7EWDEDo3FuzOCv5LWhzYZp2BPXzsmIjgK+6ri2w==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr3250352wrn.222.1557597872874; 
	Sat, 11 May 2019 11:04:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id r9sm7013765wrv.82.2019.05.11.11.04.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 11 May 2019 11:04:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 94F381FF87;
	Sat, 11 May 2019 19:04:31 +0100 (BST)
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<CAFEAcA8Dsdp2rnORnzqemWspfFxfhVwkAz=2EXdupo8iDj_=Hw@mail.gmail.com>
	<87tve2b5z2.fsf@zen.linaroharston>
	<CAFEAcA9q9n24wZF9nRM=norAK+tPv9LL4LM4-8gwH8F+0D0umw@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9q9n24wZF9nRM=norAK+tPv9LL4LM4-8gwH8F+0D0umw@mail.gmail.com>
Date: Sat, 11 May 2019 19:04:31 +0100
Message-ID: <87k1ewrhow.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 10 May 2019 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Thu, 9 May 2019 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> >>
>> >> For running system tests we want to be able to re-direct output to a
>> >> file like we do with serial output. This does the wiring to allow us
>> >> to treat semihosting like just another character output device.
>> >>
>> >> diff --git a/qemu-options.hx b/qemu-options.hx
>> >> index 51802cbb266..6aa3a08c2fb 100644
>> >> --- a/qemu-options.hx
>> >> +++ b/qemu-options.hx
>> >> @@ -3975,12 +3975,12 @@ STEXI
>> >>  Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
>> >>  ETEXI
>> >>  DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
>> >> -    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto=
][,arg=3Dstr[,...]]\n" \
>> >> +    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto=
][,chardev=3Did][,arg=3Dstr[,...]]\n" \
>> >>      "                semihosting configuration\n",
>> >>  QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
>> >>  QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)
>> >
>> > As you can see in the docs here, semihosting is supported on
>> > five guest architectures, so we should implement this new
>> > feature for all of them, not just arm.
>>
>> As I've introduced this for testing I see no reason not to add support
>> for other architectures. However I was hoping this is something that
>> could be done organically as other system tests get enabled.
>
> IME transitions done "organically" really means "slowly, and
> nobody ever gets round to actually completing them".
> Semihosting is a user-facing feature, so if we want to add
> the user feature of allowing output to go to a chardev we
> should add it properly, I think.

So a quick review of the current semi output:

  - MIPS
    This has a fairly generalised open/read/write support with special
    handling for open/close on /dev/std[out/err/in]. There is also a
    UHI_plog which currently just printf's to stdout

  - xtensa
    This already has support for a sim_console char device as part of
    the xtensa sim platform. Otherwise the TARGET_SYS_open can open
    paths directly (which I assume could include stdio) which then
    read/write.

  - m68k
    This has the usual open/read/write/close support directly to the
    FD's as well as support for integrating with the gdbstub via
    gdb_do_syscall.

  - lm32
    Although based on the m68k semithosting support it lacks the gdbstub
    integration. It has the usual open/read/write/close stuff.

  - NIOS2
    Again based on the m68k semihosting but looks like it was taken
    later because it retains the gdbsub integration support.

Generally all the other semihosting stuff looks a lot cleaner - probably
an indication of being done later and avoiding some of the warts of the
early arm semihosting code.

One difference with ARM is it has specific calls aside from the
open/read/write/close (WRITEC/WRITE0) which are specifically aimed at
"console" type logging. They don't seem to require an explicit open at
the start and assume you can write to them from the get go.

One question that would need to be answered is should the chardev
support be generalised for all semihosts that can read/write to the
stdio outputs or should we restrict it to the "console" log operations
(xtensa sim, mips plog and ARM)?

--
Alex Benn=C3=A9e

