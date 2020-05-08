Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D7C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26399208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Khz3rnv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26399208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0vf-00054U-9s
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sJ-0007mq-RW; Fri, 08 May 2020 07:09:05 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com
 ([40.107.94.82]:4449 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sG-0002Ai-50; Fri, 08 May 2020 07:09:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfgbiIcjeFKg08u+qwEtA8EZepni2qFBz1zlcFdSBhcULue23DV0gjnq3lNGtf55YDJ1CHjuuO6lJcNmi93g83LppJ732jkCEsbRmHCEI3ctlNb6WEjqmgLXrwAhJEnxZOsqygJHAAl+An8omPclqO8HeA0X5/n0xhPe/hobZ6qgAmo6nQ/mmZhNXF2lIdGRU+y9RVM7U2pwhiw3fI4RbIGZ8ThBQwLoRr+ppiqQHsuTE+wp/pWWryjQ/KOab7i1l3YchH5cTSkTfGYQnx6k7RcHs2Bn7Z242rqiRmFmrLQnfzy6vq27ajGXkeOGHEWVZfXdLDsKFwVd/zyD1PUi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbGbxkA1cH/I4gatUptCrW+lrcA2B+K27ppytN5irCQ=;
 b=S4NlM6DGCkfnx6/9BEbEv0isy/DkOZeW8tsO7fyknZ+w5ciJFuHIGRTO5rYS1Iu7hu15r/vxeEc5n0aWQYBK8tWocPfykUCtMeDM+IFqe5NyYtiAXoS/8fq++B6pjJmBy8SieGodq57/NEpYyi/7wXcBLrofOBjPswZNOFzXbnBXrcaPyu+IR11uDZf0XushjjcFr6gTzwXnXpBbXMKTal+r539OYz6F915JYZYdzCW37NHieaULxkK2WIiVq8mHxRqjHP71ceDW7K22w5v6eUwcI07rmkNfN3jYczA3QBTqcne6ZBKD2t9cwFEQTXwnxUNkrAQqJuquGdfKFoHlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbGbxkA1cH/I4gatUptCrW+lrcA2B+K27ppytN5irCQ=;
 b=Khz3rnv5V/fofAB0tq5gQefISZHYaNlVyqgnuPUVFhHfHAnoFscm9cnfUfpfbvhunbEpFBpCA5DHGrHmWzBoVZo7NF6o9dL2OE/cc55kbllmmaIcxUEwuTNmV82nZq5AHh8NhzSKJmEQ6Ptij0sW4JqeaTgfRX0lKfUe7kUcUNs=
Received: from MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30)
 by CY4PR02MB2613.namprd02.prod.outlook.com (2603:10b6:903:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 11:08:55 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::d1) by MN2PR20CA0017.outlook.office365.com
 (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Fri, 8 May 2020 11:08:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:55
 +0000
Received: from [149.199.38.66] (port=36132 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0rz-0002U3-SI; Fri, 08 May 2020 04:08:43 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0sA-0005eh-Lb; Fri, 08 May 2020 04:08:54 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8rPG017623; 
 Fri, 8 May 2020 04:08:53 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0s9-0005eO-GE; Fri, 08 May 2020 04:08:53 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 6E32913C03F7; Fri,  8 May 2020 16:31:01 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 07/11] net: cadence_gem: Add support for jumbo frames
Date: Fri,  8 May 2020 16:30:41 +0530
Message-Id: <1588935645-20351-8-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(136003)(39860400002)(346002)(46966005)(33430700001)(8676002)(4326008)(110136005)(316002)(2906002)(186003)(82740400003)(26005)(2616005)(426003)(5660300002)(336012)(47076004)(6666004)(70586007)(81166007)(36756003)(70206006)(356005)(42186006)(478600001)(82310400002)(33440700001)(6266002)(8936002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3a54a81-d3f1-4051-baf8-08d7f34032c6
X-MS-TrafficTypeDiagnostic: CY4PR02MB2613:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2613D7C42166D7D0E72E1BA1CAA20@CY4PR02MB2613.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFqkhgq44rtRDjIsydv2mkkFLqiwBoBKkwfakG2RF2Joo7qlZLUB7Ty4/DRS63OEqnOOjtIyp2Gw/8nr0Kqe4eNh2WBTtbpFG2wZlWcryDDg5v8r0T7jGA9i6tNShOCZwVD9E9H5SnwmYx7qM+/vFni0x2doupKlA7Yppw6Wd1krQb3p16lnMQa+bglgyJUNpVNWf//a2FALI3xlh5sme94vNjbjJP3Sa0q434vWHJ6NN64hX+ACBUMy6UynSBzbvjnSQjoJxik1RNFZkgWftT8Jzve58KjvmkXC16w5wtZPMnlanSVSWV48aFE26ijqpCF+mVuwOMpwpyNexDFZoreFNezdC4SniPJbNexshyN1MK7XA3LrhRTveznam1JF70xD9NBaq0EcaKjydMZHgY/Z/5f6kF8FecEUxZ0DKI4TKI6tLWucJc3WFNpI7AMNkNhW7eQak3ZDdcFjxIdg1N8thKBk8DmKEUIwt0qsqjNAzFBIW8ZxetqWyUvbHfAA26THm+NaHaUXQY2jHkwPxFVuy8MNIDnttWCN5RrVFpQu/+2xEkFObOqRhN1hJH70KP4x7qQaldmtxHMpeNZxqg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:55.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a54a81-d3f1-4051-baf8-08d7f34032c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2613
Received-SPF: pass client-ip=40.107.94.82; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:57
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

Add a property "jumbo-max-len", which can be configured for jumbo frame size
up to 16,383 bytes, and also introduce new register GEM_JUMBO_MAX_LEN.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c         | 21 +++++++++++++++++++--
 include/hw/net/cadence_gem.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 5ccec1a..45c50ab 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -61,6 +61,7 @@
 #define GEM_TXPAUSE       (0x0000003C/4) /* TX Pause Time reg */
 #define GEM_TXPARTIALSF   (0x00000040/4) /* TX Partial Store and Forward */
 #define GEM_RXPARTIALSF   (0x00000044/4) /* RX Partial Store and Forward */
+#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame Size */
 #define GEM_HASHLO        (0x00000080/4) /* Hash Low address reg */
 #define GEM_HASHHI        (0x00000084/4) /* Hash High address reg */
 #define GEM_SPADDR1LO     (0x00000088/4) /* Specific addr 1 low reg */
@@ -314,7 +315,8 @@
 
 #define GEM_MODID_VALUE 0x00020118
 
-#define MAX_FRAME_SIZE 2048
+#define MAX_JUMBO_FRAME_SIZE_MASK 0x3FFF
+#define MAX_FRAME_SIZE MAX_JUMBO_FRAME_SIZE_MASK
 
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
@@ -1343,9 +1345,10 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
-    s->regs[GEM_DESCONF2] = 0x2ab13fff;
+    s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
@@ -1420,6 +1423,9 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
         break;
+    case GEM_JUMBO_MAX_LEN:
+        retval = s->jumbo_max_len;
+        break;
     case GEM_PHYMNTNC:
         if (retval & GEM_PHYMNTNC_OP_R) {
             uint32_t phy_addr, reg_num;
@@ -1516,6 +1522,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->regs[GEM_IMR] &= ~val;
         gem_update_int_status(s);
         break;
+    case GEM_JUMBO_MAX_LEN:
+        s->jumbo_max_len = val & MAX_JUMBO_FRAME_SIZE_MASK;
+        break;
     case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
         s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
         gem_update_int_status(s);
@@ -1611,6 +1620,12 @@ static void gem_realize(DeviceState *dev, Error **errp)
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
 
+    if (s->jumbo_max_len > MAX_FRAME_SIZE) {
+        g_warning("jumbo-max-len is grater than %d",
+                  MAX_FRAME_SIZE);
+        s->jumbo_max_len = MAX_FRAME_SIZE;
+    }
+
     s->tx_packet = g_new0(uint8_t, MAX_FRAME_SIZE);
     s->rx_packet = g_new0(uint8_t, MAX_FRAME_SIZE);
 }
@@ -1670,6 +1685,8 @@ static Property gem_properties[] = {
                       num_type1_screeners, 4),
     DEFINE_PROP_UINT8("num-type2-screeners", CadenceGEMState,
                       num_type2_screeners, 4),
+    DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
+                       jumbo_max_len, 10240),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 8dbbaa3..ef85737 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -82,6 +82,7 @@ typedef struct CadenceGEMState {
 
     uint8_t *tx_packet;
     uint8_t *rx_packet;
+    uint16_t jumbo_max_len;
     uint32_t rx_desc[MAX_PRIORITY_QUEUES][DESC_MAX_NUM_WORDS];
 
     bool sar_active[4];
-- 
2.7.4


