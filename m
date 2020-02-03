Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253B6C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CDD2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFYa0v+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CDD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyf2S-0003ky-2o
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyf1j-0003Kf-06
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyf1h-0001ck-MT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:56:46 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:45797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyf1h-0001bI-GV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:56:45 -0500
Received: by mail-oi1-x22e.google.com with SMTP id v19so15382715oic.12
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hs0/ijncGKzIXar4b8H2YCAo4nmI9a4EBkSuU9RkExY=;
 b=OFYa0v+sopBg9ChjRgxAJ7lFxVsLpxmgFTwpLy+6ZsZ8b3zGxNHdrcmj72S3lV2Jmf
 bZkvAdinrfU+j/PusVa/WkmVnMZUed2KilznkX4GX2GU/7VyoGLvSVNpqwbeRXKFb99H
 uSqOQqDZybgfsHza5EH8noA08nDOwCBomBa1fqh6E+Hh43g+9/LN3iVUFaatgc6Z/A+L
 1kI49BE2bY60J5rNcycmHWCoELAoBL3Et1o+lQfAKOs7NzqgG+UNnC9ZSbaizwzP6ewM
 2fJU5o5x6MdjamdLlmam2VjITFuYflvCNckgPnCrRbHaFK/IWvVifA7PwUemIbjq4fTA
 xKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hs0/ijncGKzIXar4b8H2YCAo4nmI9a4EBkSuU9RkExY=;
 b=EbA82Gbux0EHumm0eKXp7AJ4Ddh+MdIuKklE3fQFBe+Mdj62gk0feURPXJZG2hKl9X
 NuPGZoTva1bEc1MPi1Vk3ZPhXg0avnZLNQ6byctctUBGTHsg8garbdwCUqdQY/kLNcen
 YhQksO74fLXyNhu0vebZZdPLLSEhHnI1GqrOjxWCRj6DHcbTNTtG6obNTLCQPfQX7AEE
 p48aE9dsPLmtOvRpah/cGv2sOnH8iFW0xA5nqhcys5oXBkYsZoanq91uRvKYNpYQTvDJ
 6sXi3YNNo/GLHpjKa01l27/XcCK+BYcuZYkbwIvqiGTXd3ZNz99Q6QTq0tWR/L5t9Wpy
 AjZQ==
X-Gm-Message-State: APjAAAWN3RV7QZUEY/t+HkwTzU6jDvpeg5/61PxzW/VanPp4jXUOl/xg
 OSm49dtmjQyBHrw/TxjmkVZXufk/mwIFZy1vzVySsQ==
X-Google-Smtp-Source: APXvYqzjqFNAA0EfIjPFaafV52Mry9LKm4R3BdN4qIvhwFDVtafglvu8RVyb4vaubSGxVvFRyaJMWAwEX8qUq8PTkFs=
X-Received: by 2002:aca:b2c5:: with SMTP id
 b188mr15474076oif.163.1580749003999; 
 Mon, 03 Feb 2020 08:56:43 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
In-Reply-To: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 16:56:33 +0000
Message-ID: <CAFEAcA_0RxRUkmU3YGCF2RXmJu=vP1D8SQunhdPdwW88oreCvQ@mail.gmail.com>
Subject: Re: Need help understanding assertion fail.
To: Wayne Li <waynli329@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 16:39, Wayne Li <waynli329@gmail.com> wrote:
> Anyway that's the background.  The specific problem I'm having right now =
is I get the following assertion error during some of the setup stuff our O=
S does post boot-up (the OS is also custom-made):
>
> qemu_programs/qemu/tcg/ppc/tcg-target.inc.c:224: reloc_pc14_val: Assertio=
n `disp =3D=3D (int16_t) disp' failed.
>
> Looking at the QEMU code, "disp" is the difference between two pointers n=
amed "target" and "pc".  I'm not sure exactly what either of those names me=
an.  And it looks like since the assertion is checking if casting "disp" as=
 a short changes the value, it's checking if the "disp" value is too big?  =
I'm just not very sure what this assertion means.

This assertion is checking that we're not trying to fit too
large a value into the host PPC branch instruction we just emitted.
That is, tcg_out_bc() emits a PPC conditional branch instruction,
which has a 14 bit field for the offset (it's a relative branch),
and we know the bottom 2 bits of the target will be 0 (PPC insns
being 4-aligned), so the distance between the current host PC
and the target of the branch must fit in a signed 16-bit field.

"disp" here stands for "displacement".

The PPC TCG backend only uses this for the TCG 'brcond' and
'brcond2' TCG intermediate-representation ops. It seems likely
that the code for your target is generating TCG ops which have
too large a gap between a brcond/brcond2 and the destination label.
You could try using the various QEMU -d options to print out the
guest instructions and the generated TCG ops to pin down what
part of your target is trying to generate branches over too
much code like this.

> Anyway, the thing is this problem has to be somehow related to
> the transfer of the code from a little-endian platform to a
> big-endian platform as our project works without any problem on
> little-endian platforms.

In this case it isn't necessarily directly an endianness issue.
The x86 instruction set provides conditional branch instructions
which allow a 32-bit displacement value, so you're basically never
going to overflow a conditional-branch there. PPC, being RISC,
has more limited branch insns. You might also run into this
if you tried to use aarch64 (64-bit) arm hosts, which are
little-endian but have a 19-bit branch displacement limit,
depending on just how big you've managed to make your jumps.
On the other hand, a 16-bit displacement is a jump over
64K of generated code, which is huge for a single TCG
generated translation block, so it could well be that you
have an endianness bug in your TCG frontend which is causing
you to generate an enormous TB by accident.

thanks
-- PMM

