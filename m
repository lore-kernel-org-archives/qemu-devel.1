Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA427206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G0H+X6i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA427206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwVV-0006bN-Qn
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSW-0000nF-Dq
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS3-0000S8-OF
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:51 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com
 ([40.107.237.64]:6136 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS3-0000P1-4U; Sat, 02 May 2020 14:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajf4bjZOTjZ9/BGALMCjVWGsvlvAuK2XlYiwII/WKcpi8/jGd69c1x3Sk/QIecLkLEqsOCn7afCgWpIRy/1WXJhCbZZM9COjlWsdoeRhMr3k97x2y/9C8pcKFlsLosayxORk9Kwwjq4V5ydu1ceyx7+boVPEfTlOhfXK4Ce5lHriwErxVbxY2CDfLJNUReBufueaboJj5xQ+ho6kCjoIFFzrGhwwE975H/p+pqv7bTu5QLoF46nQL8SP85s3eNIFSEvP4HHjo82/aaOx0rT7e/IFnZv923N73n23tGsJiFjiYUpCATzgcBJifewwnepngxwQxuK2AxBWmpjFw0cZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0pEcXdHCHqmCfb5mHs9p26OpxNuXwfeO+4VfheGMX8=;
 b=JOeDfdU34pm8JcD0hTdODZ26UCeC0M483M/ZAgx7m10ww860TlcZZEGfMt5j70vZMe0uITkcXO2L3SItpKUTqZWbprVEaDZokEcUHCdd2ZojUtkwltACUVL6uxDQnMBZfcpzMhNUY+0SpBjAOUDDs+S9cAM6l78lFY3Yn9MZWNLvWED+vLGp92FbmIO+ZNiNFZ7AyHDoAd1uKvuBg8vvGOnKKxFWO/9RX0bgzCFWvlyHs3E4ONZklkwJ2GRXAwqfQAdLsl8bfoOj+zpndcmGef3xxS0wXH1uTSd8TdYEVJ+873l36XE6krXIpd5sJjjKF39xWjBFpc4LTE2cxcABeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0pEcXdHCHqmCfb5mHs9p26OpxNuXwfeO+4VfheGMX8=;
 b=G0H+X6i5AgWeuNqpT30qo4Ybp5ELRCBTMYbVAPrGL++NB9k7SU4CHyPP0V0HzPco+YfJ0WArSvqcY4VT7Qdof8Rg+WEVWiJfipgaKuDph3rl+wBLhu2NZ0IIA8Zcjc4GUYAUuq6znhs11VLiXiNURhxBrtlbzVP0YffhzoFDCsk=
Received: from CY4PR22CA0090.namprd22.prod.outlook.com (2603:10b6:903:ad::28)
 by CH2PR02MB6599.namprd02.prod.outlook.com (2603:10b6:610:7b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:19 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::be) by CY4PR22CA0090.outlook.office365.com
 (2603:10b6:903:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 18:01:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:18
 +0000
Received: from [149.199.38.66] (port=60285 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRv-0004na-3t; Sat, 02 May 2020 11:01:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRy-0006wq-BU; Sat, 02 May 2020 11:01:18 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1HsO011720; 
 Sat, 2 May 2020 11:01:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRw-0006vo-Tp; Sat, 02 May 2020 11:01:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C977A13C1F1D; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 07/10] net: cadnece_gem: Update irq_read_clear field of
 designcfg_debug1 reg
Date: Sat,  2 May 2020 23:23:11 +0530
Message-Id: <1588441994-21447-8-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(346002)(39860400002)(46966005)(36756003)(478600001)(81166007)(6666004)(8676002)(2616005)(426003)(2906002)(8936002)(5660300002)(336012)(356005)(42186006)(70206006)(70586007)(110136005)(26005)(186003)(4744005)(82310400002)(47076004)(82740400003)(316002)(6266002)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f70c0bf-d39f-42c2-4567-08d7eec2d093
X-MS-TrafficTypeDiagnostic: CH2PR02MB6599:
X-Microsoft-Antispam-PRVS: <CH2PR02MB65996800278CA077846257E2CAA80@CH2PR02MB6599.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAKyGLbWCs9lY4LFlKN1CQ7SNCeGxlRGgXIE8ObTUp8lUcxuUHSEJvyz0HqvmvtJHUYKAit4Eb+Ht+tuSGjpsy7Pz1oHAupC0uWMf+iGn2rDXowo7R7OA1pa7UQ8PpwPoc1YfYJZ3Deetvj+v46p1vm27jX84MhjHJYL1WPCWOxehtmenbRi3TLlYu7dUFVuI4zijgvSqbWdTHBLwlnciNBYZyVuvHxuVpDXTxa7hQ2r5Pin098AwCqD2KWh1w5996iQl3z43JZWc79fCOagktI440/qdWPF1yN5Pviwe6LQ9A6nRO53pn+DF25wlZHge63qJqOS3OPHHnVMLVOVvMXKGpMa5Ct49Zk0Kt/oSBgCFBV2hN4z38pNgY5CM3s03t2i74z8sbAylMyBh5JlTfoL9cR8Ko+zyK8ag/NH59eBZidaivyrFYIt6zD5hXmP+PNGBKdQb/ORy3pC+s2/NuPzsko51b/SraMBXTg+zMas1NWZRNnG8Q7WdFSWIA7K2SaATdBauSM5nVOeHxmEqA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:18.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f70c0bf-d39f-42c2-4567-08d7eec2d093
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6599
Received-SPF: pass client-ip=40.107.237.64; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.237.64
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Advertise support of clear-on-read for ISR registers.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 75fdb00..e6a3d6c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1343,7 +1343,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_TXPARTIALSF] = 0x000003ff;
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
-    s->regs[GEM_DESCONF] = 0x02500111;
+    s->regs[GEM_DESCONF] = 0x02D00111;
     s->regs[GEM_DESCONF2] = 0x2ab12800;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
-- 
2.7.4


