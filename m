Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD73C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13183206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mXm5Pi/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13183206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCZb-00047l-8r
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYCYL-0002Wb-0m
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:49:21 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com
 ([40.107.236.86]:6094 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYCYI-0006dd-Iw
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:49:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ1mRepOjrg9whEg4OyPuJQ7Qo+uEJoY6p+ytADV5DbNgcu2cBBeUvuLcQ7468OEX6uuslHAejMg74PusTmOjn9oOZgjqErVoAUtYjh8O5ir3g2SfPeDr2uE08OmYTsbmbe98kWVqCPxTBKOGqXjhKhgMwDXYtyzBatG1pJPwl2Jwl94pEmDVdF0kvgLO5ukY0qDMMBDOBOpcFPM+fSiPEUcVGpS5NMPyj0cmIq11Q38fZ/rleVO9mGZY73F0A0Vd32AgBZzaSUnlZD5dfzVf0HBQcmbJ43/0HiRnvjoHVpSfuLc/KrSmgCpqiI11jQvA7HhavCXr8bWFAQrLF2aPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHpfXJS3oqVSbbLugsZfy6ZMIxNdqT29UI1nvG+3KS4=;
 b=OWuwI4mdO0usM+B4UcXftuV8HMU066mVOnypyytp4wkNiJZ/AvYaB1AphkkRelWKVFtpt6LIV2/THOZyKyH/qg6qWWSaUT1ccK03Vqe9hbQOqcTyvYkY5U4xuhMWPpuvyc3YxnSDYt/XIM6FeoImMbqmBImPsLxjL7p+ztkDlU8VP7+N8XA5HNOJZ2lovMQgjReAnE7NMj8jB0zO9uH2C2/FthNI5GfKwknncyQh/R1pFuL3e9h97U1mfWnZfP5jitz2rVh9u2i3bPyTuhm8BgGVpfyylxZUJwIzxjv4zjezmutgJCzGOrzf7iZeH9o4E+6cUJMyzRmLd/AeHoxwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHpfXJS3oqVSbbLugsZfy6ZMIxNdqT29UI1nvG+3KS4=;
 b=mXm5Pi/9flXuJBIsrd711HWBW1zjUuwopT7Vt//pe8ALYz5BDBf6Kh9yzIZBKQ+VTl8EUQirRk+H79SSIUST9qptE0jpRut8msfbK9Q2lTNvWWGnaZT0vYzFgaf7Mppw9DVAIgelJz4QVcaktOumKp4pVQ5b0tURRy9Mg1Jsoyg=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by CH2PR02MB6246.namprd02.prod.outlook.com (2603:10b6:610:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Mon, 11 May
 2020 17:49:15 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::7e) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Mon, 11 May 2020 17:49:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:49:15
 +0000
Received: from [149.199.38.66] (port=47080 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYCXz-0008Qo-Gd
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:48:59 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYCYE-0000KC-Me
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:49:14 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BHn6kt008555; 
 Mon, 11 May 2020 10:49:06 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYCY6-0000GQ-8H; Mon, 11 May 2020 10:49:06 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] target/microblaze: Fix FPU2 instruction check
Date: Mon, 11 May 2020 10:49:05 -0700
Message-Id: <1589219346-106769-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(136003)(346002)(376002)(46966005)(33430700001)(2616005)(81166007)(5660300002)(8676002)(316002)(2906002)(426003)(478600001)(6916009)(558084003)(82740400003)(7696005)(107886003)(82310400002)(47076004)(336012)(8936002)(9786002)(186003)(36756003)(356005)(33440700001)(70586007)(86362001)(44832011)(70206006)(4326008)(26005)(42866002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a75545b-154f-4509-33ab-08d7f5d39efb
X-MS-TrafficTypeDiagnostic: CH2PR02MB6246:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6246E46F0D8AE927609F4701D0A10@CH2PR02MB6246.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT+6ktaP96DqoVtO5WXhtvolycpoUeMYghqSjcyflYR8Fp4KX5FV1nw0FBBmWGyf4OSHGXIwbpLiPkKOyEdzsdhd9dfRCO3VxtGVjwi7cn+uwIlgRZIR3pFHacCO9hF2i9wW6NlEdNdmVJeIkagIRPPx7ZNnetFUBaf42G59p11+yQdO1VrVawx7K4HKHHJwChKpVQSprzLhh6w/+pRFFbi4JGTAyZMXDPkdYO0GsPkFfFAV6CiseFbyBzw1qDLobYUxFylXeciQbFkohNdkp7UCZW07r2JVNlvyAsp+qCXsY/juhNt/lpAiF0RrkcxEdLrvcG6DzOIOOxp8/LfPbqsD82vDR9R62qUOI3OJLhIM4W7RYqPp/6HaOmffOSnyglqiYsCFGR7ciLwW8PjUfBML9HeileGfs4ilrnPenp9pJBkR/QDmWh8tYcG2aueycX9nfp38a25/9GNBvIrAzGhHQTQUdqc9IANbm9u7Puqtmi8SnSHaBQ3CStvzWVSmBS6rkmNcN0/wCKh4JmnYRHxVfSh6VFOq1LiI6UBivdnrdu92T2WP4guD4PUavH9gLMMWU854SiIowwV4oeds7skQgKDH50CqDUDwnXJ9qpY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:49:15.0352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75545b-154f-4509-33ab-08d7f5d39efb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6246
Received-SPF: pass client-ip=40.107.236.86; envelope-from=komlodi@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:49:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This fixes a backwards if statement that caused Microblaze FPU2 instructions
to not be executed, even if use-fpu=2 in the DTS.

Thanks!
Joe

Joe Komlodi (1):
  target/microblaze: Fix FPU2 instruction check

 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4


