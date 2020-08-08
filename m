Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC712053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ueQNLumB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC712053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OV9-00070E-AU
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHn-0007kF-JD; Sat, 08 Aug 2020 01:20:51 -0400
Received: from mail-oln040092253026.outbound.protection.outlook.com
 ([40.92.253.26]:6035 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHh-0003EI-LI; Sat, 08 Aug 2020 01:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4sFzx22NL9yHIrYUH9kHRSzY/0g0nt61V3D1hDlKejsdF65//bu0hZ3jLVyhw5v73IAu2Tkg7YJ8EarI1aU761n1d9/s0cKxfjA/e/tzZwowSQkQ+wKUq+7DwY3psCC4qhRmKStoc0dSRfENOzaMgvU4k7HIVz58C9EG/a5plkyJL+9AeFFJU/d+PEllpv9UwdHKZdN7XqikSNOY+QXtp8dznYcEYeANVRW1mTqbVamPbJV5XmCRphM7Eb5TCIsjD7s/Q9mKql04TBSCFlHVxsVRrcCilMgDIpswbAlZ66DYqkn19V5lz3y18sSlt/g3O/umr9HtbU2CsM/nt+rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WKS20sgAIub+ADs2QizCC26J4BbnDH98WrRZWpLpqc=;
 b=FFIPByLdYchY1hnjTXheNO9TUNZkplAUaDRAegg/88x9sV8ho5hbuVTwia5FB+QSzb2Yd1SmlaeD3zp0VqZqz71vxT0z3yAY5lAqr0QObMbxNVFU45zpBmJMRnG1XhGQNXuTujUm9akh76i6t8dEuvGFVI/vIkVFyJquUbPzC/9A3dqrWG/96JcJglCz0daWtgmH3Ocjncht9SNQhLQsaSy0w3zX5GV6/d3KBVfJnzU0B6M7uyb+Yp8J8UMg6fky5Us30QuukQMXxdxGryPbbsdgenN+DcZZdVyuq3+n+m1y5xQKVJO+bfy6KthXASMp2uGGaAVKd4VTuS7nm66zyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WKS20sgAIub+ADs2QizCC26J4BbnDH98WrRZWpLpqc=;
 b=ueQNLumB5KjJHHk6euSQRdB4+ux7/77oFMuWnJq8MWCa3a6byT8wNoipO/cUGEn3scUa/tvptvFs7H1c/qQ7gvfitJih5k/Bnb+iQbSqfgEKCnGt3fL6hv9vHfVmrNWvTfG52BfE5EihWpas/XUnZOFnV8SVhPfMIj2qooNnfqqptWnTdTbrPYrY9Lus9wTafyX8IUUwqvYkKwwXTieSebaLXCHAJQ+IFgqI5yhoaROZSemWt6OOTVyrVEuQSSnmcRKVe7d8m5swUlZZpmATKEY1bU3B895UJ1LBbY6YHKic3AKzfX7OYZZHgxP3KYKfl2gsOIZhEDN7Jo0wWB2BPA==
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4c) by
 HK2APC01HT185.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::277)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 05:20:40 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebc::53) by HK2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebc::195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 05:20:40 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:568699852E44F04F584B013C2FFB98883BACD92C0605364B0642170FD2ADD4EF;
 UpperCasedChecksum:AC604F6E81E1EB83138CE6A0058E271AB125996621484982695E351AF4E17325;
 SizeAsReceived:7706; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 05:20:40 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] Implementation of enhanced PMP(ePMP) support
Date: Sat,  8 Aug 2020 13:20:29 +0800
Message-ID: <SG2PR02MB263419111A4265F689347F0593460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808052031.19523-1-weiying_hou@outlook.com>
References: <20200808052031.19523-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808052031.19523-3-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.141.129) by
 HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Sat, 8 Aug 2020 05:20:38 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808052031.19523-3-weiying_hou@outlook.com>
