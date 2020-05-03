Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0116CC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB122073E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ebDrmoyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB122073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV6Rl-0007vn-Ty
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 00:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6R1-0007Rh-Nk
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:40:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6R0-0006sZ-T7
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:40:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id 188so4592563wmc.2
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 21:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RimjZ7WkFfKRUws7pVSN5jCnQogAheTvnqGcbUpcMD8=;
 b=ebDrmoyvEDObS8rmCedj/G+r7Wfc9AGGy2Bbo3lQlthh5YqsFXptNK7UgmQwpOl0rX
 BrOvTJVnX7GTs3veu27kdoaeSYRaALeb6to8CZ76/1q9V3XqelU16o29mTXJQZKYSSns
 RdLjBsLUx40v29nd2fpQPLEChIdUyNNWFLw5CDXU/zo+eaHVtg4NU0ZDVunF85ADIQok
 RNyX7q+O+mFV8GB30BxYWYrNxz66ik4uk4LamH5jKyV6AE59aHvBo/Mh4fWzvDmvnC+l
 LYv/rWOp7Z2aw/1niSquUmhyhiRa3wzz+qaOk2BwQ3Wyh90G2tnGoTTZgMTQwWdu8DvL
 NLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RimjZ7WkFfKRUws7pVSN5jCnQogAheTvnqGcbUpcMD8=;
 b=Pde/Eb9QJzayjMppgniVd8VmFlYaTxEyrbBOTGbTVmJ2C4D4fHVKzpp798eIb0HKQf
 KQMsonFKFbTjRjR95knntU423A/cUvLQlR4hue+RVobdrDDa1td1F4k0JgbtSyKjg/Se
 wf7TTOsipWKww0/Uzce3VXrx973l1R5gOayYO4e4KYTVkjbz84ZDICrWt7/BliPcRb2i
 sqebaOFY8Nat+6vAAewEClp1NxKurRkLroD4NVUYyJDOM9Miv/dI9FMK+rbP6H3n9Ex0
 uFjJUNQqQWVnl/cwOa6ETcLK1PVeHUGROtvX/Qfr4HVZa7ODyWucE1+hTB9flBkUS+Oo
 Nb0w==
X-Gm-Message-State: AGi0Puaid/6Kc2y/W2hZdM9/TJIdnR00nqH4Ypf9XdjyfrZWJ1+LklyT
 CfvSa6LOmVOBDp+3K38Q2dV4p4UswbZ4U55C10bZLKYQXzs=
X-Google-Smtp-Source: APiQypK7QI5xRIXqLKxTvAFX6S4zUSPFRjZlcu3CA23SQFqVxI0HgK7fVnTnYxSqWlaquYG10ALjUJg+Rn7C3aB21kQ=
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr8115154wma.26.1588480857385; 
 Sat, 02 May 2020 21:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-3-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588348254-7241-3-git-send-email-bmeng.cn@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 3 May 2020 10:10:44 +0530
Message-ID: <CAAhSdy3z8ezUx+ozdupR5c5AKLhsfonSFHgrk_Yco2ZH4JubFQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] gitlab-ci/opensbi: Update GitLab CI to build generic
 platform
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=anup@brainfault.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 9:24 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This updates the GitLab CI opensbi job to build opensbi bios images
> for the generic platform.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  .gitlab-ci-opensbi.yml | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci-opensbi.yml
> index dd051c0..26092bb 100644
> --- a/.gitlab-ci-opensbi.yml
> +++ b/.gitlab-ci-opensbi.yml
> @@ -34,18 +34,12 @@ build-opensbi:
>     when: always
>   artifacts:
>     paths: # 'artifacts.zip' will contains the following files:
> -   - pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
> -   - pc-bios/opensbi-riscv32-virt-fw_jump.bin
> -   - pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> -   - pc-bios/opensbi-riscv64-virt-fw_jump.bin
> -   - opensbi32-virt-stdout.log
> -   - opensbi32-virt-stderr.log
> -   - opensbi64-virt-stdout.log
> -   - opensbi64-virt-stderr.log
> -   - opensbi32-sifive_u-stdout.log
> -   - opensbi32-sifive_u-stderr.log
> -   - opensbi64-sifive_u-stdout.log
> -   - opensbi64-sifive_u-stderr.log
> +   - pc-bios/opensbi-riscv32-generic-fw_jump.bin
> +   - pc-bios/opensbi-riscv64-generic-fw_jump.bin

Same comment as PATCH1

We should add generic-fw_jump.elf here as well.

> +   - opensbi32-generic-stdout.log
> +   - opensbi32-generic-stderr.log
> +   - opensbi64-generic-stdout.log
> +   - opensbi64-generic-stderr.log
>   image: $CI_REGISTRY_IMAGE:opensbi-cross-build
>   variables:
>     GIT_DEPTH: 3
> @@ -54,10 +48,6 @@ build-opensbi:
>   - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
>   - echo "=== Using ${JOBS} simultaneous jobs ==="
>   - make -j${JOBS} -C roms/opensbi clean
> - - make -j${JOBS} -C roms opensbi32-virt 2>&1 1>opensbi32-virt-stdout.log | tee -a opensbi32-virt-stderr.log >&2
> + - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-stdout.log | tee -a opensbi32-generic-stderr.log >&2
>   - make -j${JOBS} -C roms/opensbi clean
> - - make -j${JOBS} -C roms opensbi64-virt 2>&1 1>opensbi64-virt-stdout.log | tee -a opensbi64-virt-stderr.log >&2
> - - make -j${JOBS} -C roms/opensbi clean
> - - make -j${JOBS} -C roms opensbi32-sifive_u 2>&1 1>opensbi32-sifive_u-stdout.log | tee -a opensbi32-sifive_u-stderr.log >&2
> - - make -j${JOBS} -C roms/opensbi clean
> - - make -j${JOBS} -C roms opensbi64-sifive_u 2>&1 1>opensbi64-sifive_u-stdout.log | tee -a opensbi64-sifive_u-stderr.log >&2
> + - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-stdout.log | tee -a opensbi64-generic-stderr.log >&2
> --
> 2.7.4
>
>

Otherwise looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

