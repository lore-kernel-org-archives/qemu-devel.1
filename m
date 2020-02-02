Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0A6C3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD5420658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RztdsuQE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ki0ZRP8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD5420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyFYT-0003U8-3c
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 08:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWV-0000Ta-P3
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWU-0003x2-8p
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:42:51 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWR-0003tc-5H; Sun, 02 Feb 2020 08:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580650967; x=1612186967;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=QuS3olHHfV6t+jSRO7M+pyUXltUVml9I3joGNktRt10=;
 b=RztdsuQEU8aRwExr6VwT0NulE2aYecoCudjIYLkSNFP0LdrclCh1QQjc
 20oumNwYwq6W77GUZ7gL9HJEWjp/eMIl8a115uwcrcspXLyCZz7wiozZn
 XP0s4+CyfNEBqVw0af4D8VEIAQWCmtMQifnMLigeyBpomCzTsh1F+uyPe
 syICjTMdPJVOfNSqwVFV7mrNiDmnIM0IhSHTxyayFaLiqhYtl/+f/O+KC
 QOi5+jgdlWe6z5UejmyjpUYwW5vNMqO/CLfYkL3iJqf1pzrdic9wqtH1y
 qtNhOXHHTzmSzISAlYql2dXyDamWTmccwwVj2dQsX6dKLrGqFr+pb36uO A==;
IronPort-SDR: 9MQGNjpTTypYLkMp/rH2j9gf8qYT1egAhbYVVknqozkAl8UYBbhoFAE0cat+xoVibjc5MkRAdp
 4BJapw/nCf/XQhBKSF++Q28dfB6tUDdO4VAWugZk6hJCkPG6l9/8MSC/uXvOLxYlIVozDz4T2s
 wdHd8sORdIb3kxAEwoBTDOhjpBMl+CG6BLcgTuqPTRjQivmmYlhxUmpmu0KbhJ6O/dKONri+AX
 fBGb+BoMmyr/EW3N9v/x0jso+ZWv1mUtU9pCgQRBnFHnPdEw+rSnIyo8KGLxYYtcUFQti+M1es
 VNo=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; d="scan'208";a="128929961"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 21:42:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3jkuzeYYFSkM0QBm1tm97qkBpQif3WR5wLoRFIM83RcXNDh6Q5Ff9B94TTHxZB+9DoywQ9CMLq4VkA/n70oFeRilNOHjiSI5eD6o0eUNSr7Cib2ZwMjbfJ8Wa/arOGW3vtHjnX4DyFSmHrTzbLvAfUrpkHivD0PTXUrY1JLG4+0WA/QwMPONA8OIDc1qFOQNQZF4xCzguE3q4ZgR1iSIwaT364isj+hjQX2PA4h219xMXW41V85KpSCX4SHZWINfUWV9wF6PrraG1ITLG/xL88a/7fdJzMQKNjzHjjJCTUUDx7pmUKhbI1umYnO42htChuQgzLNk8ktNQzQP4owPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2uz1gLcCLMoSQdQ7Dw0w/PyU7uf8MuTt5ZW1JUgid8=;
 b=cPlwOjgc+0R+YlzG2QCmzzVPeUlC9IFHwJYfSIJeCVcLh7uD60O3xkhMFoogdDcEtrqUgnk91ggOlX9DO0jRYidYTqquqyI+FeH6qYaKGwhjx3RQCBLZjQjlT8Bnw4PqOQHRRT52aYi75EiFRvgnenhI+fsYsUCQRnXYJaDSUbJ7tg0EZfhBdHIjKmzaV46F4Zq8SXu015TcimdhtZNtrl3M3OHNeVDO/A+21/VuXlSc55v7leI+hFrZ+lds+l99Fh4uu6WRlnwApuOOgI7hnwcNVMfLzgn6uKp2A4Rv0EIZZYJ2EMexwAjFnMPQAXeRtwEtHaBzn+fMyBxcMaTq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2uz1gLcCLMoSQdQ7Dw0w/PyU7uf8MuTt5ZW1JUgid8=;
 b=ki0ZRP8WgW3y5fkp9N9PFTlP5URWgSD/mWPjTHQc67img4X9A5ApoqflwVoHrRuaT2JWd7I89i2FBt7qFs9dKN+2NdEf+e7ZTOgc4+hAP83SmOEmH1QS4tfhiUAikf5YtzwR+P4u1J/wlN1rs9WRIN/7IAH0FUXhkNTxEnvkwDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7038.namprd04.prod.outlook.com (10.186.146.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sun, 2 Feb 2020 13:42:38 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2686.031; Sun, 2 Feb 2020
 13:42:38 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 1/2] target/riscv: Emulate TIME CSRs for privileged mode
Date: Sun,  2 Feb 2020 19:12:16 +0530
Message-Id: <20200202134217.14264-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202134217.14264-1-anup.patel@wdc.com>
References: <20200202134217.14264-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
Received: from wdc.com (217.111.249.45) by
 AM0PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:208:3e::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Sun, 2 Feb 2020 13:42:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.111.249.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbd429fe-962e-4c74-b463-08d7a7e5c469
