Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65544C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3086320663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvQgO8Nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3086320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdBb-0008Cw-HF
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqdB2-0007hE-OH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:53:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqdB0-0005Cx-I9
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:53:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so23943751wrw.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xKIW5XTC7Nl9T5AZKrhkS49d+dFrk1+4tSn2rgh3xVE=;
 b=bvQgO8Nxab8p7MDKU/F0zm7jREH3B0wZj25wtSXplMJ80vlm+3t6crT0OTxVLXghaG
 dK48h9uVkuzvtI4c9Zne2aBOOkdzLzcdAOJ97PJhuM4x56itgX1uwnlZwtXeiVkwcpM/
 0CtkyO04u3VeXrJrjWawzCvFY9aH0dl9RqawFfmZCp/stie5ZEuBKusgO8N5LTqAW3rx
 j/UEAe5rTpWOBTaKwVRFnSpfe3o9PLPXVt3Z4BYvVAUTyOqevVZrkw+cOwBnPGH7E/CY
 lOOxKtnkSjlhFF90b8zrGpIBTsQi0I7RVsaRm9YpW2AuHnoCEqedQMOCa6BTIKZmy4iN
 VlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xKIW5XTC7Nl9T5AZKrhkS49d+dFrk1+4tSn2rgh3xVE=;
 b=fKH+sOG3A5GyP/oIF4OFd2aCNFydc7NWi7fs0qY3HZRLg1KowaRDQgFZGO5JJkYNu0
 NeqiIQK1ApQvx2xdco3RY64Oh5UTeA7WRmUJgr/nQFXw7vLw9GP6F8zgrjxn+atop3Yb
 O8D6pdvxCgoWpHGr7L5RHYCaHrxEPcAKA5X0P+DnqAPLAQBU73CPqGurcXxKrdJk+Eem
 6XeOWx1aVnXkWbccdRNCcbzFeKaw89vCstvrkeJYZF7cYY/xFGzbc6o3YwsC8UG/7XYA
 h/O33HSoeTMHrlSwwNi5S9H//RkWnhWa7amF7GbMJ/3TuqdfUiDLZq7WOR3Dbw0Ar20O
 ykpA==
X-Gm-Message-State: AOAM5334psV1aSpETr3lby4ly7cfpXXQrfpLAUVNbonJZOros44aRem/
 6Z0FSUfonQcgt4RGocHQpkB3IcW9W+VAf82FuTY=
X-Google-Smtp-Source: ABdhPJyjTr387AhR+uSRca5KdXDATXHtIfp/G5/DfFPRkRYEnv5vHOox4szlR268ay3y1wAbujpHYQTJkfvDYftSufs=
X-Received: by 2002:adf:f885:: with SMTP id u5mr26395273wrp.402.1593611604744; 
 Wed, 01 Jul 2020 06:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
 <1fdab6eb-9258-7df1-75ea-b4717a9c2b87@amsat.org>
 <3ae1ef05-8caa-b5ce-a1ce-9670fc0a7cd3@amsat.org>
 <009f6fed-f043-cce3-f2c8-9aefd70d9601@amsat.org>
 <CABDp7VoRWPft-aXi5OfreUQ0AzoRWe+cg8wySHwmbf8wADg=JA@mail.gmail.com>
In-Reply-To: <CABDp7VoRWPft-aXi5OfreUQ0AzoRWe+cg8wySHwmbf8wADg=JA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 1 Jul 2020 15:53:08 +0200
Message-ID: <CAHiYmc4Go4RmdOC4dBE0Z4tu0d8mciiG1VUSz4=k9t58b54MDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
To: chen huacai <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Paul Burton <paulburton@kernel.org>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 1:05 PM chen huacai <zltjiangshi@gmail.com> wrote:
>
> Hi, Philippe and Alexandar,
>
> On Wed, Jul 1, 2020 at 4:49 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >
> > On 7/1/20 10:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On 6/30/20 7:19 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> On 6/30/20 6:46 PM, Aleksandar Markovic wrote:
> > >>> Paul Burton and Aurelien Jarno removed for not being present.
> > >>>
> > >>> Huacai Chen and Jiaxun Yang step in as new energy.
> > >>>
> > >>> CC: Paul Burton <paulburton@kernel.org>
> > >>> CC: Aurelien Jarno <aurelien@aurel32.net>
> > >>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
> > >>> ---
> > >>>  MAINTAINERS | 15 ++++++++++-----
> > >>>  1 file changed, 10 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>> index 5d8acf8d31..7fc16e21c9 100644
> > >>> --- a/MAINTAINERS
> > >>> +++ b/MAINTAINERS
> > >>> @@ -213,7 +213,8 @@ F: disas/microblaze.c
> > >>>
> > >>>  MIPS TCG CPUs
> > >>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> -R: Aurelien Jarno <aurelien@aurel32.net>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >>> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> > >>>  S: Maintained
> > >>>  F: target/mips/
> > >>> @@ -377,6 +378,7 @@ F: target/arm/kvm.c
> > >>>
> > >>>  MIPS KVM CPUs
> > >>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >>>  S: Odd Fixes
> > >>>  F: target/mips/kvm.c
> > >>>
> > >>> @@ -1052,6 +1054,7 @@ MIPS Machines
> > >>>  -------------
> > >>>  Jazz
> > >>>  M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >
> > > Hmm this is the Jazz hobbyist machine, Huacai are you sure this
> > > the correct section you want to be?
> > >
> > > Anyway Herv=C3=A9 Poussineau has to ack that, Aleksandar, it would
> > > be easier if you split this as a separate patch.
> > >
> > >>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> > >>>  S: Maintained
> > >>>  F: hw/mips/jazz.c
> > >>> @@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c
> > >>>
> > >>>  Malta
> > >>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >>>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >>> -R: Aurelien Jarno <aurelien@aurel32.net>
> > >
> > > Last time Aurelien commented on the Malta machine, was on March 23,
> > > 3 months ago, then there hasn't been Malta patches. As a reviewer
> > > he is present and provides valuable feedback, why are you kicking
> > > him out? See:
> > > https://www.mail-archive.com/qemu-devel@nongnu.org/msg691406.html
> > >
> > > Huacai, has Jiangsu Lemote Tech Co., Ltd real interest to paid
> > > employees to maintain the Malta board?
> I think I can review TCG part and maintain KVM part currently, but
> can't maintain Jazz/Malta/Mipssim/R4k/Boston (maybe possible in
> future, but not now).
>

