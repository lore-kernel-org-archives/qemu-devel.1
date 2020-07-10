Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE4C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52E62075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQWVQPdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52E62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyPK-0000cM-VC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtyOd-0008A9-0A; Fri, 10 Jul 2020 15:09:19 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:43891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtyOb-0002QA-2b; Fri, 10 Jul 2020 15:09:18 -0400
Received: by mail-il1-x142.google.com with SMTP id i18so5980752ilk.10;
 Fri, 10 Jul 2020 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nKZXlti+L91iuMBh9bT9YlYjyPr5sL4Oaw58ubgKmIc=;
 b=jQWVQPdmyVjWC8o0iDBeFmr2YHhDlIaMp1uPClsDiWjBuK89wV6MJlqoPizlIj+VRZ
 MeGW2pHS/Fqi2ypgXecmyn15YGl2Itp4jKAZFO6+qoFossyPvKaurPdB3mcwoehbdZlf
 7c7DeAt/FDPsIp1iQn6RRsMaENjV+YAbUwe6myNs6lxKGz6rKcqVPrZH7HwZstOWzHVh
 01/N+UNkCZ8dVVhszE8a0O5bd9Z+FAesAtZGxQkGOmfUBXD7JnXuPWWHvkC89zLt4R1C
 wBfq1NPz7BvMyt3gwqnM5VOsntpOOIsECf7L7mul4093VX8XophpXLMLyYjwCcpYqxRd
 F02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nKZXlti+L91iuMBh9bT9YlYjyPr5sL4Oaw58ubgKmIc=;
 b=V4m2DB2vGpiXKvP8JLjco4Pe33KcymppGojkX1kS0KSr8VuHwNvC4IvC6tWv4Jn/6+
 Wo0bc6/Yv3O7G1U0r93tR+/xri+RYeXwGC1m/nmhJx4qE1Ce4UyLk46QwY74eYkkjleC
 +f9vWDGjtdu/iK+BJ1bMlc5WkRhXJnJ1UAvXHWpkO49sEzYCkwO9/HuDZ0lP2/CllIgj
 AXOqvha8svdHecS+ONtnh5PgY0bpaX742z932wkLneQzmA14BVjwXchKYoIfZSiHp0o0
 6OfPQaP/l7PBP9d+viiBEjsm/7ZCn9rIjN4aOE+OfwSs0gQvOgiGsYEWNGUy9j3Hn8S4
 /4Ow==
X-Gm-Message-State: AOAM530urP+o0NFI35/HGEwFRiv5DbqXOCFbzADDFQS5XroUFsxaep4d
 t1Shr6vaOXBebVJY2Q10l/WFi8/W2OQaatnTKsQ=
X-Google-Smtp-Source: ABdhPJx5IjsJVp7KGHbt5PTRT+Q/i6lm8vWXNpCKeXdTrFbPwHG7OgfpKUmsTHBXBajKS/6PoruC8smfU5XfViqp0eA=
X-Received: by 2002:a92:c213:: with SMTP id j19mr54067392ilo.40.1594408155725; 
 Fri, 10 Jul 2020 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jul 2020 11:59:22 -0700
Message-ID: <CAKmqyKN9QFwo=EFYOSNvrmkHJfJZmZM+SuuiatEEa64_RteGig@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] riscv: Switch to use generic platform fw_dynamic
 type opensbi bios images
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 10:05 PM Bin Meng <bmeng.cn@gmail.com> wrote:
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
> Changes in v4:
> - Remove old binaries in the Makefile for `make install` bisection
>
> Changes in v3:
> - Change fw_jump to fw_dynamic in the make rules
> - Change to fw_dynamic.bin for virt & sifive_u
> - Change to fw_dynamic.elf for Spike
> - Generate fw_dynamic images in the artifacts
> - change fw_jump to fw_dynamic in the Makefile
>
> Changes in v2:
> - new patch: configure: Create symbolic links for pc-bios/*.elf files
> - Upgrade OpenSBI to v0.8 release
> - Copy the ELF images too in the make rules
> - Include ELF images in the artifacts
> - new patch: Makefile: Ship the generic platform bios images for RISC-V
>
> Bin Meng (7):
>   configure: Create symbolic links for pc-bios/*.elf files
>   roms/opensbi: Upgrade from v0.7 to v0.8
>   roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
>   hw/riscv: Use pre-built bios image of generic platform for virt &
>     sifive_u
>   hw/riscv: spike: Change the default bios to use generic platform image
>   gitlab-ci/opensbi: Update GitLab CI to build generic platform
>   Makefile: Ship the generic platform bios images for RISC-V

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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

