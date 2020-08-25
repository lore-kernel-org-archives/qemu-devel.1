Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F8FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA5B2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PvaZXYUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA5B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeGg-0006vu-VO
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAD-00047X-L1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAB-0002vu-7N
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381960; x=1629917960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k75PG8pSJEwmv+JdZyA6pvKckZc/AEds1/bbOPRHCgI=;
 b=PvaZXYUgwPMXL5Ar9UORvPN9Q6WwpWqdQpAYJ0aO94i1IqpoYVWVoMkg
 Icz0BMtkhJnlPvgQE87U3eOFmDUwoxWAxomcJuw9MgFpr7lh3J5tqQz+O
 i1cRxSdlpcH06yfdmRNMoycFq89dmzdL9jh778FhcwKDQ9gLwD6+SBn+Y
 r8P+2ZzJQErk+LqQowqcXtSX7opKq8ESglf7aGXlqnLsRcOps/2XAKNax
 /w2FBU1+L6cv1aGHbaWLQOk96i62T3eHJK4Ovaw0w1iesOSKmPBDXTMNc
 dDK3kwAqQFs434CNrvWZbb/a1nMAAkWV6NGPFmjKASZ5eId1usoRVF5qD w==;
IronPort-SDR: Sbl6HeknL7MxLsHaN1tnQGhUJ3bdUAsYu/5WuFORs3SOJ6r7JUPRs+CbBuv+zrsiEw4kczMehh
 4PrgjqF71kYEMtMf/kU5beB8dCFFD6kiWLEZH6mVSX0v+01/MAeiltTlRePe+AH4uNKui1S67G
 2hTuxVjnSOAp0jT3rvFUG/aATYJisgzqrwqUC8IEUgBi1IziSsC0xGiKUBmSASJbOV3sn5hT7u
 480Tkyx4vGjPmWGF0XRGdTunIfdDfF2iBHrCV4iMr202Y60xlfNZMIwYXk4YYbIwIDalSEq9Kb
 w7c=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145295"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:57 +0800
IronPort-SDR: QBzKTJT5AufJz+m76+35L0YVDnrbx+MJNWc5vCp91Pdr0xFogRLS8jypkzX0t/hJTuTFZmA/aN
 vi3ggGK/3C1A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:32 -0700
IronPort-SDR: WnzV18UJgRkM2xgr7AKXpFCvM1Hl9tQfvP2Yrt04oryka+GC+hX367x70fnhDIOE6Ig401zurN
 R2l2aiO1uSpA==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] target/riscv: Update the CSRs to the v0.6 Hyp extension
Date: Tue, 25 Aug 2020 11:48:31 -0700
Message-Id: <20200825184836.1282371-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 4f227b30cb1816795296c0994f1123fab143666a.1597259519.git.alistair.francis@wdc.com
Message-Id: <4f227b30cb1816795296c0994f1123fab143666a.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fb6a3e9092..573d85da41 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -437,15 +437,17 @@
 #endif
 
 /* hstatus CSR bits */
-#define HSTATUS_SPRV         0x00000001
+#define HSTATUS_VSBE         0x00000020
+#define HSTATUS_GVA          0x00000040
 #define HSTATUS_SPV          0x00000080
-#define HSTATUS_SP2P         0x00000100
-#define HSTATUS_SP2V         0x00000200
+#define HSTATUS_SPVP         0x00000100
+#define HSTATUS_HU           0x00000200
+#define HSTATUS_VGEIN        0x0003F000
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
-#define HSTATUS_HU           0x00000200
-#define HSTATUS_GVA          0x00000040
-#define HSTATUS_SPVP         0x00000100
+#if defined(TARGET_RISCV64)
+#define HSTATUS_VSXL        0x300000000
+#endif
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
-- 
2.28.0


