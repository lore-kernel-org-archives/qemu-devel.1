Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E756C4742C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EAC206FB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eIyC63D5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EAC206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaqgk-0003fA-Ov
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 20:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqct-0000WT-A9; Thu, 05 Nov 2020 20:33:15 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com
 ([40.107.236.55]:32481 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqcp-0001YJ-Hr; Thu, 05 Nov 2020 20:33:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePmmwvDxnLcvU++boafs78eZY+c+7X+/BfCWhKVH9lF2EfRjSk/MrCbkgEtv4sb8u2yq3Plw31UAuneqT5MCWaWqy8tIe+6qnfJ5S5/bdbSGbRw1WRcDtLYFSr+kMJQkrw6aFWscPcC4lsj/6ScPhjOurNjBZMflxvjvcIFbn7Mmd9e99y00auR2xrO516Q4xxDuuC+2uCASFGtaBveGyrgi+QyZkRqTI/KyKZ9Hhyik0k+3eSwQzo40dR2WXz3oDVaxifSQuMF68SY/lGqdhmTRo/wUwS2DOaDE2PBgnblr8Q13Opc3yPHxgX0jEvGJjuogMZuEjOIHWeYOWhfpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2rlnlWPGfzY+D0mtcMg7r2XoumI1JokIQ1OnF+Nubk=;
 b=Fw3B3bAqtaxV9cnIZSBlD34XYbnZFlhrzzFA0Zngi8uzlm9SddbYN6fNZmBNcKqayx2JA9cMbuo13JIGigA3tNeiUL1RVifJiRCUDzEqY8hZPF2mp/ab5SqHKRo1ilGNIbN865KL1KNOGDGRyDppKA2bLVqRxoNGiYNlcbsC3crrF7pjNEG6iJOc9PXTsUbv2U+v820ZTO9RAVidO/n53ahoKC19kQFBpTxAfYCTlafo78q1qn7IOx+9pakpuz6K/syn1bKIxfjvP2JzIUEuxlVL6Xz7T+B5muWEbSNEe+yMeLJ8+/RYwp2lIUh2k/aOuoZFLLKAIE41D6FTKhUK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2rlnlWPGfzY+D0mtcMg7r2XoumI1JokIQ1OnF+Nubk=;
 b=eIyC63D5Woiq7ErUtNauDjSbb+yPzvvEUz+EIlb1uSoKDEflF/9+ObfwlIbeeJFHrZlA50ZT10ATQ/Gps6Pkf1VLr1pvsqSZNadvRJYCja+y/vMOASH72DqJ3dVcI3/q4LM8iz7jaznxfEt/QDR1ZFFgN6C3AEKBHAtd403zGUU=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by CH2PR02MB6968.namprd02.prod.outlook.com (2603:10b6:610:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Fri, 6 Nov
 2020 01:33:06 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::61) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 01:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Fri, 6 Nov 2020 01:33:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:32:58 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 5 Nov 2020 17:32:58 -0800
Received: from [172.19.2.32] (port=50874 helo=xsjkomlodi50.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kaqcc-0005r0-7N; Thu, 05 Nov 2020 17:32:58 -0800
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 1/3] hw/block/m25p80: Fix Numonyx NVCFG DIO and QIO bit
 polarity
Date: Thu, 5 Nov 2020 17:32:56 -0800
Message-ID: <1604626378-152352-2-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
References: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320c3b9c-22df-45e6-faa9-08d881f3e8ea
X-MS-TrafficTypeDiagnostic: CH2PR02MB6968:
X-Microsoft-Antispam-PRVS: <CH2PR02MB69683DB1CC5FD454DCA2FA76D0ED0@CH2PR02MB6968.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFTkggPSEBxzexjNuRMd3i+BxH9ESqaiQKCL6a9crCklK2UotOg6wuJpHapxaVmfzNSwWWLay+qBRlin/ytR0O6M6e0Rbr70QmRdz6cnxcQfx5p8kjMtdEeYg/AKXyKK0JE5jD3sfMTnA+3M9K+DxuzFxTOwbzUbaTBaAwEtCemwPv0lC4tu9/O/GeYU+9SfPiyJqSNxVgEryi0C1OMP+h/hfekw+9cUZ5Oo/N+sSZ++MSvPY9H6+EdbB+kn6vgn0d6y9z0z+Y5DBPo8MJKvMjTTGJuctpUavh827eLDhe14mMa4GtjNWC3x7LZ0TF4yaOo8uwlREsq7aCsZzIJtlakM0KOTEva4uk0cY0HJBIr0rhJWkC1O1h75LKrz2wLrY+PQcJfHsBJFJ5/6yMRrwi79JnHjC7aZ7Lfm98jR6aQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966005)(2616005)(5660300002)(26005)(478600001)(186003)(54906003)(336012)(70586007)(36906005)(7696005)(47076004)(426003)(4326008)(70206006)(44832011)(4744005)(83380400001)(8676002)(36756003)(82740400003)(356005)(82310400003)(2906002)(8936002)(316002)(7636003)(6916009)(9786002)(86362001)(102446001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 01:33:05.7041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320c3b9c-22df-45e6-faa9-08d881f3e8ea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6968
Received-SPF: pass client-ip=40.107.236.55; envelope-from=komlodi@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 20:33:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com, alistair@alistair23.me,
 philippe.mathieu.daude@gmail.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QIO and DIO modes should be enabled when the bits in NVCFG are set to 0.
This matches the behavior of the other bits in the NVCFG register.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 hw/block/m25p80.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 483925f..4255a6a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -783,10 +783,10 @@ static void reset_memory(Flash *s)
         s->enh_volatile_cfg |= EVCFG_OUT_DRIVER_STRENGTH_DEF;
         s->enh_volatile_cfg |= EVCFG_VPP_ACCELERATOR;
         s->enh_volatile_cfg |= EVCFG_RESET_HOLD_ENABLED;
-        if (s->nonvolatile_cfg & NVCFG_DUAL_IO_MASK) {
+        if (!(s->nonvolatile_cfg & NVCFG_DUAL_IO_MASK)) {
             s->enh_volatile_cfg |= EVCFG_DUAL_IO_ENABLED;
         }
-        if (s->nonvolatile_cfg & NVCFG_QUAD_IO_MASK) {
+        if (!(s->nonvolatile_cfg & NVCFG_QUAD_IO_MASK)) {
             s->enh_volatile_cfg |= EVCFG_QUAD_IO_ENABLED;
         }
         if (!(s->nonvolatile_cfg & NVCFG_4BYTE_ADDR_MASK)) {
-- 
2.7.4


