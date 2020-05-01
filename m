Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFFC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ECF20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE7MHR+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ECF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXyc-0000L3-3l
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwc-0005kd-NV
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUXwM-0006hr-Mm
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwM-0006gY-AT; Fri, 01 May 2020 11:51:02 -0400
Received: by mail-pl1-x644.google.com with SMTP id u22so3765382plq.12;
 Fri, 01 May 2020 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=qpd51ohbbTsyZ6y+yOoQr4VXYGN4WHODyc4N/okOH0w=;
 b=mE7MHR+r7ZMREh2wKcl84nBGH5lCy5PLcHg6PGAHKsWXCyZxwNr2eWadKsyVhDAjQ1
 TvAXrzVs0adWfIvvHh1e7MtO54Oi4rsxQqBfm3yg+ClwNtuJDJm0rMckN5YOpAB9Pb4s
 1ZOJh/jJ6Lc8v0iiYdtoEE4bjSeWOQLUZYoKvaHnG2PD/YuC6bjZy7TgPOOQr+Z33qR0
 n3apKgPfbJUWJnHODrWCK9cqWJaES3ZOwaYdsMM72YN4hjBzIoB6ijIkEntgLj6NtxJS
 YbZquzb39rmgOPucflvZeTZMy3cx7KbjDmy78KBxaavcUosgE46pZyZfI3D59/VfS0YU
 kzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qpd51ohbbTsyZ6y+yOoQr4VXYGN4WHODyc4N/okOH0w=;
 b=qMLBPPRGsMhR43p0ly8sWR5WWMhXMSrOOo2Zh7PE1YxRG9Um0jevZiAYFKfHgDZo5g
 ujoS+IxaXfmwDf1SwRqLd0PJRefYzJiNu+zzapkOAeEcChYsi8aU945LTIhv6cNHSGp0
 qZreHJKO6Wo48Nj/u5xluXM2Rw1B4zgcGU1MAGWk1XNyq0yDIfeaFTGBp0V1bAQ3DTE2
 dr/fygJbpCDyyUBvLI+2OzaMO1c7tv/k0zyBXJhvHF6BVmL3pALK6+U3YUN9Ly7sAe1t
 mTK9o55kAuoDLstOiQvGjIKxUfSafQXIQMKBNy/IL5KG1cSODMTRRELOvRi8iFkxSQWH
 VdwQ==
X-Gm-Message-State: AGi0PuarN/pshX+ZTRrJBNvtMaQj4UZa+36gQbSp+LGfZ7XG/h11lGv4
 NiXOUazcyaNARqlukMo9fB/DBAZq
X-Google-Smtp-Source: APiQypLqsLaT0wDuGdpavavhaMkn002Hlfd6Fk/6EhUJTvJy9aVqfCz/hOrw9DkI95UaD+r70i9E6w==
X-Received: by 2002:a17:90b:8c8:: with SMTP id
 ds8mr236223pjb.164.1588348260695; 
 Fri, 01 May 2020 08:51:00 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id e4sm2385968pge.45.2020.05.01.08.50.59
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 01 May 2020 08:51:00 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 0/5] riscv: Switch to use generic platform of opensbi bios
 images
Date: Fri,  1 May 2020 08:50:49 -0700
Message-Id: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Bin Meng <bin.meng@windriver.com>, Anup Patel <Anup.Patel@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>


The RISC-V generic platform is a flattened device tree (FDT) based
platform where all platform specific functionality is provided based
on FDT passed by previous booting stage. The support was added in
upstream opensbi recently.

This series updates QEMU to switch to use generic platform of opensbi
bios images.

The patch emails do not contain binary bits, please grab all updates
at https://github.com/lbmeng/qemu.git bios branch.


Bin Meng (5):
  roms/opensbi: Update to support building bios images for generic
    platform
  gitlab-ci/opensbi: Update GitLab CI to build generic platform
  riscv: Use pre-built bios image of generic platform for virt &
    sifive_u
  riscv/spike: Change the default bios to use generic platform image
  riscv: Suppress the error report for QEMU testing with
    riscv_find_firmware()

 .gitlab-ci-opensbi.yml                       |  26 +++++++----------------
 hw/riscv/boot.c                              |  14 ++++++++++---
 hw/riscv/sifive_u.c                          |   4 ++--
 hw/riscv/spike.c                             |   9 ++++++--
 hw/riscv/virt.c                              |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_jump.bin  | Bin 0 -> 58032 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_jump.bin  | Bin 0 -> 66680 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 57920 -> 0 bytes
 roms/Makefile                                |  30 +++++++--------------------
 roms/opensbi                                 |   2 +-
 13 files changed, 39 insertions(+), 50 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

-- 
2.7.4


