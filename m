Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740E2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD5E2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f64il1Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD5E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNrQ-0005HM-Fn
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaq-0007Qb-4p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNap-0007Ua-0d
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNao-0007TS-Oy; Mon, 09 Dec 2019 13:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915430; x=1607451430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hdFYTa8nuoS5vpBd2+mk08dQE6Uw8kRTfLExTl5You8=;
 b=f64il1Mq3wTP/MN1lYtWpgEwr64aVLj9cVhdDI6Jy7B4tqzMQhNu0jTI
 lUXL9M4p1gC3+uv26U7KcFDoKZ7lTrzbiWrI4uXTTRM9z2BbMCuitz+Ky
 +Uiy0KX436Ntm5EyCL68+VXUvU/2g3Q24IBSd15ULui4KV9YURxHaHFZr
 a3Tuc9Dm7tSt0YGKKj18t6y+09Fv/5XkdGNqhpPhfaW8HCgyrdFtTi+Xx
 72jRy/HIo47PFCpdxYe/JfsnoAdzZTSqWz0pqKoEMdKwlfL2IPkGrcpRz
 Mqx+SwoeR0xetraA1j2Fv1QUg9aBm6awrDae5JKGleD5//So1XIWblLHo w==;
IronPort-SDR: aMGicJ7DLp62+7ltBERBQSctdAwKQ63c5Bovv7qX6D/0OWypAy8uruDcZC0MgJL+eXkBu27jnm
 9LkHLQitimHNnFXziVEkfgPeg6TG+f06eU5OIgFVdgcsMt9eNpWcbl34Vkcg7baOEXvCauw/P9
 gPClDcKH9l36opjhG/fFIGSQdROJLwNwRSX3vsZsZIidvR557z1RrVFVlRLuZt0yxTfFHeLx15
 rxEcMr1S4x7gGoyR2EUv3YcPVu+UNEMeY6ers0HrygRyyJpeB5+zbFCKcesmr4lJ9ergK7mKBs
 Ia0=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="232461552"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:09 +0800
IronPort-SDR: awNa/K5zzGBqo/fwTpRG+/BpBcWpWktHxo0rAv+B6co93U6fhnZdyPx9TtLlFOCDlcn/nCxhoa
 eZoRqo8bnkjfSLtOFedZ11asLx61u71mcxlzZs5asGDQSPWM1qHQp71And7WrGPWn6LmK/wyNY
 571wQgesBT4YX4hos6hw5Nl9tGkHlPZm5RXitU7hFs7qarPAisSfayWA/264fZ9yWfRN6KF/YD
 fADjcy/Jwma3w+wL4J4HMINkkNyrnZonGaXNg9rUaULbNpOv0ROICw9CzBzTke8y0s4kumutig
 AwxXjrcCytfKsev7a01SNU3u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:25 -0800
IronPort-SDR: 9DGjPov6QmDxhHIyLlngTjgf7esmiNzf5y5oTu0rpDuEPX4m52MPTPGT0knRYeqm06FPn1dixJ
 XHVlRpZpEL0ZasB116Dj5QC1MrqY7wDQAQ20F5tZvoojvqEJ3SThDIyg7jLAjcbhgUIOMSHS63
 gwdbTjfo/B9w1j1ceTmJgeQObmkKw4ZI9VGuVkZ2JhAq0/U5QN7TaO5X27HhwqwWeuA4GSqzDm
 mi4i1BLHkqjQvZ/sHZYdRTo6WmsouUeLt1Beg+YuqcfgRtDzAOd+MAwYidcu4I3MUYEWrdyALs
 G1M=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:09 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 18/36] target/riscv: Extend the MIE CSR to support
 virtulisation
Date: Mon,  9 Dec 2019 10:11:27 -0800
Message-Id: <6ec43c1bf0886d917fcd88d3751d72def5507db2.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fc38c45a7e..54edfb280e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -244,8 +244,10 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 #define S_MODE_INTERRUPTS  (MIP_SSIP | MIP_STIP | MIP_SEIP)
 #define VS_MODE_INTERRUPTS (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)
 
-static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
-static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
+static const target_ulong delegable_ints = S_MODE_INTERRUPTS |
+                                           VS_MODE_INTERRUPTS;
+static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
+                                     VS_MODE_INTERRUPTS;
 static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_INST_ADDR_MIS)) |
     (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) |
@@ -631,13 +633,27 @@ static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
 
 static int read_sie(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mie & env->mideleg;
+    if (riscv_cpu_virt_enabled(env)) {
+        /* Tell the guest the VS bits, shifted to the S bit locations */
+        *val = (env->mie & env->mideleg & VS_MODE_INTERRUPTS) >> 1;
+    } else {
+        *val = env->mie & env->mideleg;
+    }
     return 0;
 }
 
 static int write_sie(CPURISCVState *env, int csrno, target_ulong val)
 {
-    target_ulong newval = (env->mie & ~env->mideleg) | (val & env->mideleg);
+    target_ulong newval;
+
+    if (riscv_cpu_virt_enabled(env)) {
+        /* Shift the guests S bits to VS */
+        newval = (env->mie & ~VS_MODE_INTERRUPTS) |
+                 ((val << 1) & VS_MODE_INTERRUPTS);
+    } else {
+        newval = (env->mie & ~S_MODE_INTERRUPTS) | (val & S_MODE_INTERRUPTS);
+    }
+
     return write_mie(env, CSR_MIE, newval);
 }
 
-- 
2.24.0


