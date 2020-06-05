Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6200FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCE020772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee2VIm8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCE020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7uR-0000NT-Ff
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jh7ti-0008Nj-NV
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:40:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jh7tf-0001HX-PH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:40:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id q11so8864246wrp.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XIEDysmKuJpNl+PJCgn+1jzsnqx+tgAmg8Ot2awGpaY=;
 b=Ee2VIm8bAGjHjYWgnLj+rJuyWSYvmM1r4q8d+W2YZl/Bj8c5dutUXINE6Z+qTQpUJ9
 GyeRbdV0r6XfoT4Kw7N640DIofH1b487JyknOKvY20978F9l9GYU9BcvHcsDZsYNXgV7
 LNqElM7/IpD9NciNuzIJ6cDZy/lv51AQeqjstBnsN20PSAL3RckVZWyW2eIn9R+yZcq5
 sYbfm6AMVOyNvAviEv+qHhhBfqyCOm18ndQKWmcI33uj8nq51ldp9i9P3bS5cDLqnfgP
 lLfSzuZWae7/1u3VuMYdoXl5fPSE3hzwNcsD3Rc6hveWbN39Do7OGdVBqhgkboV+kFHv
 j/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XIEDysmKuJpNl+PJCgn+1jzsnqx+tgAmg8Ot2awGpaY=;
 b=A0PPH3E2eBPnadzdBHZ926Hi9fFH7GvUutv1SDom6suW4r8+ib2mTx1oiFjRzF9wqF
 3fMFbqg2plQ2YZZRo4othCuXwoZO9fN1e6FG7BtU/Ic0uLovZktT8m5Q0fhUJNlhVdzc
 vOa5DVYtq8aooSiJEt1pcs6TErx1bPxqFesiSo6jx9zboaL/wH7BXGobeSlFQWM+6kHy
 dftecrXFkJfvNPUXW1bmpzNzONZH3x51sR+PQia8MnQQIqSnCR/PwDEWceKemyEv7U/7
 VIKzPT08+AsCYjW3maKemQ8gg+zj5cFHP7DP3s1/2bxLMDjdg2uX0La/V5P2HlUvMPb6
 rHfA==
X-Gm-Message-State: AOAM533CwK+7j2DzfludAHOCRF7EGVC26gSfRqoRbQxglk5eMPfv6rlC
 EJZwbXgcy7T0CWSdFPagrSFQINdN9VCay74b41U=
X-Google-Smtp-Source: ABdhPJwylBoyYKYqHkc6Rv1Dyzst4g6vPzneHxQcwQa6YNZ7FoWXKHuSatNslSs4jgr3R/YSDVVrCH//tCNukFPgB4w=
X-Received: by 2002:adf:c98a:: with SMTP id f10mr8428844wrh.329.1591346414252; 
 Fri, 05 Jun 2020 01:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
In-Reply-To: <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 5 Jun 2020 10:40:01 +0200
Message-ID: <CAHiYmc4qDXFj_6Fki1JYZTjcMtEbj8XNo2ULzKNWm2Nh85HE3w@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Huacai Chen <zltjiangshi@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just adding Jiaxun.

