Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658FC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7813E21773
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AuBjcdbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7813E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKLA-0003w5-RB
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:15:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK44-0005au-KH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuk-0004KY-93
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuj-00046f-Qt; Fri, 24 May 2019 19:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741675; x=1590277675;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=+7s/1pLt/imVrzqtURoQsJvM9/dXUZZNehbEBN3Vwxk=;
	b=AuBjcdbTQLOHuaeXIfUTkAJtIaGaYSxA97XDkNXVIK/j5006JhGsF+Iy
	PqqK4rI0DIdP1uQhPxFWKC360AtefvwJWJ0sd4Xf4GZsnYF0c4L8oia++
	nvRac6/e6Ko+zLHsXyanoR5zFxC9Dvo7FQqWZm0/PtqTJDgbQgeV/+uW8
	R4V821m3LgfsfZunRV06B6uEpW1dlkjeEHTgobywaA3X74/MUzfop3xc5
	8iysXQz+YfJVw2eOfpRDf4oVjeAbjaYlciYc6ZuRk0vRm1kXAslnq2IZP
	ZSJzZlYgJDKr3tvGy2Zg2T7xOwhRW+ygvbT78K3s1CmtGq2TNBuFeFI8p g==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307766"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:54 +0800
IronPort-SDR: TsqjmL6Ktgk/3hCaIJT9Tgx9j2GQSEmI199zqrSrN8fNZZRGQgnhPAZMnBr9Ce20FhCKr4BqC4
	+DepIpCzmgSegRdEi9GNQ88LZzCxYlbaTk9ngDoBWH6GqnYlt/bk2urYzzx2NoF9fyC3rot8VZ
	Y0sv0TRFQ55XGoGAwAyqbBk427N6WValRshoicKoHHnmiHfgeXp+iRCQAifF+z3WktSo9eXIgM
	Qu6LvjdSbUTPGjKWULIHvp3FELb2c2cXBJNllKYU7DdW3Z4NijGrCjz/4nLsCSvEL5FpmOTw5D
	sG2UY9EgScxe/Me4Szs//U2S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:32 -0700
IronPort-SDR: Z9hnk5mJfGfa5kUfWqU0jXKJtKjnH2NBQJ0EqyELhlXBn7Wg0zunv/aBM6SN9CQmpzkHm3PI2M
	QjYX1RaYK/01otSUApQzai/gxuglQ7l4aFbXWvEi4wajPb2hqmVQQa5vfQ7FYjaWmqF5FADqSj
	D7gdUuR2MyXEIG2QzcWdH6bE9Ptu1kkcoXDYFnqmbUYiJrxCCHxhx7L1/sHRyC5FOQbpVfH0mT
	s9SAdGQRiRq79uvozIXqAndyvXehymrHG6NqVTOnnIs1ejaX4VXBydBKMsgFO0LE1cliTmavh4
	MOw=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:47:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:58 -0700
Message-Id: <a16457bbdc3bf30a4bf6bbed688f80f48c7c2aac.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 09/23] target/riscv: Add Hypervisor CSR access
 functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c1fcb795cd..c52fde6e7f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -82,6 +82,20 @@ static int smode(CPURISCVState *env, int csrno)
     return -!riscv_has_ext(env, RVS);
 }
 
+static int hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS) &&
+        riscv_has_ext(env, RVH)) {
+        /* Hypervisor extension is supported */
+        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+            env->priv == PRV_M) {
+            return 0;
+        }
+    }
+
+        return -1;
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -727,6 +741,55 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Hypervisor Extensions */
+static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hstatus;
+    return 0;
+}
+
+static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hstatus = val;
+    return 0;
+}
+
+static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hedeleg;
+    return 0;
+}
+
+static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hedeleg = val;
+    return 0;
+}
+
+static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hideleg;
+    return 0;
+}
+
+static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hideleg = val;
+    return 0;
+}
+
+static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hgatp;
+    return 0;
+}
+
+static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hgatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -910,6 +973,11 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
+    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
+    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
+    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.21.0