X-TMN: [G3ZufwdFruINLK0jpuyFpg0p3k9wwwi+]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 681d3b38-bce2-4494-3c30-08d83b5ac9d8
X-MS-TrafficTypeDiagnostic: HK2APC01HT185:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1+WVXXDGZDojx3naFSsCR7G56CuRWXXHKF4xGREVuzvz3QIWNOjs+84bGI7MUhRMpTRO8o3UmhF7Hy3qEBvj9fmSXlbX95I2xq4XhGow5rkFrei+mhMSQ8SkR1C80bro+hY1eZxQrRiXHVfwmKrQiXPzCKnsxY7fHApGRcdl6wktILAxKin0sjETFtW4/dCfRE5hp9aHoKNqwAxZKcG9YTFqJGXNmOVMPOZW711DStYMXil+inFLUdq2yAUUt8h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: iUu4+I4VKhHZDm0CBrmzAqlizdVzkK6lvFXumkKBSm7vTL905TMPDkKKQ3S7dfxgD4ZBtauJf+H09x9Q4nsJtkdOhjrAJ+mGt+EysbTlEYkn9dVGXKaYS4SS4hjdF4dds+xjmzxLycQF0HuCkt/2Cg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d3b38-bce2-4494-3c30-08d83b5ac9d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 05:20:39.9549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT029.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT185
Received-SPF: pass client-ip=40.92.253.26;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 01:20:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 Hongzheng-Li <Ethan.Lee.QNL@gmail.com>, Alistair.Francis@wdc.com,
 Myriad-Dreamin <camiyoru@gmail.com>, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ePMP can be found in:
https://docs.google.com/document/d/1Mh_aiHYxemL0umN3GTTw8vsbmzHZ_nxZXgjgOUzbvc8/edit#heading=h.9wsr1lnxtwe2

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/pmp.c        | 134 ++++++++++++++++++++++++++++++++++----
 target/riscv/pmp.h        |  12 ++++
 target/riscv/trace-events |   4 ++
 3 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0e6b640fbd..8df389cecd 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -34,6 +34,26 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
 static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
 static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index);
 
+static char mode_to_char(int mode)
+{
+    char ret = 0;
+    switch (mode) {
+    case PRV_U:
+        ret = 'u';
+        break;
+    case PRV_S:
+        ret = 's';
+        break;
+    case PRV_H:
+        ret = 'h';
+        break;
+    case PRV_M:
+        ret = 'm';
+        break;
+    }
+    return ret;
+}
+
 /*
  * Accessor method to extract address matching type 'a field' from cfg reg
  */
@@ -99,7 +119,28 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        if (!pmp_is_locked(env, pmp_index)) {
+        /*
+         * mseccfg.RLB is set
+         */
+        if (MSECCFG_RLB_ISSET(env) ||
+            /*
+             * mseccfg.MML is set
+             */
+            (MSECCFG_MML_ISSET(env) &&
+            /*
+             * m model and not adding X bit
+             */
+            (((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) ||
+             /*
+              * shared region and not adding X bit
+              */
+            ((val & PMP_LOCK) != PMP_LOCK &&
+            (val & 0x7) != (PMP_WRITE | PMP_EXEC)))) ||
+            /*
+             * mseccfg.MML is not set
+             */
+            (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index))
+        ){
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule(env, pmp_index);
         } else {
@@ -230,6 +271,18 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
+        if (MSECCFG_MMWP_ISSET(env)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pmp violation - %c mode access denied\n",
+                          mode_to_char(mode));
+            return false;
+        }
+        if (MSECCFG_MML_ISSET(env) && (mode != PRV_M || (privs & PMP_EXEC))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pmp violation - %c mode access denied\n",
+                          mode_to_char(mode));
+            return false;
+        }
         return true;
     }
 
@@ -261,16 +314,65 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
 
-        /*
-         * If the PMP entry is not off and the address is in range, do the priv
-         * check
-         */
         if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