X-MS-TrafficTypeDiagnostic: MN2PR04MB7038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB7038EEF2EB0E92DE8ECEFA718D010@MN2PR04MB7038.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0301360BF5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(26005)(5660300002)(186003)(316002)(16526019)(6666004)(956004)(2616005)(44832011)(36756003)(8936002)(110136005)(4326008)(55016002)(1076003)(54906003)(66476007)(66556008)(2906002)(55236004)(478600001)(66946007)(7696005)(81156014)(81166006)(8676002)(86362001)(52116002)(8886007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7038;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwUCAi+eUD53ilfvC/DXTlPg5JPqR4XFvDDm+DP58DqWReZPlm67TGJeRIJvPSh7hd0RGMFxvzIiBUqd6i/h0uVe486h8I1e0Pkq4C78QXwdLrzln85jEo7K3qOfysNa8StZnW+cI73ieOAfEPBFZgClpQrCjSYrZwj83deXXGsC+okXUEpA3mX/Z5aXVYbQat931NA6hxaTFyuv0Yv7myOwzqQr9rQW4mNfMbwDF7ECJdhGV0pI+esLX7VN4QiAFyKMrPn/d+MdRRs62eanwHH0QjvXdEWKnlBbNbFvjW2DHkq27Qwp+yhE1Vro3j9eN5qnFJBLDrI1Xc+7HtGSK/A3obQ9o2qcjtvxawcfr4pBRHkVxEDPFN6KDxoHQwx+FmuUJ1dOOarPbBAfU78G4fN4lDCpBAbRiZR0J1nf9p8BG+ThOqFhgIGT3wTHzVP/
X-MS-Exchange-AntiSpam-MessageData: qCHqy45Gw2PhHIHulMGhF9rCO7KFCG6hCvHK55JnBfaQWMpVqi/GRzZ/FmT36SAoYfEdMz+k4FU1SX91STpBCxqyHV1JjPhpCXJdpYrp230BalOOgNdvThndLCfEWMDSRoioEQQLa3sg4dGh38fStA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd429fe-962e-4c74-b463-08d7a7e5c469
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2020 13:42:38.2414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9woOID+pSDETgyuNwoVMZ5yyYbwsbNQ/rsPvhxb/fjHqs/6q98lQGHDgx/rpUWDQ+KQvhp3RrZpdUE+Fg4VmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7038
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, TIME CSRs are emulated only for user-only mode. This
patch add TIME CSRs emulation for privileged mode.

For privileged mode, the TIME CSRs will return value provided
by rdtime callback which is registered by QEMU machine/platform
emulation (i.e. CLINT emulation). If rdtime callback is not
available then the monitor (i.e. OpenSBI) will trap-n-emulate
TIME CSRs in software.

We see 25+% performance improvement in hackbench numbers when
TIME CSRs are not trap-n-emulated.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c |  5 +++
 target/riscv/csr.c        | 86 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d52f209361..3dcdf92227 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -159,6 +159,7 @@ struct CPURISCVState {
     target_ulong htval;
     target_ulong htinst;
     target_ulong hgatp;
+    uint64_t htimedelta;
 
     /* Virtual CSRs */
     target_ulong vsstatus;
@@ -201,6 +202,9 @@ struct CPURISCVState {
     /* physical memory protection */
     pmp_table_t pmp_state;
 
+    /* machine specific rdtime callback */
+    uint64_t (*rdtime_fn)(void);
+
     /* True if in debugger mode.  */
     bool debugger;
 #endif
@@ -322,6 +326,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
 #endif
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b9e90dfd9a..cc9f20b471 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -258,6 +258,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
     return old;
 }
 
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
+{
+    env->rdtime_fn = fn;
+}
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     if (newpriv > PRV_M) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 572a478e8c..11d184cd16 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -238,6 +238,32 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 
 #else /* CONFIG_USER_ONLY */
 
+static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
+
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val = env->rdtime_fn() + delta;
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
+
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val = (env->rdtime_fn() + delta) >> 32;
+    return 0;
+}
+#endif
+
 /* Machine constants */
 
 #define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
@@ -930,6 +956,56 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+#if defined(TARGET_RISCV32)
+    *val = env->htimedelta & 0xffffffff;
+#else
+    *val = env->htimedelta;
+#endif
+    return 0;
+}
+
+static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+#if defined(TARGET_RISCV32)
+    env->htimedelta = deposit64(env->htimedelta, 0, 32, (uint64_t)val);
+#else
+    env->htimedelta = val;
+#endif
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val = env->htimedelta >> 32;
+    return 0;
+}
+
+static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
+    return 0;
+}
+#endif
+
 /* Virtual CSR Registers */
 static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1202,14 +1278,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_INSTRETH] =            { ctr,  read_instreth                       },
 #endif
 
-    /* User-level time CSRs are only available in linux-user
-     * In privileged mode, the monitor emulates these CSRs */
-#if defined(CONFIG_USER_ONLY)
+    /* In privileged mode, the monitor will have to emulate TIME CSRs only if
+     * rdtime callback is not provided by machine/platform emulation */
     [CSR_TIME] =                { ctr,  read_time                           },
 #if defined(TARGET_RISCV32)
     [CSR_TIMEH] =               { ctr,  read_timeh                          },
 #endif
-#endif
 
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
@@ -1275,6 +1349,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
     [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+    [CSR_HTIMEDELTA] =          { hmode,   read_htimedelta,  write_htimedelta },
+#if defined(TARGET_RISCV32)
+    [CSR_HTIMEDELTAH] =         { hmode,   read_htimedeltah, write_htimedeltah},
+#endif
 
     [CSR_VSSTATUS] =            { hmode,   read_vsstatus,    write_vsstatus   },
     [CSR_VSIP] =                { hmode,   NULL,     NULL,     rmw_vsip       },
-- 
2.17.1


