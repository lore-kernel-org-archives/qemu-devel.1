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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5099C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9462053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jVlbqnQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9462053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OZu-0000Yq-0i
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kev-0007Jl-Tp; Sat, 08 Aug 2020 04:56:57 -0400
Received: from mail-oln040092253041.outbound.protection.outlook.com
 ([40.92.253.41]:39932 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kes-0007DI-Vd; Sat, 08 Aug 2020 04:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5mLCfmGX9M+51ym0rEKG5CHWGdsqjvPmcgRk7Y1rC+NlCRAM2PhAyKRPZVesCxia/x9avrwpd1Pc+KZ3I54uVywb4rvgTXm93wuYQSkK7lZmMXIxUpCr66kYmxG78ZEMCjUXXfkASEV4saYgTHbLsChyxQ55orMf0Sfpa6FSvRLrKrvUMYNNTUBUkFw7+8Rgl5ac5RxNEx6i6CMfppfZL3nlP5HAdvkbVJE2pN+duI46c371a/RH1b6A1d8cNYYwABevLh3RZAOyb7mQGRGSDs+PcflDptQeerC9KbbwZuP/6fkb4xHnuamst7RvapeFikcUwlLxpu6OdYII3xtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9BkRaRE+jhddNS04t8FzzErct+SEKU2NZRuqELMWk4=;
 b=nZTvScvBUvz6Orp7Ah/JB6bk63jutI7jsBhaRzZC3JIMSd6sbX9/3TjUoYmJ/Bhe5AagTghTmLpEz2ltFwAk/7mdQTV6NDX1eFHoCBs0bS+17moL7HUUVr45YDBBwi7PGdETV9ICqg0o1vLj7o44pM9M/dxUG53+HkrFnmKssBc+tjB9L32JudLXysFUeWmkzZjl8kYrWuoTThu2V8KWfEtl3zODfAFxO9nKv2Vcoo3ATNeDWDaX+DyPvsSKlDJmZSSuWoSQpNLDTPQJYIIrxPV8oLxWzSWoJ0Cj2XOcNEBHk9Vozt0osIyc4F2uy8UtoXY6rGC9H4H17km0gdkDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9BkRaRE+jhddNS04t8FzzErct+SEKU2NZRuqELMWk4=;
 b=jVlbqnQnpD2Bcg76lKMKwAclyeNK0bzVXyiSXdiOLsDp9kq4Uev8/QTj5U/9+WKx5YwaNnQwNf9QNh6lfHIHiDruKv9gbaCboA9ZvyAGHh2zvvv8a7g7NggHkW9YWmYcrE79b7ZMZnaoD9/Wf8YLAo28bbeukGlhqbz7VL+aXpI632+Q33kVG7m5sqDvX/3KYw2dcfI1/j6u5IWAH/+dUL6DIQTKrs/9a1EFe0vQYcQSs6ujpLPwpZYpM5XKdrHPO+Oi9mTWIPvUBjFM0B0uSazqtkFMyBT9OmO+JlJJn9Up5wYtZouKLoQ4UsTXj7RmsTlGX2w7AEetLNFXlk8/7g==
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::47) by
 SG2APC01HT031.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::265)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 08:56:47 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::50) by SG2APC01FT013.mail.protection.outlook.com
 (2a01:111:e400:7ebd::186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 08:56:47 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D5617A2D2A9E8920906BD7A638A4C3336E22CDC9AE2666017560D81ABC161BC9;
 UpperCasedChecksum:E12E7EB9BEC6EA0381056D028A68718C90F301E93B62139988C37094C91463D6;
 SizeAsReceived:7579; Count:47
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 08:56:47 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] riscv: Fix bug in setting pmpcfg CSR for RISCV64
Date: Sat,  8 Aug 2020 16:56:40 +0800
Message-ID: <SG2PR02MB263420036254AC8841F66CE393460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808085640.28636-1-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK2PR02CA0183.apcprd02.prod.outlook.com (2603:1096:201:21::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 08:56:46 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808085640.28636-1-weiying_hou@outlook.com>
X-TMN: [1pdgUXaSSg28optFSxUH20t12cSFtMUh]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: fc5d72c8-cd51-4a84-2ff4-08d83b78fb5e
X-MS-TrafficTypeDiagnostic: SG2APC01HT031:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mQfJKN3c0yZXoLn17pvwV171eUX66Io3MZNtR3yWnx9HkvIzbJpo90na3MlQnt4RbwBdQMXrY6t8jjDfFpLNrDE8vMpU+18CVibdJjyxDq4p9InpF7e37xL0ICdBPnn4pEka8VKtD7TDYsFQWfo67FwhwctdaHZOcWVRQFr9cc2YnBd1Hpuhp8RW3DkjabF7t1CVBITmrkqtfSuSiGJ0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: HHIEaEwVICXATiY9jBTuU8lEXY+grHKN3oafNdX1r8o2uwkES0E0l6+tbu31T1diAC+JZkpCxmoPUuQmRcW910RDemONKWT3gIfUbkweZydb255PpM0wTyPitJWvvPAxlsXVpp18KMcGVRQltfT3yA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5d72c8-cd51-4a84-2ff4-08d83b78fb5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 08:56:47.5212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT031
Received-SPF: pass client-ip=40.92.253.41;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 04:56:50
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

First, sizeof(target_ulong) equals to 4 on riscv32, so this change
does not change the function on riscv32. Second, sizeof(target_ulong)
equals to 8 on riscv64, and 'reg_index * 8 + i' is not a legal
pmp_index (we will explain later), which should be 'reg_index * 4 + i'.

If the parameter reg_index equals to 2 (means that we will change the
value of pmpcfg2, or the second pmpcfg on riscv64), then
pmpcfg_csr_write(env, 2, val) will map write tasks to
pmp_write_cfg(env, 2 * 8 + [0...7], val). However, no cfg csr is indexed
by value 16 or 23 on riscv64, so we consider it as a bug.

We are looking for constant (e.g., define a new constant named
RISCV_WORD_SIZE) in QEMU to help others understand code better,
but none was found. A possible good explanation of this literal is it is
the minimum word length on riscv is 4 bytes (32 bit).

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/pmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..b14feeb7da 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -320,8 +320,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
-        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
-            cfg_val);
+        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
     }
 }
 
@@ -336,7 +335,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong val = 0;
 
     for (i = 0; i < sizeof(target_ulong); i++) {
-        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
+        val = pmp_read_cfg(env, (reg_index * 4) + i);
         cfg_val |= (val << (i * 8));
     }
     trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
-- 
2.20.1


