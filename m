Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F131C35244
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB77C20838
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z58gLzmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB77C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuus0-0003Kv-U3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1iuur8-0002t3-MH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1iuur7-0006Xx-CK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:02:22 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:46204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1iuur7-0006WJ-5r
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:02:21 -0500
Received: by mail-io1-xd2a.google.com with SMTP id t26so1117649ioi.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iaX3wiMLuD0EPeVZmDm+pPAmtrSltW/aRTfChrZ1INw=;
 b=Z58gLzmihXJn81YCxsVTclp6Ij0/yfVzm7qRwLzJ+gnQPwlQN1spAbi4JadMNMNstf
 9xKaGr/4/xtUBlwYe4Aqe66jq9AsKBc1mmAnTS87lGBDe0rZ1yDuPjYQJwSwnqkQCpEi
 7sY3Q8TIJkiYjeK2d1XbiRsMXvC/4hjveWbe7cSgIRQjCvNIVyADR6g29XI+OUCgP0Up
 fy7zVybXeqfMeCVHcsHO2mc2jg7I/8JcV4ZEQCuer8pzKx6Zexzzft07tD+WER3j7LWk
 /7Yf5kA2714+/wrxYVLk/UpXvvXK7dwxVEpB84Mghm1hFe/Zl7HV1+DLpTsUD4XR08NY
 qGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iaX3wiMLuD0EPeVZmDm+pPAmtrSltW/aRTfChrZ1INw=;
 b=OOIVu9JTCSVFFp3X3EF8RP14nzlq94lIWLVmd6HRrGme6USV98H8vt2Nc+OZdSBbNo
 tL5EFbjsD7UtbuaBwpwXbdqWwj+kVlaNJMlxevmm0XcGQ+TUjCW/JYNyKtDJAiptoeH4
 GZvvAcrq5+ZkirupJeS7SpDgr+wMOmqyIY3f70Aten0c4cZdRXvjqKRw/heyyZNoTMmN
 npIgN6G/nnlXfWIfSq1Mq6f92ICEdFVwDUKjWCg1J3chAGgyRrQbd9LCyjWueaTGdHSr
 02UyYkOwtRhIOu/qoXPbk6bGedUQMDOx6xOluInwDnKCykKlNnl/Jn/OiW7U6Q1iQ/fa
 9HRg==
X-Gm-Message-State: APjAAAXTMQ0wiNye3dCez0JinMU3+u6WgyySc98bJJSITDUki3ZyR1ae
 +m1UFa/lZ+xoMKw3WmHDUPNUJZkGDTJbOSpO6KQ=
X-Google-Smtp-Source: APXvYqw/rZhVGfyCkP6wqD4ZGzE4XKtkI4atd2CY7QhAj2ZHRCsiql4GQvO+lZr7Dt+cHIWGd3PwHct3x3ql+VLhRJ4=
X-Received: by 2002:a6b:3a03:: with SMTP id h3mr1475940ioa.241.1579856539923; 
 Fri, 24 Jan 2020 01:02:19 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 24 Jan 2020 10:02:08 +0100
Message-ID: <CABoDooMHEeHN_500GuCUgS9sNwWvA193AiDamq8Fmkp00DABjw@mail.gmail.com>
Subject: Re: QEMU for aarch64 with plugins seems to fail basic consistency
 checks
To: Robert Henry <robhenry@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2a
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Fri, Jan 24, 2020 at 1:45 AM Robert Henry <robhenry@microsoft.com> wrote=
:
>
> I wrote a QEMU plugin for aarch64 where the insn and mem callbacks print =
out the specifics of the guest instructions as they are "executed".  I expe=
ct this trace stream to be well behaved but it is not. By well-behaved, I e=
xpect memory insns print out some memory details, non-memory insns don't pr=
int anything, and the pc only changes after a control flow instruction.  I =
don't see that gross correctness about 2% of the time.
>
> I'm using qemu at tag v4.2.0 (or master head; it doesn't matter), running=
 on a x86_64 host.
> I build qemu using   ./configure --disable-sdl --enable-gtk --enable-plug=
ins --enable-debug --target-list=3Daarch64-softmmu aarch64-linux-user
> I execute qemu from its build area build/aarch64-linux-user/qemu-aarch64,=
 with flags --cpu cortex-a72 and the appropriate args to --plugin ... -d pl=
ugin -D .....
> I'm emulating a simple C program in linux emulation mode.
> The resulting qemu execution is valgrind clean (eg, I run qemu under valg=
rind) for my little program save for memory leaks I reported a few days ago=
.
>
> Below is an example of my trace output (the first int printed is the cpu_=
index, checked to be always 0). Note that the ldr instruction at 0x41a608 s=
ometimes reports a memop, but most of the time it doesn't.  Note that 0x41a=
608 is seen, by trace, running back to back. Note that (bottom of trace) th=
at the movz instruction reports a memop.  (The executed code comes from gli=
bc _dl_aux_init, executed before main() is called.)
>
> How should this problem be tackled? I can't figure out how to make each t=
cg block be exactly 1 guest (aarch64) insn, which is where I'd first start =
out.

To get TBs of a single instruction, you can add -singlestep to the command =
line.

HTH,

Laurent

> 0 0x000000000041a784 0x000000000041a784 0xf1000c3f cmp x1, #3
> 0 0x000000000041a788 0x000000000041a788 0x54fff401 b.ne #0xfffffffffffffe=
80
> 0 0x000000000041a78c 0x000000000041a78c 0x52800033 movz w19, #0x1
> 0 0x000000000041a790 0x000000000041a790 0xf9400416 ldr x22, [x0, #8] 0 me=
m  {3 0 0 0} 0x0000004000800618
> 0 0x000000000041a794 0x000000000041a794 0x17ffff9d b #0xfffffffffffffe74
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  =
0 mem  {3 0 0 0} 0x0000004000800620
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!  =
0 mem  {3 0 0 0} 0x0000004000800630
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a608 0x000000000041a608 0xf8410c01 ldr x1, [x0, #0x10]!
> 0 0x000000000041a60c 0x000000000041a60c 0xb4000221 cbz x1, #0x44
> 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1
> 0 0x000000000041a7dc 0x000000000041a7dc 0xf9400418 ldr x24, [x0, #8] 0 me=
m  {3 0 0 0} 0x0000004000800638
> 0 0x000000000041a7e0 0x000000000041a7e0 0x17ffff8a b #0xfffffffffffffe28
> 0 0x000000000041a7d8 0x000000000041a7d8 0x52800035 movz w21, #0x1 0 mem  =
{3 0 0 0} 0x0000004000800640
>
>
>
>
>

