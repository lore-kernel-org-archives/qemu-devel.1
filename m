Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42994C47256
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13264206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XpBlyara"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13264206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwYe-0004QE-75
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSX-0000nb-MT
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS4-0000UX-NL
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:53 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com
 ([40.107.220.56]:6102 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS4-0000Pr-A2; Sat, 02 May 2020 14:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTC7hA+zzQ3pKgGmUiWqzNnwgMX0I3B8WWYYgUfPFxWe70BGL6deeeaU1fLCxWXaeUWnAQ8ph8McnvICzmUm3MPzKYZskUjE7bkj5a0OokyhvU9a5RXjU8t6WcVBN29Z4vulmxb6h/AUTLZs8emCXZACcVP2hjS/0y6OdDdkClxBFaoH8djf8mpkY5nUxqwJ50q/Lgd6jSttdhQEITITc7upV+Vs0t4Xwj7AzBPqKfVZ+rbEdxR+NmUNaNcbSRMMnrMCAkZC/3CqCk2+n9MMVnIxLwFHG9iiqOPN/CUDpxtVU27w69oa7x2Msa1HFroY/s7ZUpiTMQZH0VLcZFFWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chtkZFEMaHarleOSO5dX4gyZTFuVxLl7HhtQUnmjOso=;
 b=NgJ8LfApstFuSnENtlSGeMwAMSje7Ridyf2OMua56NjVq0+y3oZGG9ThUovLqkGKysiJdjaAi2+oMFcdoZNGzxUer0PrVlHVEStITMrOjccpDGbNC80rvlUetnC5XvKW9naz/R3TV0n9cNAnr7LRRkEMt29VqEjYLEM1/dkruJAfvk8X+5P+6ddwWzcOVaut3p1k5d7dh6Qsp9RFUipV5II1EYrbSlrk8xr80r08K0v977Bn588IlnY8fsLm3aSreBqmbI5bB63OJkDB26vznDjJlqtSOkDsWHXDICODiJuST4XlwTeiU9nZ0KGQNy+WuEZKR/doErPD1cFRFizRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chtkZFEMaHarleOSO5dX4gyZTFuVxLl7HhtQUnmjOso=;
 b=XpBlyara82duN+/ia38OLDHT8QgPWx8OBd+0PB2IevyLhJEplu5e9TXz2ym0JFg7p3lYgn1r8mx9HDi25Ln7AiHiH+JB/1BIBleimJ+B87vUICd8YHsveNX/tskebIK7iJR6/OZNg7T21VgVtyLTAkSAZNzdE+DHp5BDHGmR3Y4=
Received: from SN1PR12CA0045.namprd12.prod.outlook.com (2603:10b6:802:20::16)
 by BN7PR02MB3954.namprd02.prod.outlook.com (2603:10b6:406:f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:18 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::9e) by SN1PR12CA0045.outlook.office365.com
 (2603:10b6:802:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 18:01:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:17
 +0000
Received: from [149.199.38.66] (port=60232 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRt-0004nM-Tr; Sat, 02 May 2020 11:01:13 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRx-0006w9-59; Sat, 02 May 2020 11:01:17 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1GTJ011692; 
 Sat, 2 May 2020 11:01:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRv-0006us-RP; Sat, 02 May 2020 11:01:16 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 9AF7413C1AFC; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 00/10] Cadence GEM Fixes
Date: Sat,  2 May 2020 23:23:04 +0530
Message-Id: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(396003)(376002)(136003)(46966005)(336012)(8676002)(4744005)(4326008)(6266002)(8936002)(6666004)(82740400003)(70206006)(70586007)(2906002)(426003)(36756003)(5660300002)(316002)(110136005)(47076004)(42186006)(26005)(478600001)(81166007)(356005)(186003)(82310400002)(2616005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3295950-d229-4a2a-49f8-08d7eec2cfe5
X-MS-TrafficTypeDiagnostic: BN7PR02MB3954:
X-Microsoft-Antispam-PRVS: <BN7PR02MB3954263EC22B81A69DBBEEB1CAA80@BN7PR02MB3954.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcQU5vuErY7fq6oG5EvDFrRsuLBKPmqiJKz5wY2d7KtjZpZgIuT55Q2nyM100aeJCJ0QIttrc2jtKs4c6Gnupj8YUZLE831D/0TWfdV0XG6tul7d8ST71dIVllRu/INnZEnkXj8KTXnMCORVsMSPmJwS/2Ts5X0Gd5/3GZSOGAYcGCaWzMHuPNcddomUiTjCpKNYNE/Oc8bq+OFP1mrEX2yS5vIrsBvGIILIO/upjFZAXj/IJTbGuxSoOhg9ggjCdLp3J1BNysKVJX/L/vVjPKzjID/2dyhlwIkMKfrIN5HOE8SRsJuKiG1MXo/IaxouwqYWHVPGCLXZim+Y4ocCQZ6ik50Vb/ido3dmIb8r81HHyZP5KNA4puqrnZJmU3Yw1KON/t5z0izceKNBlmcma69YaScxmqG3DqIBnc3TEDS+4AlDSpHNQSoAUA6dZ/jc4BRjsUE+5NL5wbWgrzz1CgoIESzP8a5GnJes7Sg8+gkJ2UwzEuVLlZuEuetaLjzVoofq9USq6Se314oStbf8uA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:17.5041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3295950-d229-4a2a-49f8-08d7eec2cfe5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3954
Received-SPF: pass client-ip=40.107.220.56; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.220.56
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

Hi,

Following patch series fixes issues with priority queues,
Adds JUMBO Frame support,
Makes Debug statements compilable &
Fixes related to multicast frames.

Sai Pavan Boddu (9):
  net: cadence_gem: Fix debug statements
  net: cadence_gem: Fix the queue address update during wrap around
  net: cadence_gem: Fix irq update w.r.t queue
  net: cadence_gem: Define access permission for interrupt registers
  net: cadence_gem: Set ISR according to queue in use
  net: cadence_gem: Add support for jumbo frames
  net: cadnece_gem: Update irq_read_clear field of designcfg_debug1 reg
  net: cadence_gem: Update the reset value for interrupt mask register
  net: cadence_gem: TX_LAST bit should be set by guest

Tong Ho (1):
  net: cadence_gem: Fix RX address filtering

 hw/net/cadence_gem.c | 164 +++++++++++++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 72 deletions(-)

-- 
2.7.4


