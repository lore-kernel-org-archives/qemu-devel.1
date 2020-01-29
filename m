Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6530C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ABE20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8h/eccI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ABE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwp1b-00053M-M6
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwp0g-0004Dh-VC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwp0e-0004FY-JI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:12:06 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:44695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwp0e-0004EJ-ES
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:12:04 -0500
Received: by mail-ot1-x336.google.com with SMTP id h9so15800428otj.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mn8OQEQfS5YThuazY6hWrbt3SGKdbXtJqISyUPCNmgI=;
 b=K8h/eccIPEN2Wm9B8330KjGkQkPTaarLTFjNNEBYExSRv6uAHwsBTxFGVPJWQE5JaH
 5//z8RMl43iTh7MPXUBOkIYsM995/zNSy1qukBsOLfL1T4CoweLbHFYdK9bTFGbLefqn
 4HOYyD0/olrLCwll9Zmh4dAPg5SDv5OHt1HimEvB9eEqaI6fSP45KD0XNaqHdRlCQOEg
 MgLc/PkTEthliTi0OWN6bnTkXJ0IUAXciCLWmbkiQQHIECgiInCuZtEfTYEkpM/DQTIb
 FGNfZLSgX5bIg/FNtKdhC8wtmREBdQkY+DRIOYRuXzfdN46T44w/LENQONlXAOrjm0hR
 pyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mn8OQEQfS5YThuazY6hWrbt3SGKdbXtJqISyUPCNmgI=;
 b=N7+9EYf3CIQlFSzkCornCK6pvLaeoe8Qot718QOxJSbjiJ6KzLzJHqV4M2xYiAdjuc
 id5lZLSWZS51ZN50zER+MKxI9dBG+eji9SVl1rJ9FmH265syls0JfJKLtpkqf/ynID+K
 tJdP4SefjoHIakE7BIfzD5NB4NegMsuikR5RKlTT66oTbXvqMY7hG63Qt3taq9Fjlbob
 /99JSKRt8zx8YvalyGu5QWLgwOJ/FlrA243sHxdxl2Dnaz+wyKb/joY1330Tgg9rz/A/
 IJ0S7i1zIIQASfD2O6UH1ORp5LI/lKqfPWUBdHvyi2gYk4/Zc/ijeJQWmbyKzZS8PNap
 bSBg==
X-Gm-Message-State: APjAAAWdVf1AIgzEwiN33oY+hgxtPyKG0Cfgrbb8TaTsaKDR7u6lg848
 v10Znqj91zHDQQDhGsvqVL1cDgxpK4Ix/UkuGKM=
X-Google-Smtp-Source: APXvYqzeGxBfZWS9BA0Jma4z3qrYrYJd8ILIEKFO4bxParr/64CMTpfiHJBJBsGlDg2Jq/NtFSGi/FU8iQjfxAesk74=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr20607948otp.306.1580310722722; 
 Wed, 29 Jan 2020 07:12:02 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200129122058.3714c0c4195afc62fc0ce297@kent.ac.uk>
In-Reply-To: <20200129122058.3714c0c4195afc62fc0ce297@kent.ac.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 Jan 2020 16:11:51 +0100
Message-ID: <CAL1e-=g=6zXB6pW4XYJ_NXYe4tu43N4DSUBPw=tJPqT1WvKCqg@mail.gmail.com>
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
To: Sarah Harris <seh53@kent.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "S.Harris" <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 1:20 PM Sarah Harris <seh53@kent.ac.uk> wrote:
>
> Hi,
>
> I think I've found a minor bug: the stack pointer should be initialised to the size of SRAM in some or most cases.
> Currently, SP is initialised to zero.
>

Very good (that you spotted the bug)!

> It seems modern AVRs set SP to the size of SRAM (RAMEND) at power-on, though a few older ones initialise to zero.
> The ATmega328 (from 2009) [1], ATmega2560 (from 2005) [2], ATtiny2313 (from 2003) [6], and ATtiny85 (from 2005) [3] all use RAMEND.
> The ATmega8 (from 2001) [4], ATmega8535 (from 2002) [5], and AT90S8535 (from 1998) [7] use zero.

It looks we'll have tremendous "fun" dealing with huge variety of AVR SoCs.

> I haven't found a list of which AVRs use which value (other than reading every datasheet).

Yes, I find this to be a big practical problem, this glaring lack of
some summary documentation, and, unfortunately, this affects not only
this particular case (SP initialization). It appears to me that for
many features and details (especially regarding SoC devices) one will
have to carefully examine multiple documents, as you did in this
email.

>
> Given that GCC performs this initialisation in software anyway (so what the hardware does doesn't matter), I think this is a minor issue.
> It will only affect hand written assembly programs that don't do their own initialisation (which seems to be discouraged as not all resets are power-on events).
> I'm not sure what, if anything, needs to be done about it but it might be worth fixing now we're emulating specific chips.
>

Let's think a little bit about it. In my honest opinion, this may be
handled after the series merge, and if you guys agree, there is no
rush.

> Kind regards,
> Sarah Harris
>

Thanks!
Aleksandar

> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf (section 6.5.1)
> [2] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf (section 7.6)
> [3] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf (section 4.6.1)
> [4] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2486-8-bit-AVR-microcontroller-ATmega8_L_datasheet.pdf (page 13)
> [5] http://ww1.microchip.com/downloads/en/DeviceDoc/doc2502.pdf (page 12)
> [6] http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2543-AVR-ATtiny2313_Datasheet.pdf (page 11)
> [7] http://ww1.microchip.com/downloads/en/DeviceDoc/doc1041.pdf (page 20)
>
> On Sun, 26 Jan 2020 23:54:43 +0100
> Aleksandar Markovic <aleksandar.markovic@rt-rk.com> wrote:
>
> > +static void avr_cpu_reset(CPUState *cs)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(cs);
> > +    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    mcc->parent_reset(cs);
> > +
> > +    env->pc_w = 0;
> > +    env->sregI = 1;
> > +    env->sregC = 0;
> > +    env->sregZ = 0;
> > +    env->sregN = 0;
> > +    env->sregV = 0;
> > +    env->sregS = 0;
> > +    env->sregH = 0;
> > +    env->sregT = 0;
> > +
> > +    env->rampD = 0;
> > +    env->rampX = 0;
> > +    env->rampY = 0;
> > +    env->rampZ = 0;
> > +    env->eind = 0;
> > +    env->sp = 0;
> > +
> > +    env->skip = 0;
> > +
> > +    memset(env->r, 0, sizeof(env->r));
> > +
> > +    tlb_flush(cs);
> > +}

