Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34377C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E3C206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RbFBdfYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wUt-0002XF-8z
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLj-0005Mu-Vj; Wed, 12 Aug 2020 15:23:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLi-0000Va-2F; Wed, 12 Aug 2020 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260226; x=1628796226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b3JcuKO+BmRuOqMKj+1jygBcHjqj6T22fWMw2Dk7EaE=;
 b=RbFBdfYCV/GJXXMvRPrM5tUZJ3CZrmHpAoKGl9FJOtCPjJGARMNJ8flX
 N51URWNQSzG6XmvD4j317YOhxkHSmi/tEk6pC3nmU42YteiCejliAABqa
 JAj8jsW5egkhWN2Q3NkvWyeYQC9/YjdRkFGTtLlD4OGPHipt0HD54TGVw
 mh4TNKkdop0Unx3F2pzVT3x3o2j9oLPRhe1QUVAZvRohvZWsbuX1MS7Km
 8YuKDKAX8Vg7Omf2t75l1fjV9YNvB+J08W2VCumshOPZz59ZG3usckDZM
 kV8GUeLDSQLNd6yAjo+dnFkbKA2hsJR1K5jKUD5t/yBRMZtIxe3+SLwtK Q==;
IronPort-SDR: oWJVMO3ZhG5NPEQovLoD/P3/iGmASCBoeSGJG7yX8Kwr5BR8lwuwgD/RdZg6FtZL17zRUdkmVR
 fKKlrZgCLSXaoYC3BevkCUu2UIY9m1+e4quI30TWkfgQx9UH/1uTZifg54/RF8RrXwysUgGpYh
 TKiDmGleW9HdAlIa+PffqX79x+3vK5CPkMZfUgcuwk2adcNX1qeF2fotVQQTKWZAagiPbkfyct
 u5elGonSYGncIgam7do+xrki9fq3LfmXkHmiBNlYw3wHpXdYGAi5O9daVq6O7XG3A2jCgrZqfJ
 XL0=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029213"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:44 +0800
IronPort-SDR: 8ey442028y/wFLMoqA/iwugdxDCYSMkshuesCx6M2ma/Hod1ZSNO4KtqLLr5KSCs+wonhB5FPq
 uQOqcOF8gTaA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:52 -0700
IronPort-SDR: kbMWJKpA77Pz6dDH0+poUud5pet7du5OgPB8NXcfRpFAYafLF6HWnJ3D6HEx6PjaNrzmy4/F4f
 3sdXkXAkcu9Q==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 11/13] target/riscv: Support the v0.6 Hypervisor extension
 CRSs
Date: Wed, 12 Aug 2020 12:13:44 -0700
Message-Id: <644b6c114b1a81adbee0ab8c9c66a8672059ec96.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  3 +++
 target/riscv/csr.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 573d85da41..d88e2ea30d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -197,9 +197,12 @@
 #define CSR_HIDELEG         0x603
 #define CSR_HIE             0x604
 #define CSR_HCOUNTEREN      0x606
+#define CSR_HGEIE           0x607
 #define CSR_HTVAL           0x643
+#define CSR_HVIP            0x645
 #define CSR_HIP             0x644
 #define CSR_HTINST          0x64A
+#define CSR_HGEIP           0xE12
 #define CSR_HGATP           0x680
 #define CSR_HTIMEDELTA      0x605
 #define CSR_HTIMEDELTAH     0x615
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5e50683c58..7dc50e6299 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -883,12 +883,25 @@ static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int rmw_hvip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
+{
+    int ret = rmw_mip(env, 0, ret_value, new_value,
+                      write_mask & hip_writable_mask);
+
+    *ret_value &= hip_writable_mask;
+
+    return ret;
+}
+
 static int rmw_hip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
     int ret = rmw_mip(env, 0, ret_value, new_value,
                       write_mask & hip_writable_mask);
 
+    *ret_value &= hip_writable_mask;
+
     return ret;
 }
 
@@ -916,6 +929,18 @@ static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_hgeie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
+static int write_hgeie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
 static int read_htval(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->htval;
@@ -939,6 +964,18 @@ static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_hgeip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
+static int write_hgeip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
 static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->hgatp;
@@ -1341,11 +1378,14 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
     [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
     [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HVIP] =                { hmode,   NULL,     NULL,     rmw_hvip       },
     [CSR_HIP] =                 { hmode,   NULL,     NULL,     rmw_hip        },
     [CSR_HIE] =                 { hmode,   read_hie,         write_hie        },
     [CSR_HCOUNTEREN] =          { hmode,   read_hcounteren,  write_hcounteren },
+    [CSR_HGEIE] =               { hmode,   read_hgeie,       write_hgeie      },
     [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
     [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
+    [CSR_HGEIP] =               { hmode,   read_hgeip,       write_hgeip      },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
     [CSR_HTIMEDELTA] =          { hmode,   read_htimedelta,  write_htimedelta },
 #if defined(TARGET_RISCV32)
-- 
2.27.0