=D0=BF=D0=B5=D1=82, 5. =D1=98=D1=83=D0=BD 2020. =D1=83 10:38 Aleksandar Mar=
kovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Chen =
<zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
> >
> > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> > R1/R2.
>
> Hi, Huacai,
>
> The documents you kindly provided contain some valuable info on
> Loongson-3A R1/R2/R3/R4 and Loongson-3B R1/R2. However, I
> couldn't find detailed instruction-by-instruction specifications.
>
> In fact, I don't need all the details right now, but some form of
> overview of instructions sets of Loongson-3A R1/R2/R3/R4 and
> Loongson-3B R1/R2. Could you please provide textual description
> (one of two paragraph) of supported instructions for each of these
> models:
>
> * Loongson-3A R1
> * Loongson-3A R2
> * Loongson-3A R3
> * Loongson-3A R4
> * Loongson-3B R1
> * Loongson-3B R2
>
> (what is the base instructuin set; the difference to the previous model;
> what SIMD extension (LMI/MSA) is supported other specifics around
> supported instructions)
>
> Based on your answer I may bring forward some suggestions on the
> improvement of v4 of this series.
>
> Truly yours,
> Aleksandar
>
> > 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It i=
s
> >    suitable for TCG because Loongson-3A R1 has fewest ASE.
> > 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It i=
s
> >    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> >
> > Loongson-3 lacks English documents. I've tried to translated them with
> > translate.google.com, and the machine translated documents (together
> > with their original Chinese versions) are available here.
> >
> > Loongson-3A R1 (Loongson-3A1000)
> > User Manual Part 1:
> > http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> > http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.=
pdf (Chinese Version)
> > User Manual Part 2:
> > http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> > http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.=
pdf (Chinese Version)
> >
> > Loongson-3A R2 (Loongson-3A2000)
> > User Manual Part 1:
> > http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> > http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Versio=
n)
> > User Manual Part 2:
> > http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> > http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Versio=
n)
> >
> > Loongson-3A R3 (Loongson-3A3000)
> > User Manual Part 1:
> > http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> > http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf (Ch=
inese Version)
> > User Manual Part 2:
> > http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> > http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf (Ch=
inese Version)
> >
> > Loongson-3A R4 (Loongson-3A4000)
> > User Manual Part 1:
> > http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> > http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> > User Manual Part 2:
> > I'm sorry that it is unavailable now.
> >
> > We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension is
> > fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support
> > in this series. And the next series will add QEMU/TCG support (it will
> > emulate Loongson-3A R1).
> >
> > We already have a full functional Linux kernel (based on Linux-5.4.x LT=
S
> > but not upstream yet) here:
> >
> > https://github.com/chenhuacai/linux
> >
> > How to use QEMU/Loongson-3?
> > 1, Download kernel source from the above URL;
> > 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> > 3, Boot a Loongson-3A4000 host with this kernel;
> > 4, Build QEMU-5.0.0 with this patchset;
> > 5, modprobe kvm;
> > 6, Use QEMU with TCG (available in future):
> >        qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu Loongson-3A10=
00 -kernel <path_to_kernel> -append ...
> >    Use QEMU with KVM (available at present):
> >        qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu Loongson-3A40=
00 -kernel <path_to_kernel> -append ...
> >
> >    The "-cpu" parameter can be omitted here and QEMU will use the corre=
ct type for TCG/KVM automatically.
> >
> > V1 -> V2:
> > 1, Add a cover letter;
> > 2, Improve CPU definitions;
> > 3, Remove LS7A-related things (Use GPEX instead);
> > 4, Add a description of how to run QEMU/Loongson-3.
> >
> > V2 -> V3:
> > 1, Fix all possible checkpatch.pl errors and warnings.
> >
> > V3 -> V4:
> > 1, Sync code with upstream;
> > 2, Remove merged patches;
> > 3, Fix build failure without CONFIG_KVM;
> > 4, Add Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.co=
m>.
> >
> > Huacai Chen(4):
> >  hw/mips: Implement the kvm_type() hook in MachineClass
> >  target/mips: Add Loongson-3 CPU definition
> >  hw/mips: Add Loongson-3 machine support (with KVM)
> >  MAINTAINERS: Add myself as Loongson-3 maintainer
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  MAINTAINERS                          |   5 +
> >  default-configs/mips64el-softmmu.mak |   1 +
> >  hw/core/Makefile.objs                |   2 +-
> >  hw/core/null-machine.c               |   4 +
> >  hw/mips/Kconfig                      |  10 +
> >  hw/mips/Makefile.objs                |   3 +-
> >  hw/mips/common.c                     |  42 ++
> >  hw/mips/loongson3.c                  | 901 +++++++++++++++++++++++++++=
++++++++
> >  include/hw/mips/mips.h               |   3 +
> >  target/mips/cpu.h                    |  28 ++
> >  target/mips/internal.h               |   2 +
> >  target/mips/mips-defs.h              |   7 +-
> >  target/mips/translate.c              |   2 +
> >  target/mips/translate_init.inc.c     |  86 ++++
> >  14 files changed, 1092 insertions(+), 4 deletions(-)
> >  create mode 100644 hw/mips/common.c
> >  create mode 100644 hw/mips/loongson3.c
> > --
> > 2.7.0

