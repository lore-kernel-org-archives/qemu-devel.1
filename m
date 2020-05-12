Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0EC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4B520752
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ItDxrq8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4B520752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUvz-0002lB-TQ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnu-0007Ur-FB; Tue, 12 May 2020 09:18:38 -0400
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com
 ([40.107.237.40]:61811 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnt-0001zz-3L; Tue, 12 May 2020 09:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atXAPXFIQLrkgJ3cOJXgd5e02uYkeEF/HcdSOkHppHnJXloq2duNAbP7rQq+x0vaPJUkgqz2QuQHjk50K92PKru8yAQaQcjej0I17UBuYqJ3RL5OZWbWyjXX/LzNxXRetOIvlVUUpCNJ1fTO7Yojf0j731y0NhVz28MP47Llk3VvFY+SIcXAwQIi6oKNpG7/V9Yy4ETcg+sOLMBJ3HzUQFZCHq5tFhdqyaJMPF7ZZk3PD6RnMQWwYN3kDBNJPoM6Mio62BpNpNUWsodZGzFrDZlOr3spkp1iKOqby2eAWbhujZLtQdDSy/jQ6QfPQ2p+xsDtox3938MEUaO/G2UaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EpXeOfC1ILQqopTX3n4mY2+rnEuGrApg5c5SMjIDoY=;
 b=mgehmsIuWSMNxGmvZRADJhQn3NtGPN2XatzVHqjQshXL9C4vdmsMLVIawWMGB56u9wT11AC9+PEOoxXUAGOzScVNjg/EpkLLUpQMv5653wsYyuT3KAYdfYXpMK0VmwKWuXOmPokpQLWlHFTT8+imFDGUYcHba9Te1gODZ/so9/bF/bqn/sWJP4uvz+6wXF1+otcbcx4Dvl2ZZXzdErS2uYatpRzrb3MEdMooZMiiSDd6EAgijoY9cPrqaIjSFj7Xz8kf55lz1Pb7Qwlt8lnHYcVMnx/8ftxZMRr4dJ0P7gBcDYPCCztq//rWMKSIlLtYf/+Kyte4gR0VvjP4a6d2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EpXeOfC1ILQqopTX3n4mY2+rnEuGrApg5c5SMjIDoY=;
 b=ItDxrq8ZUJr2Ut1jLl2ZfZAFMUf/2aJcNNcCyL7ajj8osDALjMFDhlUJR9Xj2dJ8NUSB1jYtm6gdZ3Cl6Le11mE/krGW5YKNN/H5HFc4YDOK9rUsheYpmKR19cZf7+FF2iZzrCunMDALZSA26nBhrA3TTGlX5of8u/sCjEmY3W8=
Received: from SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) by DM6PR02MB4762.namprd02.prod.outlook.com
 (2603:10b6:5:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 13:18:34 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::b4) by SN4PR0701CA0001.outlook.office365.com
 (2603:10b6:803:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 13:18:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:34
 +0000
Received: from [149.199.38.66] (port=47714 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnZ-0002Qi-Gw; Tue, 12 May 2020 06:18:17 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnp-0005Ze-OY; Tue, 12 May 2020 06:18:33 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIWgb016850; 
 Tue, 12 May 2020 06:18:32 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUno-0005Yh-DW; Tue, 12 May 2020 06:18:32 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 75E5B13C0170; Tue, 12 May 2020 18:40:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 09/12] net: cadnece_gem: Update irq_read_clear field of
 designcfg_debug1 reg
Date: Tue, 12 May 2020 18:40:04 +0530
Message-Id: <1589289007-23629-10-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(376002)(39860400002)(136003)(46966005)(33430700001)(33440700001)(2616005)(6666004)(4326008)(42186006)(110136005)(478600001)(4744005)(426003)(316002)(26005)(6266002)(356005)(186003)(8676002)(70586007)(2906002)(82740400003)(47076004)(5660300002)(82310400002)(81166007)(8936002)(70206006)(36756003)(336012);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 544f08c5-52a9-4838-a34f-08d7f676f923
X-MS-TrafficTypeDiagnostic: DM6PR02MB4762:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4762BB5431A3EE7F638F4305CABE0@DM6PR02MB4762.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIIJmpWtNnSNhfOGux7s+LDTV8yzpVQ1Qk0kf3mrcfmOsyms4RNZ9bld1YIt8UChnw9Xwj+VwN4KYVVNps/z6EdUaUlIJc3f45+XuAQMaz8ZRcK2YrlP0Mg9qm5nBRYTUc1f3aI7V4uI1qfplsdrTJ6sPycUAQWupHYSDF6aV6TqQslCCoq0ZJ1wcLvSJePedyzkn9DHMKQ+dEcqs/TeBpBcXk3DMaKY3alBDI6r4cpAA6HX/K5OhldfJYz1YSqort1Dfl7xAwAGEhDlmncFZ8aNi0a+D+EH8dC3SHf8k0slS0wwqGWHYCzgOtPufPdm3wdrR1Smv3jp4Axddv7x9gaHxsL1polEp00eK2fKhN3Vj5FyQt70K7ygCYq8KzYr239U5lnRDFJcM+PIY13k4ZLf0YIcdr5Pnvc5ZPUgQAC1wPIxwbKNOA44S8JZrfsbzqHirxUOn8BJzxhd7OkJpq0duKLn6ZksMTT5xFTcWoVq04eEeX5d8rWwXYReY9+dDzHjQoio8ttiPKmMEjO59LKPn7SCcwsfL3R5bJ4rI70nnPU9wgmHwCS9+TeshKzmsgLiHWChilYIQtV43Opbvg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:34.2510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544f08c5-52a9-4838-a34f-08d7f676f923
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4762
Received-SPF: pass client-ip=40.107.237.40; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:35
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

Advertise support of clear-on-read for ISR registers.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 85142e1..423b47a 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1366,7 +1366,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_TXPARTIALSF] = 0x000003ff;
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
-    s->regs[GEM_DESCONF] = 0x02500111;
+    s->regs[GEM_DESCONF] = 0x02D00111;
     s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
-- 
2.7.4


