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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44468C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2EA20663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIAW0g9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2EA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7su-0007dk-BK
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jh7sK-0007EN-88
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:38:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jh7sI-00018b-RC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:38:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so8819308wru.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dt0quylclzmPdGYiKzgTmMkh7d4v7bbtp7DAEr8yJsI=;
 b=cIAW0g9/yPjxW1nMbANYkAjFkX0Y6Bm8uIsGpeYSvLjSdNymQVvlLfqf91MuIHUPnq
 J5FjSbmfvlW+0Pzr4QzOZGKeF9UElMLMWkK+mFDGQLU1SxEmwcG+G3HBBcw5HqDVDJC5
 Qpr0Owq9grhnT/VJTvyL2dBWEN2XWDJkLfBuV1eLqBAlKnZSQRzFfVRipMp80ruIlNto
 H2YJMBeZk904aEdPv/W415e9WnBhOAfId+K+1FmNUclPJc3taxJVhGOINN5k33ifcIa4
 akpgk1UVOkcelw5sVltnAE1QKE/qGGOfMPZNvdZ7qD5HO1a5K2ybdZ2SJ3zhgDY994c8
 yyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dt0quylclzmPdGYiKzgTmMkh7d4v7bbtp7DAEr8yJsI=;
 b=b2i6cq/l069hQwIQszyLUD4I3j8soXuRSYLgFGcrK/d/t22RCTxOpTRQAafV+3Pq67
 bqhtaqBe891X9Zkxn+fjHDkkDFgDMDF4bCIVO59Ax4gCEZTxX8GX4rO9GAjG5nQDcx6t
 LCifBw6SpzBWrQgROIaGXYcrN4imQjlNmUASq0IknHMwnSqJM2GX6eQA7leu1xgVYsOd
 6JaklHRVr/IpVOzRMeborNw51IZrm+V4opf+9EfmEp6rcl/xstdEQ+PTrImLTdz7Pb/h
 N6Ov5JdSt4+V/upCdDddzkn7xkhb/4WfD4ehD8IAbUhFdMZmmF3fakkt2e54VMNXgikM
 LkHw==
X-Gm-Message-State: AOAM530I3+bfrtawFxri9UNUdo8OYA44dGVsRz5ld/fN9UUlkzsWi/e4
 vijnveBpCisg5NwXxqqNbtIpJ72erJPOk0Ng5so=
X-Google-Smtp-Source: ABdhPJx0rkCmFKvOzrGorgcUIapljm7oQ2fwDnJJe08M9XL1GFjrTfkc05u4uYHJ4qKQZlJ8lvD+rZgZRxElEHr1rLk=
X-Received: by 2002:adf:c98a:: with SMTP id f10mr8423058wrh.329.1591346328444; 
 Fri, 05 Jun 2020 01:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 5 Jun 2020 10:38:36 +0200
Message-ID: <CAHiYmc7YtDSL_+LexXXBtZArdQVuU9-bwRoAxyTfseG=-6+NOQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Huacai Chen <zltjiangshi@gmail.com>
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

=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2.

Hi, Huacai,

The documents you kindly provided contain some valuable info on
Loongson-3A R1/R2/R3/R4 and Loongson-3B R1/R2. However, I
couldn't find detailed instruction-by-instruction specifications.

In fact, I don't need all the details right now, but some form of
overview of instructions sets of Loongson-3A R1/R2/R3/R4 and
Loongson-3B R1/R2. Could you please provide textual description
(one of two paragraph) of supported instructions for each of these
models:

* Loongson-3A R1
* Loongson-3A R2
* Loongson-3A R3
* Loongson-3A R4
* Loongson-3B R1
* Loongson-3B R2

(what is the base instructuin set; the difference to the previous model;
what SIMD extension (LMI/MSA) is supported other specifics around
supported instructions)

Based on your answer I may bring forward some suggestions on the
improvement of v4 of this series.

Truly yours,
Aleksandar

> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>
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
> V3 -> V4:
> 1, Sync code with upstream;
> 2, Remove merged patches;
> 3, Fix build failure without CONFIG_KVM;
> 4, Add Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>=
.
>
> Huacai Chen(4):
>  hw/mips: Implement the kvm_type() hook in MachineClass
>  target/mips: Add Loongson-3 CPU definition
>  hw/mips: Add Loongson-3 machine support (with KVM)
>  MAINTAINERS: Add myself as Loongson-3 maintainer
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  MAINTAINERS                          |   5 +
>  default-configs/mips64el-softmmu.mak |   1 +
>  hw/core/Makefile.objs                |   2 +-
>  hw/core/null-machine.c               |   4 +
>  hw/mips/Kconfig                      |  10 +
>  hw/mips/Makefile.objs                |   3 +-
>  hw/mips/common.c                     |  42 ++
>  hw/mips/loongson3.c                  | 901 +++++++++++++++++++++++++++++=
++++++
>  include/hw/mips/mips.h               |   3 +
>  target/mips/cpu.h                    |  28 ++
>  target/mips/internal.h               |   2 +
>  target/mips/mips-defs.h              |   7 +-
>  target/mips/translate.c              |   2 +
>  target/mips/translate_init.inc.c     |  86 ++++
>  14 files changed, 1092 insertions(+), 4 deletions(-)
>  create mode 100644 hw/mips/common.c
>  create mode 100644 hw/mips/loongson3.c
> --
> 2.7.0

