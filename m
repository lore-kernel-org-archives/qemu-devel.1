Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D91C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FFA2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCSecuOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FFA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHfM-0004ty-GX
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiHeV-0004Gz-0a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:17:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiHeT-0003F7-NT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:17:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id p5so17339815wrw.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Epg++ry2RFq5AZR/GHkEC+ULcf8oHyMK4zP1zkSSsUQ=;
 b=tCSecuOxNhBuPNpG67zlENnXqIqs+IPZGnYerQUu4bXspQnbSsqiYEumhd8H7TyVvF
 zzsPWfuXi/Nf5BOVlchA33/940E1eg1OrLVid5CvF4dV2R0hS2L/g+fQ9Fku0eEmgmnY
 BOcGTY0Rpi51rKkmCFdszDFNFoBoO6VWvzgzPurjvHyxo3jZXnoAYssCyqMOVEUiK7i8
 EQUB7S8TnwQZQAAHp46oZ+19QJVRCSaHb6+Gwr3P3LNFKDJTpS2/fFSoEZfgcXokNRbc
 glU5fZpJp6Aptb0vMwmPvC/1DpHBcuT0ib4B5URQaVJ2bCTpnM25keQW/sECL0FTHa15
 3k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Epg++ry2RFq5AZR/GHkEC+ULcf8oHyMK4zP1zkSSsUQ=;
 b=mpmqKiBT0MFpHlTrC9asRH1xmFLO6em3pcgW4BgvkonSzNPkHgBgjjh36SotoNCcAi
 muV9fu9yZ5RD6LhBbMx6RTOrXQp6MxjWlvt3ZDBReU9FwDYxBLAfIjTC7nL4wOwGHw5Y
 jkqBJbcsZH8HAF+Urts6G3urNfF111qhWtWiInZqBathjSzAw6UhTfFl9EaMkP6pteO7
 O7/nOG+XTB/hsWhTZwM2aSF+0HEzpOQ2oCLcnaQD6+sanv8Lk/Oloz0M1zPt0uEDle2r
 1rGdd0BQIS3uuKB0/bT1WupZ9KrcYdfstts/lIyn8MHYI32Mbt/V/RqD1ZAP6EmWN5F9
 F8gw==
X-Gm-Message-State: AOAM533Unwj+anINv+/PRdK5YsIf015IRgXLa0l/sVGAoa+TWDKt4W2k
 nlg/VXbDwlARLwI83QddzyYdSYd1cqvFqrzX7TY=
X-Google-Smtp-Source: ABdhPJz00Glcf+m/3Rgl7eAqfiQfH3kzOcrITaDxWlXhLnG8neEvw8YaPHm3ec0Z8fZt04RV7NjKwTpdVOuZqqPIeRM=
X-Received: by 2002:adf:a283:: with SMTP id s3mr22258263wra.147.1591622240013; 
 Mon, 08 Jun 2020 06:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <CAFEAcA-0Y6rFNrsD2SN13eZArCk3Ydvf6kv7OZaQ07fmFdSZZQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-0Y6rFNrsD2SN13eZArCk3Ydvf6kv7OZaQ07fmFdSZZQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 8 Jun 2020 15:17:07 +0200
Message-ID: <CAHiYmc7NuEROi312sq_veTNjRMAv3ZXbBLJGRwrB+1znktBexg@mail.gmail.com>
Subject: Re: [PULL 00/21] MIPS queue for June 7th, 2020
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 8. =D1=98=D1=83=D0=BD 2020. =D1=83 15:05 Peter Maydell =
<peter.maydell@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Sun, 7 Jun 2020 at 20:46, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> > The following changes since commit 175198ad91d8bac540159705873b4ffe4fb9=
4eab:
> >
> >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200605' int=
o staging (2020-06-05 17:45:59 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/AMarkovic/qemu tags/mips-queue-june-07-2020
> >
> > for you to fetch changes up to ffbd8a88e8872d61fa5622a0075eddbe71951067=
:
> >
> >   target/mips: Enable hardware page table walker and CMGCR features for=
 P5600 (2020-06-07 21:34:14 +0200)
> >
> > ----------------------------------------------------------------
> >
> > MIPS queue for June 7th, 2020
> >
> > Highlights:
> >
> >   - Registring change of email address for two contributors
> >   - Cleanup and improvements of FPU helpers
> >   - Enabling some features of P5600
> >   - Adding two Loongson-3A CPU definitions
> >   - Moving futher towards Loongson-3A KVM support
> >   - Two checkpatch warnings are known and should be ignored
> >
>
> Hi; I'm afraid this fails to build on non-Linux hosts
> (OSx, BSDs, Windows):
>
> hw/mips/common.c:21:23: fatal error: linux/kvm.h: No such file or directo=
ry
>
> Looking at that file, it also makes the mistake of putting
> an include line before osdep.h, which should always be the
> first include in a C file.
>
> The more usual way to arrange this kind of "real implementation
> of a function for the compiled-with-KVM case, stub for
> the #ifndef CONFIG_KVM case" is to put the real implementation
> into a C file that's only built for the CONFIG_KVM case:
> obj-$(CONFIG_KVM) +=3D whatever.o
> (it may be simplest to just put it in the existing target/mips/kvm.c?)
> and then either
> (a) provide the non-kvm stub version directly in the .h file
> that declares the prototype for the kvm case:
> #ifdef CONFIG_KVM
> int mips_kvm_type(MachineState *machine, const char *vm_type)
> #else
> static inline mips_kvm_type(MachineState *machine, const char *vm_type)
> {
>     return 0;
> }
> #endif
> (b) alternatively put the stub code in a built-for-non-KVM
> source file:
> obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
>
> i386, s390x and arm all have examples of this kind of "stub
> version plus for-kvm version" function that may be useful
> as examples.
>

Thanks for your detailed response and pointers!

I am going to work with the original contributor on this.

I am planning, of course, to send another, corrected, pull request,
but not sooner than in 5-6 days.

Aleksandar

> thanks
> -- PMM

