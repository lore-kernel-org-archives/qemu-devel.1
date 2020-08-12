Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32BBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 03:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC63620675
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 03:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGQDGUQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC63620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5hZn-0005ww-TB
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 23:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5hYO-0004jn-1v; Tue, 11 Aug 2020 23:35:52 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5hYM-0007RW-1q; Tue, 11 Aug 2020 23:35:51 -0400
Received: by mail-il1-x144.google.com with SMTP id z17so469268ill.6;
 Tue, 11 Aug 2020 20:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t2hqqdFBou7BxgdQbJ4HKmVWgZH5rBk3tZGbETcmImE=;
 b=CGQDGUQJRTxv8/u+rwAlNnd1XxoJ9eMVILnHXIVQfbDhXWrqyd4u738Cz1gNVxllgT
 VLk3VbPYhTqThRjb4wf/PtZyjSaIT4GUvkeLVqV0luei17Ck0Tj4ae7Gn9H1DZJiC71f
 S8P2wtDikavZOijpqAX48S4wdLQkfz1LLpSZDHPHh5AjMLOt8PtDraNQu7m7/WndMZxN
 i0gs4dHGisv+Q/R6LU6J94onKFrJxh9GPwRYWEw83qYbeC94H6gmzfinA8mAJlLbxwIl
 9uNggUB8lYEkPLrcN6yz39FZp5zcG919TBo3XpWJ+S3C8JfuFXT8ABVT0dl0JUc6qRv4
 dZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t2hqqdFBou7BxgdQbJ4HKmVWgZH5rBk3tZGbETcmImE=;
 b=fkvkZzv1ElsvgZdCh50D5+1OlXW4ztQikoO1DYW7lU/5oLbe3qSj1zjPG7FDOOgkUb
 XcBwOhdwxege24NDvbwd7aNHHYo0zWpi9OfSwdtLjmFECEZ+NqmqUOKPXLvkTVfOwDBy
 1LNLCkONmuqOYC/+fXoMmevghXud+YBevbQhl/K6CI6IbB2i1Thgk71ZQxpR+DG76jVf
 RBDJp4O8JZe0KSjZeRLZsRxseALvGlEPY+YwsGrVbujwIziy2Yh9r6TAB7iwAMxS1Xma
 7boXQRrHKnDZ9XzH4zKblw3Ry0k7gf7S27g4AnE32NvukpQmtKVIFysQQhKp7Gso2PSF
 lAsA==
X-Gm-Message-State: AOAM531evUvpTvjt35GGA/d53sGJv7ei4anNU/+kpXXvWi8Gi3z6cvOd
 XahgVSfdF+pxfHhIc9Jz0zLi7q4keywNSZXcCPI=
X-Google-Smtp-Source: ABdhPJxpG/VLVbJli0CI3ScqaIOVKi5ik7+Hvg9hgq/u95MH2dHG8CV6hLuVZkRexu7yhCr1kxz8ivlnVygD3c9aNPI=
X-Received: by 2002:a05:6e02:ef3:: with SMTP id
 j19mr15371074ilk.227.1597203348509; 
 Tue, 11 Aug 2020 20:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Aug 2020 20:25:23 -0700
Message-ID: <CAKmqyKMM-sWAHGM=iXVXHtCGPSHzfoEVb0QvrSRT7Rc7zSibbg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] riscv: Switch to use generic platform fw_dynamic
 type opensbi bios images
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 12:31 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> The RISC-V generic platform is a flattened device tree (FDT) based
> platform where all platform specific functionality is provided based
> on FDT passed by previous booting stage. The support was added in
> the upstream OpenSBI v0.8 release recently.
>
> This series updates QEMU to switch to use generic platform of opensbi
> bios images. With the recent fw_dynamic image support, let's replace
> the fw_jump images with fw_dynamic ones too.
>
> The patch emails do not contain binary bits, please grab all updates
> at https://github.com/lbmeng/qemu.git bios branch.
>
> Note:
>
> 1. To test 32-bit Linux kernel on QEMU 'sifive_u' 32-bit machine,
> the following patch is needed:
> http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html
>
> 2. To test 64-bit Linux 5.3 kernel on QEMU 'virt' or 'sifive_u' 64-bit
> machines, the following commit should be cherry-picked to 5.3:
>
> commit 922b0375fc93fb1a20c5617e37c389c26bbccb70
> Author: Albert Ou <aou@eecs.berkeley.edu>
> Date:   Fri Sep 27 16:14:18 2019 -0700
>
>     riscv: Fix memblock reservation for device tree blob
>
> Linux 5.4 or above already contains this commit/fix.

Thanks for this.

Applied to riscv-to-apply.next

Alistair

>
> Changes in v6:
> - Rebased on https://github.com/alistair23/qemu/commits/riscv-to-apply.next
> - Add information about Linux kernel tested
> - Squash the Makefile ELF changes into patch 5
>
> Changes in v5:
> - Include the generic fw_dynamic.bin in the Makefile for `make install` bisection
>
> Changes in v4:
> - Remove old binaries in the Makefile for `make install` bisection
>
> Changes in v3:
> - Change fw_jump to fw_dynamic in the make rules
> - Change to fw_dynamic.bin for virt & sifive_u
> - Change to fw_dynamic.elf for Spike
> - Generate fw_dynamic images in the artifacts
>
> Changes in v2:
> - new patch: configure: Create symbolic links for pc-bios/*.elf files
> - Upgrade OpenSBI to v0.8 release
> - Copy the ELF images too in the make rules
> - Include ELF images in the artifacts
>
> Bin Meng (6):
>   configure: Create symbolic links for pc-bios/*.elf files
>   roms/opensbi: Upgrade from v0.7 to v0.8
>   roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
>   hw/riscv: Use pre-built bios image of generic platform for virt &
>     sifive_u
>   hw/riscv: spike: Change the default bios to use generic platform image
>   gitlab-ci/opensbi: Update GitLab CI to build generic platform
>
>  .gitlab-ci.d/opensbi.yml                       |  28 ++++++++--------------
>  Makefile                                       |   4 ++--
>  configure                                      |   1 +
>  hw/riscv/sifive_u.c                            |   4 ++--
>  hw/riscv/spike.c                               |   9 +++++--
>  hw/riscv/virt.c                                |   4 ++--
>  pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
>  pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
>  pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
>  pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
>  pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
>  roms/Makefile                                  |  32 ++++++++-----------------
>  roms/opensbi                                   |   2 +-
>  16 files changed, 35 insertions(+), 49 deletions(-)
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
>  delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
>  delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>
> --
> 2.7.4
>
>

