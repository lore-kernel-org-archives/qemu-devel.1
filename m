Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369E42070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5MlNXt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369E42070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Uyt-0006MF-Vo
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvw-0001ZP-MS; Mon, 03 Aug 2020 03:30:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvr-00066o-5h; Mon, 03 Aug 2020 03:30:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id 9so13349948wmj.5;
 Mon, 03 Aug 2020 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DCtIbJc5eztIkmbNLe9RE/thb6UUj+7roPrWBTHLItE=;
 b=l5MlNXt/8A7C3c/Q3Xxu//i5JNKnEED4083u7NGSdRrMJWVDGdzDLW3fmGLGs++qqO
 6aQjffghpTBdatOCkthW8zxOccMU78TraDxrnBFSWmVeFbHPAvHemBACKYOfRDxagqiT
 OGmenwJjkjgbg6E/p9Z+orFP9v2QkYGswflHZypTxq5uONuVC8Fu4IsG0RIUFHO/V3wq
 jn5OIQ1/GlL0vZhGpXtbJ1vBvK7Cnl6BUlin0sFIIEaIuAqBnFUh2Evq2gPizPxbfwI3
 IHhW10jmN9cNRLhRPgOdJNbFHc7idG9GghAj8+LkfhqLBPBY6rZn+g+o1/tJybRKPoTX
 V7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DCtIbJc5eztIkmbNLe9RE/thb6UUj+7roPrWBTHLItE=;
 b=BwpGjf/t1j4N7O1T3AZZCsCmGerVOOacvV/gb1czCl7NPit4F6TWLFzZOKw036RWs0
 mwdA18b7dK8aIAgvuyJgiFCGD03VOd1wPSufLAGcYumb1pMJzokqYs78dZPu/gPMvopy
 KJ7GEe4Y0Roy5te0jgyVd/W78qwbUt+ESfydpADDosV4jyFHpStcMgTGi2UC4hxZlPhb
 SNroYj5A0496xjpsPzRGbJ0sHBXxlzJcS7DzWBpyUFn+xixnUg1lgvjQMElQ2SkNbiHg
 M6gZ2TUvlBrFqbau2MnuYsHc7kth5CWfBPcivqraj+VXdobRII7OUeTTwypStG80z7Jt
 vV+w==
X-Gm-Message-State: AOAM530tIslTOYnF5+4B+FvUo4wbFrKQ0pbHKJ51Ry8o2i1nmn4zE47M
 brX/cRSV/v8r0weQeTCfoy0=
X-Google-Smtp-Source: ABdhPJzApWO7Q206rCweO9GINyHicy+DX+z62MLLGeSnXGcUM2LmmZ9r9j12wYDPoyFPXCPFn2EvLA==
X-Received: by 2002:a1c:2bc1:: with SMTP id
 r184mr15342965wmr.133.1596439849377; 
 Mon, 03 Aug 2020 00:30:49 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 130sm23969438wme.26.2020.08.03.00.30.47
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 03 Aug 2020 00:30:48 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 4/6] hw/riscv: Use pre-built bios image of generic platform
 for virt & sifive_u
Date: Mon,  3 Aug 2020 00:30:30 -0700
Message-Id: <1596439832-29238-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
References: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Update virt and sifive_u machines to use the opensbi fw_dynamic bios
image built for the generic FDT platform.

Remove the out-of-date no longer used bios images.

Note:

1. To test 32-bit Linux kernel on QEMU 'sifive_u' 32-bit machine,
   the following patch is needed:
   http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html

2. To test 64-bit Linux 5.3 kernel on QEMU 'virt' or 'sifive_u' 64-bit
   machines, the following commit should be cherry-picked to 5.3:

   commit 922b0375fc93fb1a20c5617e37c389c26bbccb70
   Author: Albert Ou <aou@eecs.berkeley.edu>
   Date:   Fri Sep 27 16:14:18 2019 -0700

       riscv: Fix memblock reservation for device tree blob

   Linux 5.4 or above already contains this commit/fix.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v6:
- Add information about Linux kernel tested

Changes in v5:
- Include the generic fw_dynamic.bin in the Makefile for `make install` bisection

Changes in v4:
- Remove old binaries in the Makefile for `make install` bisection

Changes in v3:
- Change to fw_dynamic.bin for virt & sifive_u

 Makefile                                       |   3 +--
 hw/riscv/sifive_u.c                            |   4 ++--
 hw/riscv/virt.c                                |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
 9 files changed, 5 insertions(+), 6 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/Makefile b/Makefile
index c2120d8..9d87135 100644
--- a/Makefile
+++ b/Makefile
@@ -842,8 +842,7 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
+opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 55b3383..18301e6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -60,9 +60,9 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
 #endif
 
 static const struct MemmapEntry {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 55a907b..6e91cf1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -43,9 +43,9 @@
 #include "hw/pci-host/gpex.h"
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
 #endif
 
 static const struct MemmapEntry {
diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
new file mode 100644
index 0000000..23b4dfb
Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
deleted file mode 100644
index 3e0da54..0000000
Binary files a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
deleted file mode 100644
index bc56ed6..0000000
Binary files a/pc-bios/opensbi-riscv32-virt-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
new file mode 100644
index 0000000..16c0cf4
Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
deleted file mode 100644
index 1acee86..0000000
Binary files a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
deleted file mode 100644
index c62f2b4..0000000
Binary files a/pc-bios/opensbi-riscv64-virt-fw_jump.bin and /dev/null differ
-- 
2.7.4


