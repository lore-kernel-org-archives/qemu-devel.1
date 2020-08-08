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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8822053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ksjDl/Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8822053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OTH-0003bq-1L
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf9-0007Ld-Pg; Sat, 08 Aug 2020 04:57:11 -0400
Received: from mail-oln040092254059.outbound.protection.outlook.com
 ([40.92.254.59]:23424 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf7-0007Ef-C4; Sat, 08 Aug 2020 04:57:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG9ClTzgwg9bM09Mdr1I4N19GJ7C3icvbS8sd7XuFFjc3kyVZgyLg5RHTQztChcz2uxQQeyaBQnop/0kwClKFyWK3/qblA9wLR0pKK3Q8rJEkwgnSgTCZkvS/N27PyqvmkSKAqeRT7//TNKIMy9i5YnZ2M5Dnz1OvCl5qJxILdfJNZoaVfX1gpmas/4CtnNbxKsJObENLF2rRseb9+RG891ZvmiH473+DnyCbNW1WWISHhnStZWzMtAkVp68Hiv6e2HmbIlyu7NLowqEzD7HkV2haOtOLieqDzYOj3qZ1u5qbqYNNq/YL7dk6leQpVdGsH64CFqfgkWIier+A0jYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WKS20sgAIub+ADs2QizCC26J4BbnDH98WrRZWpLpqc=;
 b=E6T9E0Z+GZW1ozKEtVh1tEkNTY8c/ZIXyRiXq4ffC/5JdYa4476bcy9fdWzWuTyIwirC3Wq2YKZhAoB8gcKggB1w4mTCaEMqiYyIvXHK/WnFXPZuBHwWBUIlSyOb7BAyRJq5toPsiDKF3EOyFURNGaQV0FQOD53DpJXEi77L1go8gzMS7XUhxlLgF8u67CoaSP1ddOkgpwZZN14J9XVNcNIEAQS+FD21Rn0xYrArkKSFrbFwaUZ2gTOMmEbtrqF+2UfPJCKK55WEAfuShPKE0+p/K063ivCxu+cvlJg2bzxpUh97+337ZKBPTcDOuDHeJP6/kdCuLRrZ9GlbNOhASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WKS20sgAIub+ADs2QizCC26J4BbnDH98WrRZWpLpqc=;
 b=ksjDl/DzL1nrCHiGOG5Tjh2gM+6Flr/XRNoHIFuHCChZg7cF2EGaojinfPLT5JC3IxcGN4LAUZmFhenioLGJu1ipVYMmLf1o8H7F4sHnW3gY+Oj+sx71D8gr8kxF8Dvf6kmz2TYtnvZfjYh27gmrsxjKTxDOThhdGojs1WE38fmYzm5tQpHGyUg4YFl9tiCmkEAy3cw1S7I0gAEDIKICLZ4ZU5SZt+gvdwD79TR5G5l77zRgYJrxGz7dQgyD0G6x67Pto//GPnDbcgz/Wa0YNosT/IoSfGv9DHmYnRy11eqHbb6NYa94KXSxNhuk0cbHLTPboo4JIXREkYqH2+iGag==
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::4e) by
 SG2APC01HT112.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::482)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 08:57:03 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::50) by SG2APC01FT013.mail.protection.outlook.com
 (2a01:111:e400:7ebd::186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 08:57:03 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:243E6BB9C7FE0549273AC91AD2CE8335A6C9A63CDF6AAE8862719ACBE314CD18;
 UpperCasedChecksum:2A03CA610377C441756DFBE12EE263BF20223467828BD91D1F4087A77940F9A9;
 SizeAsReceived:7706; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 08:57:03 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] Implementation of enhanced PMP(ePMP) support
Date: Sat,  8 Aug 2020 16:56:54 +0800
Message-ID: <SG2PR02MB2634E856FCAC7A6DCAE5ACBC93460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808085656.28692-1-weiying_hou@outlook.com>
References: <20200808085656.28692-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808085656.28692-3-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 08:57:01 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808085656.28692-3-weiying_hou@outlook.com>
X-TMN: [ue/a59dyS4TiXuvaoi6DtNS/Ttx69Txs]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: fe16cff1-e424-46f7-cea5-08d83b7904b9
X-MS-TrafficTypeDiagnostic: SG2APC01HT112:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gnRDYgOERxQ3VEuQOxgmYWMUgqoWxxCD2VZnEvmNVe5VNbamB80mef9ZJm6Dl5PzlBiBjU+sso2Z7QsQh2oFlONhRZ7IJMV3MhxDOt1MgD6ARkogMA6JpubCSSLSnX1RfTDPNDnNNhnlZs02KYU+/mHbpMXWWL5jeKG4OCdLrVD4VXOPblcIHB5P8zsQfc2yHKaLnTIU6Bz3B9ifsNeb608V9qngw0YB8ayHCsATGZjSYiOyu7KgUypHoR7dOqH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: YJ7NiahmEOqANkQUFZU3HHIf7zgcUJb6hS/7CTOuGwFXkzk3wcvi0eBh//3hfWIP1t5cgENh3p1scqD5Ixu57YCvrqjmRqy2G4yvcNHTZf9GqchbH2Im7h9bj9JLo6iB84zf+npvmREAG2MUVqQ9JQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe16cff1-e424-46f7-cea5-08d83b7904b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 08:57:03.7123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT112
Received-SPF: pass client-ip=40.92.254.59;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-PU1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 04:57:06
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