-            allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
-            if ((mode != PRV_M) || pmp_is_locked(env, i)) {
-                allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
+            /*
+             * If the PMP entry is not off and the address is in range,
+             * do the priv check
+             */
+            if (!MSECCFG_MML_ISSET(env)) {
+                /*
+                 * If mseccfg.MML Bit is not set, do pmp priv check
+                 */
+                allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
+                if ((mode != PRV_M) || pmp_is_locked(env, i)) {
+                    allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
+                }
+            } else {
+                /*
+                 * If mseccfg.MML Bit set, do the enhanced pmp priv check
+                 */
+                if (env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) {
+                    /*
+                     * Shared Region
+                     */
+                    if ((env->pmp_state.pmp[i].cfg_reg &
+                    (PMP_READ | PMP_WRITE)) == PMP_WRITE) {
+                        allowed_privs = PMP_EXEC | ((mode == PRV_M &&
+                        (env->pmp_state.pmp[i].cfg_reg & PMP_EXEC)) ?
+                        PMP_READ : 0);
+                    } else {
+                        allowed_privs = env->pmp_state.pmp[i].cfg_reg &
+                        (PMP_READ | PMP_WRITE | PMP_EXEC);
+
+                        if (mode != PRV_M && allowed_privs) {
+                            qemu_log_mask(LOG_GUEST_ERROR,
+                                "pmp violation - %c mode access denied\n",
+                                mode_to_char(mode));
+                            ret = 0;
+                            break;
+                        }
+                    }
+                } else {
+                    /*
+                     * Shared Region
+                     */
+                    if ((env->pmp_state.pmp[i].cfg_reg &
+                        (PMP_READ | PMP_WRITE)) == PMP_WRITE) {
+                        allowed_privs = PMP_READ | ((mode == PRV_M ||
+                        (env->pmp_state.pmp[i].cfg_reg & PMP_EXEC)) ?
+                        PMP_WRITE : 0);
+                    } else {
+                        allowed_privs = env->pmp_state.pmp[i].cfg_reg &
+                        (PMP_READ | PMP_WRITE | PMP_EXEC);
+                        if (mode == PRV_M && allowed_privs) {
+                            qemu_log_mask(LOG_GUEST_ERROR,
+                                    "pmp violation - m mode access denied\n");
+                            ret = 0;
+                            break;
+                        }
+                    }
+                }
             }
-
             if ((privs & allowed_privs) == privs) {
                 ret = 1;
                 break;
@@ -284,15 +386,23 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     /* No rule matched */
     if (ret == -1) {
         if (mode == PRV_M) {
-            ret = 1; /* Privileged spec v1.10 states if no PMP entry matches an
-                      * M-Mode access, the access succeeds */
+            ret = !MSECCFG_MMWP_ISSET(env); /* PMP Enhancements */
+            if (MSECCFG_MML_ISSET(env) && (privs & PMP_EXEC)) {
+                ret = 0;
+            }
         } else {
             ret = 0; /* Other modes are not allowed to succeed if they don't
                       * match a rule, but there are rules.  We've checked for
                       * no rule earlier in this function. */
         }
     }
-
+    if (ret) {
+        trace_pmp_hart_has_privs_pass_match(
+            env->mhartid, addr, size, privs, mode);
+    } else {
+        trace_pmp_hart_has_privs_violation(
+            env->mhartid, addr, size, privs, mode);
+    }
     return ret == 1 ? true : false;
 }
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 8e19793132..7db2069204 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -36,6 +36,12 @@ typedef enum {
     PMP_AMATCH_NAPOT /* Naturally aligned power-of-two region */
 } pmp_am_t;
 
+typedef enum {
+    MSECCFG_MML  = 1 << 0,
+    MSECCFG_MMWP = 1 << 1,
+    MSECCFG_RLB  = 1 << 2
+} mseccfg_field_t;
+
 typedef struct {
     target_ulong addr_reg;
     uint8_t  cfg_reg;
@@ -58,7 +64,13 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
     target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
+void mseccfg_csr_write(CPURISCVState *env, target_ulong val);
+target_ulong mseccfg_csr_read(CPURISCVState *env);
 bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     target_ulong size, pmp_priv_t priv, target_ulong mode);
 
+#define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
+#define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
+#define MSECCFG_RLB_ISSET(env) get_field(env->mseccfg, MSECCFG_RLB)
+
 #endif
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 4b6c652ae9..4f877f90f7 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -6,3 +6,7 @@ pmpcfg_csr_read(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRI
 pmpcfg_csr_write(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRIu64 ": write reg%" PRIu32", val: 0x%" PRIx64
 pmpaddr_csr_read(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %" PRIu64 ": read addr%" PRIu32", val: 0x%" PRIx64
 pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %" PRIu64 ": write addr%" PRIu32", val: 0x%" PRIx64
+mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
+mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+pmp_hart_has_privs_pass_match(uint64_t mhartid, uint64_t addr, uint64_t size, uint64_t privs, uint64_t mode) "hart %"PRId64 "pass PMP 0 match addr:%"PRIu64" size:%"PRIu64 "privs: %"PRIu64 "mode: %"PRIu64
+pmp_hart_has_privs_violation(uint64_t mhartid, uint64_t addr, uint64_t size, uint64_t privs, uint64_t mode) "hart %"PRId64 "pass PMP 0 match addr:%"PRIu64" size:%"PRIu64 "privs: %"PRIu64 "mode: %"PRIu64
-- 
2.20.1


