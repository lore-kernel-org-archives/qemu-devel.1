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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A862053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cLR2UTFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A862053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OYI-0005Sw-Tp
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf7-0007Kq-Lx; Sat, 08 Aug 2020 04:57:09 -0400
Received: from mail-oln040092254107.outbound.protection.outlook.com
 ([40.92.254.107]:24426 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf6-0007EX-2O; Sat, 08 Aug 2020 04:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL/gN4hCxCD4EYBHlSrDypwzyoTTlS/YrUoeh70rGGwqV6Rg3MG/caqwjptgMGRUaQ3f8yOP5ZXilUizfq1w5jjIEEk/fRQkmO9lQEJ2MI4cOahRMWfCb/kGuH2rHhJPRBdthbyAyNX5josmdxxiwSZgEghHM4UqJM/R56WEsgOssqYiJt/InLjyZzvIUugyoxT6qCHJy9e3BHYl6gg/cOmlfOUGSTRgzMXAUfoF8wGGsASTbmyM7d3ei3jCOQeuI0NSRyVfaeNUFwUCPd9gAcbwqFWcxIsbAWhMHbq9qJtpGiUVgoOMQqdBmIzORZ2CXwimVo8A1bJu/6ytCJf47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJQp5LnvRu+Lsc3qDb6WkZP4+QwKlHSumw/vknLoROs=;
 b=SOLVWPTpjEAwJ2Qo3gduhIxsaiSW+A4b5DG/uvgOgZD7PZMFmfYjsCDqgLK6tuWfH1fPUxUelSFVd1A2B/YWtIfT70CXm1TydDOVOtQ19hiGlOJXXeFBSVnlKo5H4dRbHcuR6oxDBHG/X0fM3YbD4e/QnRxpTzMJyXO+8Y4hqt2tJ8aKmkzrC5C1rE6XIst6VrkAQfLqNXO1gzN+K8AeZau+2F0FfrjRk9id85+imDco9vonFWXuulnCJrPMHSCIqXDZKLmFUcFt/noUhpxxzHOVIquF2HxWYUcSEMqtKKwHZy9tu4gMO7zaqaYCvqcpOtZ1Lf4ULQ3LMvzj8PwuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJQp5LnvRu+Lsc3qDb6WkZP4+QwKlHSumw/vknLoROs=;
 b=cLR2UTFlDvMmHkux8ONTNCNTi8EF2ff+YQsDrXzJDEubhpzpJIZKDHgBT12d/caTLHMzhhJqBN+bq5Fwy7aDI8pDQZtXgMeRncGcnh79Uhxc7kPALCn8KKI28q3DayeR/J1mJRey4fBeGuGVn9UpEJAAEhUeJm6ZrMJCrUf9J1dESi9CVfZ+fcgEQDCbYyw3l7OQobLkWp5Nbwd5YLOBQDoxhW1KTaE1eaYJbnAtI3SxqvvhuoQYM2CwNU5VnwIRW6Bwm/unkLvpDyVCb/X0rhpFQfXPodsUwrdcGM9kVQ43LJhwMO1lOBXnFX59EJDk8BHVflzOym/vwPkXENF5lw==
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::4e) by
 SG2APC01HT185.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::490)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 08:57:01 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::50) by SG2APC01FT013.mail.protection.outlook.com
 (2a01:111:e400:7ebd::186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 08:57:01 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:835953886FF168CC6568EB48102B22A518D0BCD904788524F2572CC3DFB406B5;
 UpperCasedChecksum:4DA4250BA31A39961CA0B5F22FDD621175A9D3B7DC6D7DD512E4912CD2401C6B;
 SizeAsReceived:7680; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 08:57:01 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] Define ePMP mseccfg
Date: Sat,  8 Aug 2020 16:56:53 +0800
Message-ID: <SG2PR02MB2634F136E13C28B7640BB0EE93460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808085656.28692-1-weiying_hou@outlook.com>
References: <20200808085656.28692-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808085656.28692-2-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 08:57:00 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808085656.28692-2-weiying_hou@outlook.com>
X-TMN: [8kW9kcGlDXGmF7BULfAome0wr/TZ6MJD]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 81e24c93-1979-448b-c975-08d83b7903c0
X-MS-TrafficTypeDiagnostic: SG2APC01HT185:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5YadmqkQAQKlMgvz/qFF9qbMO//3jtE6kQxpQr0azgh4w/7rCqjZqTsE354sgbG5CznfUeMVkO801RMLMGjdVuLdLnKLqARe0MBksCzmYHLzKmnoWswTARd1Rx/luIJ+NLiLnNcBIfqpLAlSZNNk6uYrXjMEFIpeK+gLJeNvwg4apAV1qKlzzw5Fn9Z74ItlyH8ctodGaZcDd+YpvA8tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: jHnZhV9QeN60VcqYi/MZ8pLPhonD7INw27D4v7Rs4gSqVM4aEQLNe5J2qz2xsDu8mQrzyIvXVR4/obYobBDSygUtlChjGA//TGAI6/jtS3wUpz1IeBphI/tJBAi8+1hD4fZlRQAbRpHQlxdgNP367g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e24c93-1979-448b-c975-08d83b7903c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 08:57:01.5922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT185
Received-SPF: pass client-ip=40.92.254.107;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-PU1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 04:57:05
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

Currently using 0x390 and 0x391 for x-epmp (experimental). This may change in the future spec.

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/cpu_bits.h | 3 +++
 target/riscv/gdbstub.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7f64ee1174..9a8a6be534 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -214,6 +214,9 @@
 #define CSR_MTINST          0x34a
 #define CSR_MTVAL2          0x34b
 
+/* Enhanced PMP */
+#define CSR_MSECCFG         0x390
+#define CSR_MSECCFGH        0x391
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index eba12a86f2..de5551604a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -132,6 +132,8 @@ static int csr_register_map[] = {
     CSR_MIP,
     CSR_MTINST,
     CSR_MTVAL2,
+    CSR_MSECCFG,
+    CSR_MSECCFGH,
     CSR_PMPCFG0,
     CSR_PMPCFG1,
     CSR_PMPCFG2,
-- 
2.20.1


