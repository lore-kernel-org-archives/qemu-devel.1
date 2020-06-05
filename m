Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7745D20772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UODxPvr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7745D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8ZT-0008GB-OU
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jh8Xz-00061Q-Ib
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:21:55 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jh8Xy-00025x-OL
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:21:55 -0400
Received: by mail-io1-xd42.google.com with SMTP id p20so9458093iop.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bhFUDgq70WZx473nEqMorVqchSQcC7izB4iMgwya4JU=;
 b=UODxPvr4Mkcq/iafxBxajQLMEtW76ajesqvL9S1bS+iUSFPOqb4A5b3OI7AcaWa/u8
 M0g2IJzBwlZv5zkMIJBrgnkMBLgVzAe5ijAg2gtTfjBcfkkEoZNXdHeZ+noYhuC/18ob
 GEtqS7lz8oyuQtc6EtjgO8zrq4Fkb20SKWQz2HIjnZ95fMVcMvJO5IHPo9cASjk23fKh
 8KTg1y4hlMZV4cjCcliNkEkniTEf6xQUpkqRt9EuiKxPNk2HLacQfAz0tKuMGUdDKKxS
 wT3eIErWqfRI2TllAO5e0E0AS0VRYKTb4h9GL838xFFTBRDq4QrM/OJnAUJZe0Bfdj81
 njxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bhFUDgq70WZx473nEqMorVqchSQcC7izB4iMgwya4JU=;
 b=pjKd7DYKEs1Kq16FwV0pUY3d62EXLijCGK4YvH05FlzVAnEKyq3rgOJVqg5dzZxDB/
 p470bwZ9MmQRwzWt8NOm9/aE1MKI4/PyEznfp7iL44G/dIsTUXHc1oBc+7OUkOvY42h7
 dH7nHt9di+vuZC1duUJrRsOXsGDz2HdtLm86i442f0FSZ18IpR+fh2UTpXaJPf6LjGNs
 V/3vJ/ZzEakxcwx2kwo5UT8urCBhP0X3enP0qKzxMWEzKPCGPthfSft4undOkl0Nd3Dh
 ObXENCFbHQT4U06OOSAV+uv4D+4prW8WtcmDAqIXNDwCQyDri1c2d8y+bo961PtQcLTY
 jnOg==
X-Gm-Message-State: AOAM533bqL6Wi1aEAmGRNEXVxISt4MWduBjR8NlTHtXN1hWCx5V7la6l
 v+Fk8w789515w0tpbwGr6vrxx/q6w062wdVoawI=
X-Google-Smtp-Source: ABdhPJz31G/wSPSHSokPTnkOWRAp/ghCzgv0pqKx+BgkRnBr/2M5tWA0aPE+3C45vmhZSJiA4TzlrojUfa5YDs+5P9Q=
X-Received: by 2002:a05:6602:1408:: with SMTP id
 t8mr7669133iov.125.1591348913156; 
 Fri, 05 Jun 2020 02:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
 <20200605170545.0000676c@flygoat.com>
In-Reply-To: <20200605170545.0000676c@flygoat.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Fri, 5 Jun 2020 17:21:41 +0800
Message-ID: <CAAhV-H7AfOLFchqP3bzyywr1RzUE05eC4h44m636jgD0i4-DNA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd42.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Jiaxun,

On Fri, Jun 5, 2020 at 5:06 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> On Fri, 5 Jun 2020 10:38:36 +0200
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> wrote:
>
> > =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Che=
n <zltjiangshi@gmail.com> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and
> > > Loongson-3B R1/R2.
> >
> > Hi, Huacai,
> >
> > The documents you kindly provided contain some valuable info on
> > Loongson-3A R1/R2/R3/R4 and Loongson-3B R1/R2. However, I
> > couldn't find detailed instruction-by-instruction specifications.
> >
> > In fact, I don't need all the details right now, but some form of
> > overview of instructions sets of Loongson-3A R1/R2/R3/R4 and
> > Loongson-3B R1/R2. Could you please provide textual description
> > (one of two paragraph) of supported instructions for each of these
> > models:
> >
>
> Hi Aleksandar,
>
> I'm going to explain this according to the names of vendor specified
> ASEs name in GCC & Binutils.
>
> There are some instruction that not covered by public documents, that's
> out of our scope so I'm not going to talk them.
>
> Firstly, there are some ASEs not being upstreamed yet:
>  - Loongson-AMO (Atomic Opreations, Looks like RISC-V)
>  - Loongson-EXT3 (Loongson Extention 3)
>  - Loongson-CSR (Core Status Registers, instructions to read some
>    private core register, including something called "stable-counter"
>    (TSC like timer) and CPUCFG(something like cpuid in x86))
Core Status Registers  shoud be  Configuration Status Register

>
>  - MIPS-MSA-Ctypto (Including AES, SHA, MD5 stuff)
>  - MIPS MSA2 (256-bit MSA instructions)
>
> And there is a ASE that only being used in kernel so not even being
> mentioned in toolchain.
>  - Loongson-SPW (LWPTE, LDPTE used to help with pagetable walking)
>
> ALl these processors have mips64r2 as baseline.
>
> > * Loongson-3A R1
> Loongson-MMI, Loongson-EXT
>
> > * Loongson-3A R2
> Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, DSP, DSPr2
>
> > * Loongson-3A R3
> Same as R2. This revision mainly focus on bugfix and improve clock
> speed.
>
> > * Loongson-3A R4
> Loongson-MMI, Loongson-EXT, Looongson-EXT2, Loongson-SPW, Loongson-AMO,
> Loongson-EXT3, Loongson-CSR, MSA Crypto, MSA2
>
> This processor even support hardware unaligned accessing.
>
> > * Loongson-3B R1
> > * Loongson-3B R2
> Loongson-3B R1 and R2 are mostly identical with Loongson-3A R1, the
> difference is it have 8-cores in a package. It was designed for HPC so
> there are some domain specific SIMD instructions, but they're not
> available to public.
>
> And a new family member of Loongson64:
> Loongson-2K (R1):
> Loongson-MMI, Loongson-EXT, Looongson-EXT2, MSA.
>
> >
> > (what is the base instructuin set; the difference to the previous
> > model; what SIMD extension (LMI/MSA) is supported other specifics
> > around supported instructions)
> >
> > Based on your answer I may bring forward some suggestions on the
> > improvement of v4 of this series.
> >
> > Truly yours,
> > Aleksandar
> >
>
> Thank a lot.
>
> - Jiaxun

