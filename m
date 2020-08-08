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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9716C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58362053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NQN05PYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58362053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OYW-000627-V4
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HM8-0001Ck-Ha; Sat, 08 Aug 2020 01:25:20 -0400
Received: from mail-oln040092253036.outbound.protection.outlook.com
 ([40.92.253.36]:12256 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HM6-0003ff-Ag; Sat, 08 Aug 2020 01:25:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjSTCA2MJ2IXNCAmGk9Tqp7RnDk5ExVpZqFKnKBdLz3ULayUBIt309y4fio4XHGHSwc8E5ybL64dcUnQFzqm5cwtrki/+90pjs5d3cNKrGbslMa+rBvZZRa4mmiHpPUZffZeeK+FqnYfKEVm1jygnG3xT8bDv3nAxk2HutCXMJa00H4TRTWaDTofslclUp5x9734YsNhTnOcK57bvBgOAJy/o60OO1VKT5bbYDLpxIhMDei/IlUHLbs6cvYbilHszNyp8laJ6YIwC1s+mqDsLAfVT3Ppkz7A86oVz7lFK5irNVG6lvi1Y0vo4LabwjmspEBpJd5L5HJP7YWPEUcy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9BkRaRE+jhddNS04t8FzzErct+SEKU2NZRuqELMWk4=;
 b=ToJBermTh6fNvZmV1D9uPk2hElLiWh09moRUp7F6+GS+1QOOcvYzkzphpgKHCcYS3gCdnu16a/SuJe+jCvRFav72WEDI8fl1Taeh0DhdUBH/+P33CZUdSN38eV6dbiJnb084sjtkODLZAmoVxRqg23zOQOOUvTsjChR2YZWRzlli4U3GExzw+Zykwb0w5fi7P+sUct9EHHCCB8dd5D0Ckvh76hGYVgw37lcKCqiMtgS/kTQaKh8a/sZaypeC5/AwpoexnHO/Yqj5Ia80B54P8C6mlNKfPEdauKN+feG5zF6ygzsGCV+fDFylsMJ7SuqWsK5MkRY47hH6Is70MyScYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9BkRaRE+jhddNS04t8FzzErct+SEKU2NZRuqELMWk4=;
 b=NQN05PYp7DkwrYYUQnr7EymC3giUVt5EqXOQkVZkjQP368/+u/uK8nbbvOe2HuqoG67yF/i3qflMyw5E3GVbhhDGsV9r4chVQf7Nrl0N+JBCn69IWPoqyC3oXopHx184+SRpnTn2I3Q3yq9Gk9zeYSfi1rn6uN2CnkqFI/p1feE3b03WnXPQcyp+nai2INhreGWDPm/3FqJ6KUK+skBaUyLZHnlkkqEBLaryMfWzsJJH0VpuILM/Ilb+8EtSGuYm4F/8i2WPwS+fcSPW2dbZPp3pEH12r79jcnp8GUKRO5/DnCRgVMErKYvrnSXphBf8s40sRD/lMtzWtbTp5XJulA==
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::49) by
 HK2APC01HT077.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::378)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 05:25:12 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebc::53) by HK2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebc::195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 05:25:12 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:570AD553B583F8B9DCFA71548619F954C3AC45386E6F4A3D1D48742136C4F583;
 UpperCasedChecksum:6A2F65A7EC42AD4770B3983A59485326CF419FAF461BDE4404240E2F92637349;
 SizeAsReceived:7583; Count:47
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 05:25:12 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] riscv: Fix bug in setting pmpcfg CSR for RISCV64
Date: Sat,  8 Aug 2020 13:25:07 +0800
Message-ID: <SG2PR02MB26341FE46F5C60B6FC71BC1893460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808052507.19843-1-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.141.129) by
 HK2PR02CA0188.apcprd02.prod.outlook.com (2603:1096:201:21::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 05:25:10 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808052507.19843-1-weiying_hou@outlook.com>
X-TMN: [jGz1m9HtURVRXpk5KdV+9WIo5HIJNzHq]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 50ae0581-8156-4edc-a690-08d83b5b6c3e
X-MS-TrafficTypeDiagnostic: HK2APC01HT077:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WGE1Ji42gg/ZewqGghEZBlY4JGnALWokBftkiCAOKjrfVikGBTKPkFC5LNbqt0E4UwfkTz7yuD0LdUnu+9wIjbSRkdEIRAuitK66b7xEHL5Yl96H+NANKOPvc5DT34vZ5yczolMn6hrcqppxtcZAFkIGIpnamFTNZ3ln+R4xHipYFF2ajGyJdzkvo+s8NfgbuV+e4CGh8R7Mjzl2khyJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: VMGJobkNJtFn8/rWpMBt6epo05LoCqXS7H1luePvs3jyXUFNE2jEQEleFwJN8Nb4CIl5UAVX/TaFhpV7dw5cdHpNmtHKfDBoPp4WuDL0Rd2lbntBYfB9//pwKjX6oYe37VwBw4qMmaRc8/ig4N77Vg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae0581-8156-4edc-a690-08d83b5b6c3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 05:25:11.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT029.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT077
Received-SPF: pass client-ip=40.92.253.36;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 01:25:15
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


