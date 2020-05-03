Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEFEC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7405D2071C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obMjRCez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7405D2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVCEB-0005wt-Kx
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVCCY-0004fa-Cj
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:50:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVCCW-0004l3-T9
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:50:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so17389111wrx.3
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/o2wI9t9+cXIshXfWIVYOvr6bgDQoMsZ+TtuW7Ty4I0=;
 b=obMjRCezv5prd6eMFB5cvkJeyP8ZrRHYsigY22KGWpuAjSXV2fcQ9J4Mp+9DpOz6C9
 dprKXjCWs+2FKzf9owAvznIuIZqz02fRrWl5gBSnmQZoDmRcbge453szO5pjjuvH8bMm
 1QueLGSqwdjQ9iQ4r/0Ak6ZQYw97Q92k1vySA/m9WmUtQFSXyM1H6HPxFGeKqqnHOrpk
 BnZyqSmNAx2Fm884jBY6rz7w9BkxtgPUG9ibrYoBAgnMeFpTedxX43OYFtxdVqzUoZsv
 X7yUgKmSG8e6VBHd5k1BjHeyij6cAJ3XUN7ErPnlZihnb1+tUKvNzTw3sa5KcRG37Hm8
 g7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/o2wI9t9+cXIshXfWIVYOvr6bgDQoMsZ+TtuW7Ty4I0=;
 b=i0oFXyKjRnXm9Y5fDLQL/NmdQ4lVI2l6Dyh5Qd3JNwAtgMf4Jf6C3+OBPFKR2ISTA0
 mY/7G0jK3KPL7n/p1XlMOF7oNkCI2PTp3dO/dluScqPWwwyrR99NhShacy5ibYulpMSN
 mSE+zfnaPCfYRtFjG53jLXJKwVeACbnvzcwrbi5SpwXCfvca2sjlUTsy7ZjgEcawo45t
 VSElAdkN874JjKmNTnGe8qqF5XnLYjlYQC4YYxx02ciNpvvF2rnVHnN/JRy9GAo3Ie07
 tAZXqVEyeqaDtG83z1rkHIiipRp95Ha3BWXLdgS5J0YYeY0PbdlXD7Nr69iyfRzcZbx5
 159w==
X-Gm-Message-State: AGi0Puap5YLTQ0i4FsuRUhrpHDj1y1Dt6WFvmR0WR1mxgY5tEB64tgvZ
 8LNJFxR9c3Nw+lThRFp/zAW1dFuyut2LaGgRDEM=
X-Google-Smtp-Source: APiQypKSAxKgdUV4cmoEy8YUyi/083VAoy0HvG8wtug9V0ImRdjaPFwWPBgI8WLXbRBpZ+J/MYGncwAY6a481P/r/ik=
X-Received: by 2002:adf:94a6:: with SMTP id 35mr13284023wrr.420.1588503023373; 
 Sun, 03 May 2020 03:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 3 May 2020 12:49:41 +0200
Message-ID: <CAHiYmc5UanJELbuo8RzODNo0+cvQ_XL-HhNC2DUMSGVKVZEBMQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:21 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
>
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>

Huacai, thanks for putting together v3, which is a little better than v2, a=
nd
thanks for addressing my previous suggestions.

Now, give us some time to digest new data on Loongson3.  We will
respond, but it won't happen immediately, which is, you'd agree,
reasonable. Just be patient.

But again, in general, I salute your efforts very much!

Yours, Aleksandar

> Loongson-3 lacks English documents. I've tried to translated them with
> translate.google.com, and the machine translated documents (together
> with their original Chinese versions) are available here.
>
> Loongson-3A R1 (Loongson-3A1000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pd=
f (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pd=
f (Chinese Version)
>
> Loongson-3A R2 (Loongson-3A2000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)
>
> Loongson-3A R3 (Loongson-3A3000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf (Chin=
ese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf (Chin=
ese Version)
>
> Loongson-3A R4 (Loongson-3A4000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> User Manual Part 2:
> I'm sorry that it is unavailable now.
>
> We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension is
> fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support
> in this series. And the next series will add QEMU/TCG support (it will
> emulate Loongson-3A R1).
>
> We already have a full functional Linux kernel (based on Linux-5.4.x LTS
> but not upstream yet) here:
>
> https://github.com/chenhuacai/linux
>
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> 3, Boot a Loongson-3A4000 host with this kernel;
> 4, Build QEMU-5.0.0 with this patchset;
> 5, modprobe kvm;
> 6, Use QEMU with TCG (available in future):
>        qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu Loongson-3A1000=
 -kernel <path_to_kernel> -append ...
>    Use QEMU with KVM (available at present):
>        qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu Loongson-3A4000=
 -kernel <path_to_kernel> -append ...
>
>    The "-cpu" parameter can be omitted here and QEMU will use the correct=
 type for TCG/KVM automatically.
>
> V1 -> V2:
> 1, Add a cover letter;
> 2, Improve CPU definitions;
> 3, Remove LS7A-related things (Use GPEX instead);
> 4, Add a description of how to run QEMU/Loongson-3.
>
> V2 -> V3:
> 1, Fix all possible checkpatch.pl errors and warnings.
>
> Huacai Chen(7):
>  configure: Add KVM target support for MIPS64
>  hw/mips: Implement the kvm_type() hook in MachineClass
>  hw/mips: Add CPU IRQ3 delivery for KVM
>  target/mips: Add Loongson-3 CPU definition
>  target/mips: Add more CP0 register for save/restor
>  hw/mips: Add Loongson-3 machine support (with KVM)
>  MAINTAINERS: Add myself as Loongson-3 maintainer
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  MAINTAINERS                          |   5 +
>  configure                            |   2 +-
>  default-configs/mips64el-softmmu.mak |   1 +
>  hw/core/Makefile.objs                |   2 +-
>  hw/core/null-machine.c               |   4 +
>  hw/mips/Kconfig                      |  10 +
>  hw/mips/Makefile.objs                |   3 +-
>  hw/mips/common.c                     |  31 ++
>  hw/mips/mips_int.c                   |   4 +-
>  hw/mips/mips_loongson3.c             | 901 +++++++++++++++++++++++++++++=
++++++
>  include/hw/mips/mips.h               |   3 +
>  target/mips/cpu.h                    |  28 ++
>  target/mips/internal.h               |   2 +
>  target/mips/kvm.c                    | 212 +++++++++
>  target/mips/machine.c                |   6 +-
>  target/mips/mips-defs.h              |   7 +-
>  target/mips/translate.c              |   2 +
>  target/mips/translate_init.inc.c     |  86 ++++
>  18 files changed, 1300 insertions(+), 9 deletions(-)
>  create mode 100644 hw/mips/common.c
>  create mode 100644 hw/mips/mips_loongson3.c
> --
> 2.7.0