Sure, Huacai, I will respect your wish.

I truly like your cautious approach. Although, honestly speaking, your
credentials for being a maintainer are - at least - three order of
magnitude higher than for some other maintainer. But, people, here we
have a responsible, serious man - Huacai Chen! Bravo for caution,
bravo for being modest, and bravo for being not greedy!

My deep admiration! We want and we need such people in QEMU for MIPS!
There is a place for you here!

Aleksandar

> Thanks,
> Huacai
> > >
> > >>>  S: Maintained
> > >>>  F: hw/isa/piix4.c
> > >>>  F: hw/acpi/piix4.c
> > >>> @@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_malta.py
> > >>>
> > >>>  Mipssim
> > >>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> > >>>  S: Odd Fixes
> > >
> > > Now that you have 2 maintainers, you can raise the status to Maintain=
ed.
> > >
> > >>>  F: hw/mips/mipssim.c
> > >>> @@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c
> > >>>
> > >>>  R4000
> > >>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> -R: Aurelien Jarno <aurelien@aurel32.net>
> > >
> > > I'm sure Aurelien will agree with this part. But let's wait
> > > for his feedback.
> > >
> > >>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> > >>>  S: Obsolete
> > >>>  F: hw/mips/r4k.c
> > >>> @@ -1103,7 +1106,8 @@ S: Maintained
> > >>>  F: hw/intc/loongson_liointc.c
> > >>>
> > >>>  Boston
> > >>> -M: Paul Burton <pburton@wavecomp.com>
> > >>> +M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>
> > >> Missing in the patch description that you are taking this
> > >> machine over.
> > >
> > > After some rest I remember Paul said he'd come back on QEMU,
> > > so it doesn't look right to kick him out that way.
> > >
> > > Also in this thread you said you never saw a Boston board:
> > > https://www.mail-archive.com/qemu-devel@nongnu.org/msg691778.html
> > >
> > > Paul might welcome you as a co-maintainer, but I rather keep
> > > him for his expertise.
> >
> > Looking in archives, on Oct 20 2019 Paul said "it would be a pain
> > to me if the boston machine bitrotted or anything" and he planned
> > to find time to improve "the CM & MT ASE emulation".
> >
> > This was before Feb 19 2020 when he announced "[his] time with MIPS
> > the company has reached its end": https://lkml.org/lkml/2020/2/19/984
> >
> > Still this change requires an Ack from him.
> >
> > >
> > >>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >
> > > Huacai, similarly does Jiangsu Lemote Tech Co., Ltd have real
> > > interest in time to provide developers to maintain the Boston
> > > machine?
> > >
> > >>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> > >>>  S: Maintained
> > >>>  F: hw/core/loader-fit.c
> > >>> @@ -2677,7 +2681,8 @@ F: disas/i386.c
> > >>>
> > >>>  MIPS TCG target
> > >>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > >>> -R: Aurelien Jarno <aurelien@aurel32.net>
> > >>> +M: Huacai Chen <chenhc@lemote.com>
> > >
> > > $ git log --author=3D'Huacai Chen <chenhc@lemote.com>' tcg/mips/ | wc=
 -l
> > > 0
> > >
> > > $ git log --grep=3D'Reviewed-by: Huacai Chen <chenhc@lemote.com>'
> > > tcg/mips/ | wc -l
> > > 0
> > >
> > > git log --grep=3D'Acked-by: Huacai Chen <chenhc@lemote.com>' tcg/mips=
/ | wc -l
> > > 0
> > >
> > >>> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >
> > > $ git log --grep=3D'Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com=
>'
> > > tcg/mips/ | wc -l
> > > 0
> > >
> > > $ git log --grep=3D'Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>'
> > > tcg/mips/ | wc -l
> > > 0
> > >
> > > I think you are confusing sections, Since Huacai and Jiaxun never sho=
wed
> > > interest in the TCG target code, how can they become maintainers?
> > >
> > >>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> > >
> > > $ git log --grep=3D'Reviewed-by: Aleksandar Rikalo' tcg/mips/ | wc -l
> > > 0
> > > $ git log --grep=3D'Acked-by: Aleksandar Rikalo' tcg/mips/ | wc -l
> > > 0
> > >
> > > Apparently Aleksandar Rikalo can be "removed for not being present."
> > >
> > > OTOH FWIW:
> > > $ git log --author=3D'Philippe Mathieu-Daud=C3=A9' tcg/mips/ | wc -l
> > > 25
> > > $ git log --grep=3D'Reviewed-by: Philippe Mathieu-Daud=C3=A9' tcg/mip=
s/ | wc -l
> > > 99
> > >
> > > So for this section changes:
> > > NAcked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >
> > > The rest is conditional of Paul Burton and Aurelien Jarno Ack-by.
> > >
> > >>>  S: Maintained
> > >>>  F: tcg/mips/
> > >>>
> > >>
> > >>
> > >
> >
>
>
> --
> Huacai Chen

