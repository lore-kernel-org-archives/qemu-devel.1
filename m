Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ECC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A513A21D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gwB+N8uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A513A21D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzut-00039M-HT
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFG-00024v-9a; Fri, 23 Oct 2020 11:44:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFE-0003gp-DR; Fri, 23 Oct 2020 11:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467884; x=1635003884;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mO2KDDBwgipSRnDouZyuQauB4BvzjCpnifeQek8HSUw=;
 b=gwB+N8uOGX8LXNCTaKG+DhY3y70QQdlfOZY8RBdUMUeDp86dcw6YI9y9
 ZJQ4bTzP0YR08MJl0v5PkVmgMjS0XXu85IdOpjqUDYJXNRezVabCGf43p
 vDqZY4P69+BlpFO4+/JEpqDtxrL3Pk/1emWS6QrtTbbz2sh7H/1CCTS5C
 zpfllFM/HMlJqE/49izyA5s9nVBl34ITdpDGlY+0LmU4+L2PHnnVD9Vre
 c/3+WB4rHIUV+PfLA/Uh1Yj5fCNLgtwx1EFYGw+erEtKRwdcKecUP/IKJ
 C4AFALR+pKwbBNxhfZydu9npW5f/GxQzoaRkXuSbviv4KtHdkmu0WZy7h A==;
IronPort-SDR: XmUK2ZMPxSlvQtw/O/cCpLZ5qTLVkJ54xDLdoUdg+dnIJ0JGtPG9oeuqV3OWqwdXd7LeGpSL0q
 ND7gTm3s/3f3vWa3wbTeQBS/D8gEZxUD7BlmKfj1nmbHusntpXu5OLT7/2deRPCylefI0BFzar
 I61xyEv92NBntWg9ehleDi19pQQxkZY8a+pmCeOxp3Hd0o6lO2iPI8d/vfd21mbgfQTCKvRLdG
 cAr40i3FWJjjrb9QaCijbI7GxVB9x5Y+rX7aNfqoDHpg1P2qN8v84TJO0YTqjqwPRQHy6kWPYI
 MtE=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150812572"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:42 +0800
IronPort-SDR: XyNvr5gYUPKDB2zY+GKE9voYnvcHG59slZkwkqMble4rx3JdvQhyVVVFKO7IW24KCs5tYHMC3p
 QS03QoqF6rl5h3xJY4JiS0WAd8DYMksbGuzYmUGiDhkMhMhYOn6LWqdu9TqNSIaIHQOUH4Fd1D
 B0K9nx+uTDfkZ53ofb92XcyCKfflnTwQA++UPE1vvT8iFM4AcPkEVHYpiuMkO3ffA9RGceg9m0
 /52fLVFtyG4zy3F4k5A9PA9ggE1JXZ7QfP69cx3NoZXErcEN3LS2yNtpNjUdvGBGiwEOblbpT2
 66+b9QbiT0JVnOd3QXBtbVCF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:29:57 -0700
IronPort-SDR: UZkSApcc2+K/I5TtgOdQXy8kX025DKJPNpVAB9NfwyGdHepyLZYfLxvpxWgrmSUYcHy4NRJjxa
 8B2lyXL/RYROEkM6bs2dy9/6MjmjI2B/zrGi+CntNIKNSGlgz61faxxegDdCOTHZU8YZ74rAjL
 DwQJdxiQmGCnxXaRgId50Jy7aSFJz0U5PR3FqTWYwL6Zij/rLu0nCBNDMgOATEOxcRRtG7SQzR
 4NxSdrJu3ukKjxDKyl+VS0zFK3fpsJMoXzfdv3toKvmx1eb/g2Yk2ZnGpJMCGTNfeMc4geriiR
 HqQ=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:44:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 03/16] riscv: virt: Remove target macro conditionals
Date: Fri, 23 Oct 2020 08:33:21 -0700
Message-Id: <9710f7917b7a1fcffce2d926005efc3bb84c0152.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:42
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
 include/hw/riscv/virt.h | 6 ------
 hw/riscv/virt.c         | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index b4ed9a32eb..84b7a3848f 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -89,10 +89,4 @@ enum {
 #define FDT_INT_MAP_WIDTH     (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + 1 + \
                                FDT_PLIC_ADDR_CELLS + FDT_PLIC_INT_CELLS)
 
-#if defined(TARGET_RISCV32)
-#define VIRT_CPU TYPE_RISCV_CPU_BASE32
-#elif defined(TARGET_RISCV64)
-#define VIRT_CPU TYPE_RISCV_CPU_BASE64
-#endif
-
 #endif
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6bfd10dfc7..5f1fcebdc6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -693,7 +693,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "RISC-V VirtIO board";
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-    mc->default_cpu_type = VIRT_CPU;
+    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
-- 
2.28.0


