Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67DDC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D20320754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oM4F8hoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D20320754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ3h-0008KC-Uv
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kNPzK-0004Hk-PD; Tue, 29 Sep 2020 20:28:55 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com
 ([40.107.92.65]:58849 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kNPzI-0007nV-2X; Tue, 29 Sep 2020 20:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nftEVYKi0nl7HGfLfFpM65svbsTcBGOaqWQUluVt5lRE2rgD9RcXNq+6k+CvXT22Ll+CO8+jTwYN9EvsrBSggtNUcMd9VXcQx+TRjxASKcj+aIcwK+hbGkZ9UJNJjvipXLfb3OWiNMmoNSVPZE7lRnt1KQ/IwHxsQArkoKZsbMCrvfAcOHAcsDDGgn43su+XofHWS9PCCjNePG7aDNbZBggrbuZBKSPmw1UcRWiDgHJl7zB3jJPYOl8mbeyBXZjSiquPwNyuvrlU6eScKEzzFCod8PqyKrgbv2jYsmRMO+FACJ1oW9kEGHvF/JhcvF4ytA16/1xbY3NUv7hPPmH2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H61A/oGg4zdNXB4k2yjG1CH5TXnZZPxH3HEFsJp1j9Y=;
 b=ELzNNBiv5Hh6Z6sp+nAq9TP4hueJz5itJqsp/EFpK8HcpTGXyNIk95VfntbLQn0ZFF5uQ1n4lSZW6XN5pt4zUMV0PPWBbBSABmHUJpHm/+5QCP8JS1E6va8Oual+iEuViF06bpZtTvHKkhvflCc9vs/eka8zRQP3af8/I+KCjhmgpWjSwQMDL/fBrTdUXbj12HASetqMAopIRol3sDLNJr1eSLmQyGxko0cJ4B0GQcqCTIO6qubw35f/7sxeYaTxgEmr5WR/kVgD0lLuEWRj9H05rcju5S16+fotcONoK7nfnfdVSP4/kN0/lTdfuPYk+D2KzKAvIwsB8FcnsJoc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H61A/oGg4zdNXB4k2yjG1CH5TXnZZPxH3HEFsJp1j9Y=;
 b=oM4F8hoNDvF5t6qfMAm8BeO0DocdqBBxJY8bx6F47tb369V6hBDW0DozCdd0VXrxvY3zc9ADt00SKHvXO7ta7TFnWvY9QfcVjiPNW6AtAcZ1baq9pq4w6xHzdHg82ePm5Ds1AnfZiheUpsJG1tMaitJ+7y4PLy7PF/+Xdg8H8TI=
Received: from SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) by MN2PR02MB5967.namprd02.prod.outlook.com
 (2603:10b6:208:11a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Wed, 30 Sep
 2020 00:28:41 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::fa) by SN4PR0501CA0023.outlook.office365.com
 (2603:10b6:803:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.16 via Frontend
 Transport; Wed, 30 Sep 2020 00:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Wed, 30 Sep 2020 00:28:41
 +0000
Received: from [149.199.38.66] (port=59140 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kNPyg-00073o-DH; Tue, 29 Sep 2020 17:28:14 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kNPz5-0007Kh-FX; Tue, 29 Sep 2020 17:28:39 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08U0SaHK005668; 
 Tue, 29 Sep 2020 17:28:37 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1kNPz2-0007Ja-OI; Tue, 29 Sep 2020 17:28:36 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/block/m25p80: Fix nonvolatile-cfg property default
 value
Date: Tue, 29 Sep 2020 17:28:36 -0700
Message-Id: <1601425716-204629-3-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
References: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bea96594-f715-42ee-6189-08d864d7c816
X-MS-TrafficTypeDiagnostic: MN2PR02MB5967:
X-Microsoft-Antispam-PRVS: <MN2PR02MB59671F5CA04CAA7C2CB76FEBD0330@MN2PR02MB5967.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXPkJ53kekNW3WaAZcj4fZd1xCl7N3R2Bj1KuWdhaaZwAhueLjF7jTM/mFGmKjpkU8ZMpjWi8Sd+amBOfwcth8HzHfT7JcEu5/ia1xBkz6M/PFDIU3V37PG0Swdx2NKWES7iE28d5YOP0en78xaRYx3qDfO8kQgl5lZiYfo6F350L7luAFAW5A48wsmt6+zkMGiIpwNcKrl8o9K57XVXNbWnFW/inPPv8VcIR1kzacBiAwxPpOfA6oOhOZ0zn25uLI+uTLgPFr48FvgzDMAHHnuFg8wB1Zxre04NRBTp8RHCeSDxEFpSpmDxkg9jBBmNi98zsIcrwDX6sz7wZYOXRoF08igyNmVSFX1ZGeJcUyWNNHcD0sdQwoqVjh0Qj+kHOr4iEykXo8FsPIm9KwgJcOpKia2kOcgwxF3ggBGxvK93MogLuOPhNTYJ6Dx6jzs7
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39850400004)(376002)(136003)(346002)(396003)(46966005)(336012)(2616005)(2906002)(86362001)(316002)(4326008)(7696005)(36756003)(5660300002)(44832011)(4744005)(70206006)(70586007)(6916009)(82740400003)(47076004)(186003)(478600001)(8936002)(83380400001)(81166007)(82310400003)(356005)(26005)(8676002)(9786002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 00:28:41.0501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea96594-f715-42ee-6189-08d864d7c816
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5967
Received-SPF: pass client-ip=40.107.92.65; envelope-from=komlodi@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:28:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614,
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
Cc: kwolf@redhat.com, francisco.iglesias@xilinx.com, alistair@alistair23.me,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nvcfg registers are all 1s, unless previously modified.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 hw/block/m25p80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 43830c9..69c88d4 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1334,7 +1334,7 @@ static int m25p80_pre_save(void *opaque)
 
 static Property m25p80_properties[] = {
     /* This is default value for Micron flash */
-    DEFINE_PROP_UINT32("nonvolatile-cfg", Flash, nonvolatile_cfg, 0x8FFF),
+    DEFINE_PROP_UINT32("nonvolatile-cfg", Flash, nonvolatile_cfg, 0xFFFF),
     DEFINE_PROP_UINT8("spansion-cr1nv", Flash, spansion_cr1nv, 0x0),
     DEFINE_PROP_UINT8("spansion-cr2nv", Flash, spansion_cr2nv, 0x8),
     DEFINE_PROP_UINT8("spansion-cr3nv", Flash, spansion_cr3nv, 0x2),
-- 
2.7.4


