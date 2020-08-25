Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B313C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C69A2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pcz6BKvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C69A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeJ5-00030i-Lt
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAR-0004Nm-IU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAN-0002vu-SU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381973; x=1629917973;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=obdMeo8q7+t9EDlbLxfrGkCLmPa2G3RybFJzvmtHowM=;
 b=pcz6BKvz93SGFF4JI390gGc2EJ6Arn9wj1zZohOmZkOcZhUy3ei4exdH
 neCXNPn+s5vKuMMkBAkG3Itkm/M1zuJbtrxBOwoDyeD0yzJW6uGHQLk+3
 ciI7fNC2ati1cONfRTf2FQ2jo4SZq9Ddu8kOs0ai1aGo26tJXnTKLk7pL
 orN2XeCFkpgdqQBNOF9o8xc/yA4g6GJUwLlfd6Q/10JP+Rv1Tq87xvijL
 Aoul23hslYYwFj7/5xuykurmxcnY1J4KR3W0MjNRE32/8cJan0VsrUWvL
 CL7NWnvDpluKHwiHjXceIKk8q/xfrR+wiRC2kJVTbEf0A4CJ91ug1x7wO w==;
IronPort-SDR: tVNBhiQ2GOSMxQNuZq4bf8954aDMmkxsHx6WWvmvWt2mjNHcrcnno+rEMHtQQYCKDYxCtP4se/
 fU5N4X/AmSrvtQ4Ckn/LJL1cjzV351tTpQVbFn2kaW/vvxPVTScO2GpfmDsAb721XD4rD+0TL2
 c8s8Coz8b6rMZ8+PPfGHX/HdYMMHfrCzQ+2ePmeO04lYFaY3cQWCTPsSgb47QQwWww2R/REa1C
 DMEoDVMpP+j0+q9RQrqCZVW+oEnCniCoZM5yWcj+qg9+MuFR4MVPBzxn+4Vn3pF/jaHfFTgjCt
 4Co=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145299"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:58 +0800
IronPort-SDR: xzVl+DTuKGi50sphAuNEBFfvrs4h2Jg1uA9Z46LHuo88KUOm8dwWaFDZJErsE8VLZFHsCQja4r
 BXDmYLTcfgBg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:33 -0700
IronPort-SDR: emIWswTmUDFuWoBLllH/Hs+RLSMo1I2LYfjxuNoFjSG6nZ6vZLzK5b/Gl0sflMjb93IVEnquJH
 zkPy6JBgHCqw==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] target/riscv: Support the v0.6 Hypervisor extension CRSs
Date: Tue, 25 Aug 2020 11:48:34 -0700
Message-Id: <20200825184836.1282371-17-alistair.francis@wdc.com>
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
Message-id: 644b6c114b1a81adbee0ab8c9c66a8672059ec96.1597259519.git.alistair.francis@wdc.com
Message-Id: <644b6c114b1a81adbee0ab8c9c66a8672059ec96.1597259519.git.alistair.francis@wdc.com>
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
2.28.0


