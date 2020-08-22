Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D112AC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1022072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JNWO4pv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1022072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MV8-0001VC-Qc
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR7-0001y4-HR
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR5-0000D6-HZ
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075487; x=1629611487;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fuvZIk9VuvyiTai3ieMFQLTQavvAVmwSdtldSrMJcuQ=;
 b=JNWO4pv7mjPSx1Ai3A19vHxP6tTBhJ8mUt3mvCovLjW/0FbEc+skVp4E
 mnHArbCOXzFYKBH/h5TLhKbrGuWYqLm62AGd7E8JSfOsBLhZvY5ckDxPB
 s9+kC7oK58IdPLtawaaq4Do8PD0gtBmsf/64j/oONUYktcAZm5TNAbufe
 UG+vk+Ui3fgDBGsGLLjJ1DjGyefoULYHZIZdlWKIyYKE3+2zDOfTz+3EG
 Jc1yxBqvMJhxCAg3GU/9761cC6p1aeoXjPw7gPZgeGNZvR2uMdoWnsiQ6
 BLQlGS0tcTHzzMQABVAAdqepD+SnkaSUiql7InEJeay971socL0ycou+K w==;
IronPort-SDR: w0D7g5AO+YKmw0DwP9CzU0z3G4iLXZBWKyKlRPbVa76FrN8KuAtvQ5tpZq5TSXZrcUrJBWgXs/
 wxYc4kEmKpLEUeKLiDqglxsvHvUW6FWK2n96aJRFMakE5VgEeCp7HlsphIYEOx7r9tb3ePN1BX
 lg8tNKrrEjN4EzQZXvTNAFNmkMPT/yxhFcpHep+b89hegnaXyrRKHDIg+GFXlwBZ4r1mAYkJXS
 q71Ogmar0n7Ln92xRqwvnnxbzycYEvs7K/miO9U28RwppGa7O1Afn2wJ+SPVjgiDhplYDVSMh5
 pNg=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571968"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:21 +0800
IronPort-SDR: aY7QQnIAGBeQfOXEHZ6JNAz2XBi3AYke7HWFzDSftW6nfaqTVO0ykHFfOf/hlMJwfq9Yz8AfUl
 JBgjXVTFQULg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:14 -0700
IronPort-SDR: g6aX3EUXHAuXzg6f34kZwFVO1NkPLGTAQckdd2yIsR7qvbNxAUxv17lPL5hrPZYrn6bMd2FLKN
 HsqSTCohxNWg==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 15/20] gitlab-ci/opensbi: Update GitLab CI to build generic
 platform
Date: Fri, 21 Aug 2020 22:40:56 -0700
Message-Id: <20200822054101.1202175-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 alistair.francis@wdc.com, Anup Patel <anup@brainfault.org>
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
2.28.0


