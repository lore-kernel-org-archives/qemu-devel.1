Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028CCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C087020721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="f057PTeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbzG-0002wb-U1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrS-0007CJ-8K; Mon, 04 May 2020 10:14:22 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com
 ([40.107.243.71]:52449 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrP-0005dG-VD; Mon, 04 May 2020 10:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL/M2EgGbG5QjYyO/6fAdHafU8YR6GxbDSWO5IUo0VmVKiMp3eU19VQcjZFSUwfLMy9h3nICAegiyyLNkAanDgaWykKOpOuVuSWyjUY4vGBduU1NtUKbG5U7N8BGNZRXkTWbRRgUNTJhakDiZ5q6vtXIsRBc34YFrADfqIG9kU5iJhIYlEDsCGTJKyreP3gwO7wYdYLdusmPDyENiJD56gF2SZhPj5XjDib1DGg7hxVE8FPp/RGsLg+RbS0KaO1rHZlxHdRyiTwxaDyVyEDzm4rGOOri30RPkmfTLNrxzeg4nOvwEPdT0EBPCIwsYgHOQy0R8JY4QY/5DfHVOis3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJPoZj1jwk82kYAZvdgPn3Oj+p95NBJnd5p5MgU1IVA=;
 b=c5bYgecE6grcZqvggE7YeiQbwW85+ZASPpKbjwYEJX62ZE548n7Nc+AqUa2qsaDu2MK8dsidVnAUcvH57dUKZbIy6X1N+f8u8vSQcAJm3FnWIjDD+6hkXjmUF8XZnocC8bYVJ+W7L9csxoVbgbcdzC7IhVO0Oyfc7rb+fSDiiniwv9DjFFL2XtqGBNUWnHyE8FWfb7N4Ih9cfHEQFD9lEU5vJdTYCyc117SMdjkCxoHwKT8kEHnRAnOMrRdu7END2aRSQjY1JpIUcBv7C5aQhWNg8N6+B9d9P0+Rn+KMrK+EnLW9K17FOJKRZUnYvrf6sIO6DUjrh4tJdoesgQEbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJPoZj1jwk82kYAZvdgPn3Oj+p95NBJnd5p5MgU1IVA=;
 b=f057PTeFFypCINTRO7uR03PVxtYQKE2CxD7rHKn68O/QmWcVqVsYHapU4SzmZRmKQ3cEFpO+rTwx+aBTExAcD3Q8C07YPPzpa0+kgwqXCxk0jAOTdUaam/gaDlzZJ1k9qxFDrrRlavpdJSingdEs72j1C9WTCp1hQe3ij07Xihk=
Received: from SN4PR0501CA0151.namprd05.prod.outlook.com
 (2603:10b6:803:2c::29) by CY4PR02MB2296.namprd02.prod.outlook.com
 (2603:10b6:903:b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 14:14:16 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::ec) by SN4PR0501CA0151.outlook.office365.com
 (2603:10b6:803:2c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.16 via Frontend
 Transport; Mon, 4 May 2020 14:14:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:16
 +0000
Received: from [149.199.38.66] (port=43039 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrG-0000Gn-53; Mon, 04 May 2020 07:14:10 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrL-0000wX-Pz; Mon, 04 May 2020 07:14:15 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrL-0000wO-0u; Mon, 04 May 2020 07:14:15 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id BA12613C304C; Mon,  4 May 2020 19:36:33 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 06/10] net: cadence_gem: Add support for jumbo frames
Date: Mon,  4 May 2020 19:36:04 +0530
Message-Id: <1588601168-27576-7-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(186003)(6266002)(5660300002)(8936002)(4326008)(2906002)(26005)(6666004)(8676002)(70586007)(70206006)(36756003)(42186006)(110136005)(81166007)(47076004)(336012)(2616005)(356005)(426003)(82310400002)(498600001);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eebaf62c-bbbe-4bcc-69af-08d7f0356dc2
X-MS-TrafficTypeDiagnostic: CY4PR02MB2296:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2296A706E29142A11883E35CCAA60@CY4PR02MB2296.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:68;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89Rfra+WyNFMuLHVRE9ateI8tVeMdg8WPPBawq2Xcu+ckEtFJQyvtLxsGhE6P21c1Ur4fis9mSkIsgqPXTNoGTCzs1LB8y2dtiRw4cH9YbpOzSbD+6iNxd4OYkXjrusvqCOpvsOB4EYaXdrGGOSquHJD8kCGTs1pQuvKz8zcEIfId5vs6xCPXpmg2Za/gguhBrHvJLpBVDAwuaq0Mq7neCiyTouetYRhK4uwAM51I8GNoJzTEMhjGCr0HfzaGxLfexfJ+qDSr7qNRVs92+DLpA/HLjfUI6BMGRnipatlHT6gBLk2mJL31R3rBIhG92jMdoUQZB3rzz6Q1PMf0RhdFKSIpmxQCA7Ob2Z2i8N6slSGCQa3XOnoJXSFDPaJKZYdWgo5yILBCv1hYgWq6+z0noAEemkaUrW8l0nEbkWPPhcSO1FpEuWQOAOPIFe0hn4szLajZCD6G58m0FpGRAaeKCF2shFfaIjmX5F9oT/X4aDANoUNfwqdlBWEkNGi4cuEB4oqCkiT3eV42sgb1UILEg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:16.1475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebaf62c-bbbe-4bcc-69af-08d7f0356dc2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2296
Received-SPF: pass client-ip=40.107.243.71; envelope-from=saipava@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:18
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jumbo frames of size 10240 bytes is added.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index beb38ec..848be3f 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -313,6 +313,7 @@
 #define DESC_1_RX_EOF 0x00008000
 
 #define GEM_MODID_VALUE 0x00020118
+#define MAX_TX_FRAME_SIZE 10240
 
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
@@ -1143,7 +1144,7 @@ static void gem_transmit(CadenceGEMState *s)
 {
     uint32_t desc[DESC_MAX_NUM_WORDS];
     hwaddr packet_desc_addr;
-    uint8_t     tx_packet[2048];
+    uint8_t     tx_packet[MAX_TX_FRAME_SIZE];
     uint8_t     *p;
     unsigned    total_bytes;
     int q = 0;
@@ -1344,7 +1345,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
-    s->regs[GEM_DESCONF2] = 0x2ab13fff;
+    s->regs[GEM_DESCONF2] = 0x2ab12800;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
 
-- 
2.7.4


