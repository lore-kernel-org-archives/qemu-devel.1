Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E12C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5F22074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lbBPH+Ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5F22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1Ih-00064K-7X
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BW-0002Pm-KG; Thu, 04 Jun 2020 21:30:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BV-00009e-8t; Thu, 04 Jun 2020 21:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320615; x=1622856615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rdQnbcwS1/XJv+bEImsb5HDjS91lveEuU4nRdEE6UGk=;
 b=lbBPH+RoUmIp/BbrAsLIHmy8xW0qDOOfCT2VpjY/nR1K6KGX8UhERpF+
 qA27HQwze8cEaaZAJahZcBcQBcnwMMAotZyHP8Kv29Qc4SXPaFNeAAyim
 sddfrQLhe7QSU+8qVg/a+aR2reSe/kQ5LcycaLdk9y10T7SkvU9uu6tAx
 4GX7f0PO4ObDFzsbeVX5RUmxZ8eo0Q7bX54EOVR32hfk6llraYtCbC4uH
 iKUmZEyf2abYVjglMDr0Dmd+ufgXVB70qfEsHfROFqXOy/VLs8VswlgVF
 SheDaKy8DOoDqbUgHATGCc1ufUWYdzBVGp8SCHOsqVC47rhH9yRDqhOLN A==;
IronPort-SDR: 0JzEWWcOQvQaKVsWQo6CZMW7bsr1/RYwRs4uCI3gKcoBA63AVNwayd/wSusY8sveE7BXm4+RNL
 i2FpoujxxX2JUZNPqZ2ieC/yeiFLqH9U+J9EnkH1LIfxxA34mnDxAg5TduxGOoVmbWVdwFuW5t
 ESWbZBDAC6DL1Bho9basFLDlJIEbUwwOR0l3jaALNposBZ52ayiIGj3qH7GgKbN0lwYYpHfiMh
 SN0JGMNNAH/+KvTYoq5Yqc7EiQ3wxN6BTHogBzANVPvyA+zNVlFwBQi9Lnaln7PBPcbEzktrzb
 wdo=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="242127066"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:30:13 +0800
IronPort-SDR: kLvBds1cA23u3y5XzyAySW37NidfwNpe1xdWI5z2uak8LUPqnzNLhGgFQDUkUnYIgh5q0/Pt8Q
 mhDNNh5cq8SWxHkaI2u+3qii07A3OxBfo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:48 -0700
IronPort-SDR: bF94EztjTptEXSs7uPY+z+wSkb9Wl6EVTdfMtQGyRmhRryAWRixOQUaKdmFyA2Cg3+U8YM3Bak
 Z762Wlwplouw==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:30:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 15/17] target/riscv: Support the v0.6 Hypervisor extension
 CRSs
Date: Thu,  4 Jun 2020 18:21:24 -0700
Message-Id: <5dbe9e7536efbd41f775fc3c189c49b39b83f724.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:30:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
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
index 8a145e0a32..690f327828 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -182,9 +182,12 @@
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
index 5b64539efb..9990a0dd09 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -815,12 +815,25 @@ static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
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
 
@@ -848,6 +861,18 @@ static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -871,6 +896,18 @@ static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -1268,11 +1305,14 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
2.26.2


