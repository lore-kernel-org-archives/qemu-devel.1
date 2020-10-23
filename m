Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D42C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456E821D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="prMEvlm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456E821D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzsX-00085V-0m
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFC-00022t-HY; Fri, 23 Oct 2020 11:44:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFA-0003gF-HX; Fri, 23 Oct 2020 11:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467881; x=1635003881;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tVeLQH5d/2Mry1kB+Oc8jJWYNBfxFWaNX19V7lAW+bs=;
 b=prMEvlm5K7b4rjOEWn/jRsGMTXHz9XhZ0dnVCXwQBIRjSWjg2grp6ILP
 ey30X1ycSYlXJw/jNh2ifY4gFP2fidsMUeqqeEQOY7OiT8+n8qttLM6Pv
 CoxLJ4i1oVMIHYCsjpQFp+5vCujn9FvBN6ZTO1BrFF4Vduz2pqBs4rYOb
 sOLyRQTugVQFM0Lt4zCJjplCP3kxayxhtig1s8DxsQTsy7wpwYOFl+v+p
 zCQiInUXthzgaHH688hG4+bSXMgJeEfitUz49pVvjD89lw8YzWVGGV3ju
 f6pgEP6Y3MDXWSGtuRJXRea3V2WGyVDUL6YUCFFmbbmmjskMbuIYxfa0u w==;
IronPort-SDR: d3xymO1EL4XrqP1P/qbJre2UcUDawZ2ZPJ4k86/IcksfJ3D4RqPMsv2EamAsnBM05P4YBRQ5XT
 M+gZZY+qXt07eOVpCzqQYOuFV4DkjMO2HBHPU1eRgPdYrpt0Y3Z5+OYtiqEmZk6mm6KwfrLdmh
 H8Q9MS/XORQBMCc9LDluAWxkq/nRpUqNFe2XLqhstyjuhhrP070MKUWYbpPMQQolXTQjA8aEcZ
 nYooaTLtABI/Ufc7f+IyLltluDuSZrWmYL+RT7VLa65U94lc1svQ+wD3KUms1PDL3rb0fnUlDA
 PgI=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="151960153"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:40 +0800
IronPort-SDR: FZ0U56zvdIWhzJXm7DzBj4hqc3NKH7+SdZ0THwvlSSx4txJULuwQrkaa6tIoyRPg7t/eP0yrMO
 AEr628ObRUHDWggS1+Vimds4EvMz2JD/dvK3oUkoUPW+MqGgfmf4CdRCb2OCrveCh1dD4PF0F7
 BhIdEeHhH2zaBRB1mCdz1p//0GXTACN0LFBXGnw0PuU4WSS2dkubHpNXclMOMvRYNJNIs9q6ww
 Vpt6EdKDewzFaxC+YImcM/FCP0mb6NlP5/XwVOhVIjAoza16Ap1+V+D89DdKDPAoz+kkV/zlq+
 X+kviG/9hXCB/w9Gk9aapa86
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:01 -0700
IronPort-SDR: uyjIx8T53X8w1vm+0Md1+RQdsr9PyE/420kgkdvHtoYLlotvazEzKm50oari98EuMlz2mycAPp
 hANlagEvjABGhk0DiGUKMEPc9oinD9z/Ym3mp5AjdcSOs2Dzj1Ullxnn5l/h25/efUwYZQ/hSt
 BhDg+5VO9X2hguzZXuw7z/eJWx8D1S3vAIq+qRf4L3B9DrAkWZDMjCS+WM9iWf0xd8rMFiDzKB
 Mf+OBA2uB8E84fMjNFqlHb4gmmU5DSnt5mfivpMY/nvvltC/dwGxk5vA9btbjAl0yw/Yno1EmU
 fao=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:44:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 02/16] riscv: spike: Remove target macro conditionals
Date: Fri, 23 Oct 2020 08:33:18 -0700
Message-Id: <2f7f2621dda197492b848fcf186f1cb6fb3eb53d.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/spike.h | 6 ------
 hw/riscv/spike.c         | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index cddeca2e77..cdd1a13011 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -47,10 +47,4 @@ enum {
     SPIKE_DRAM
 };
 
-#if defined(TARGET_RISCV32)
-#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_BASE32
-#elif defined(TARGET_RISCV64)
-#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_BASE64
-#endif
-
 #endif
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index facac6e7d2..29f07f47b1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -317,7 +317,7 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     mc->init = spike_board_init;
     mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
-    mc->default_cpu_type = SPIKE_V1_10_0_CPU;
+    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
-- 
2.28.0


