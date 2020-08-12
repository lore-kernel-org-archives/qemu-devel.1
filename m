Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A7BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F0720774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DAtmCeyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F0720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zS0-00044h-DW
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQW-0002KX-WC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQU-0005qK-CY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272066; x=1628808066;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gxsKxLCPKdN4SFMA7S86ikuFrMubMYW40PaLwjnm0Jk=;
 b=DAtmCeyFSvUhHEEr8ZF2ZpbZ8ZQYy4vLrFA4DZDsS8ktfbfZ/XNjgwMX
 vLomoUhi/WBhxOO1OyIAA2yGq+XswRAehfkeZhEVL9qwibquaEkc9DTXX
 gw7Ed+PAYHb4LKulOnxmTgqO1U6QSkh50hfG+Hc1HQheT/XLjqqua2lYj
 hTegFQ3+m3bpNKxVNND3ghc6U6ymNKw1UAzwSE253QUPk1z7ic9rWcb/r
 Anw/ayCASE1CQ2j9VjSDNIKzEgYKLUM5qJTd8x1aWm2Ug+75D4gGCOrAM
 Qdi3mAAkpEoJWMtSf+7eXvzXzIsGt+U6tWZ1drJGOhgjzckSwNOTnd+5+ w==;
IronPort-SDR: 2fNoGtUjF9XwMUMIRI605JqspteWkRoKH4MP1HWdrLGFOoMmEPNDkwmYGL2oIsshssMV4IJ7xh
 truPGmvExZWLcO7+5eSkE1qNJqHtDnAXqVGpsi5JpTdR04wB7GnPANQ2bYpofd9DgxJQns3XVB
 crSWdtXyNd3Ym2CbBBJJmW2AnRGDei/hx0YBCVm4nfzA4E51LrslTTBTCo9CcRab/1P6vXmhZY
 /2zgIBz5uLu9GbL1lmoeXhmRTQTWKEDJS3ISMT5hapuUAZ20fZQFbWl6HoNL+/QG/+GpXBA0Tt
 qoc=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="247966156"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:41:03 +0800
IronPort-SDR: AWWVxNPOCCrJ55QKIEErrcP3SjlEjuhqx6PVB6P8gbx+AWsCSt72qxifOZSdgLbFT2CnGu2Op1
 NuX/ClnscyYg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:43 -0700
IronPort-SDR: 5fxRkTj/rdP8CSoRy/rFrG6lw/n8NLazyDz0kXFYqqA6rTNTrNPJXp9yqSMSk6S+c92plSOtK8
 AXQvyGpxzx+Q==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] gitlab-ci/opensbi: Update GitLab CI to build generic
 platform
Date: Wed, 12 Aug 2020 15:30:40 -0700
Message-Id: <20200812223045.96803-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This updates the GitLab CI opensbi job to build opensbi bios images
for the generic platform.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1596439832-29238-7-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .gitlab-ci.d/opensbi.yml | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 62088ec5ec..5b13047e2a 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -35,18 +35,14 @@ build-opensbi:
    when: always
  artifacts:
    paths: # 'artifacts.zip' will contains the following files:
-   - pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
-   - pc-bios/opensbi-riscv32-virt-fw_jump.bin
-   - pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
-   - pc-bios/opensbi-riscv64-virt-fw_jump.bin
-   - opensbi32-virt-stdout.log
-   - opensbi32-virt-stderr.log
-   - opensbi64-virt-stdout.log
-   - opensbi64-virt-stderr.log
-   - opensbi32-sifive_u-stdout.log
-   - opensbi32-sifive_u-stderr.log
-   - opensbi64-sifive_u-stdout.log
-   - opensbi64-sifive_u-stderr.log
+   - pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
+   - pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
+   - pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
+   - pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
+   - opensbi32-generic-stdout.log
+   - opensbi32-generic-stderr.log
+   - opensbi64-generic-stdout.log
+   - opensbi64-generic-stderr.log
  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
  variables:
    GIT_DEPTH: 3
@@ -55,10 +51,6 @@ build-opensbi:
  - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
  - echo "=== Using ${JOBS} simultaneous jobs ==="
  - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi32-virt 2>&1 1>opensbi32-virt-stdout.log | tee -a opensbi32-virt-stderr.log >&2
+ - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-stdout.log | tee -a opensbi32-generic-stderr.log >&2
  - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi64-virt 2>&1 1>opensbi64-virt-stdout.log | tee -a opensbi64-virt-stderr.log >&2
- - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi32-sifive_u 2>&1 1>opensbi32-sifive_u-stdout.log | tee -a opensbi32-sifive_u-stderr.log >&2
- - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi64-sifive_u 2>&1 1>opensbi64-sifive_u-stdout.log | tee -a opensbi64-sifive_u-stderr.log >&2
+ - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-stdout.log | tee -a opensbi64-generic-stderr.log >&2
-- 
2.27.0


