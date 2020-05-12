Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51421C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF5B206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ek5Pv6QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF5B206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUpo-0000qg-5W
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUns-0007TC-4m; Tue, 12 May 2020 09:18:36 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com
 ([40.107.94.66]:6112 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnq-0001zE-0l; Tue, 12 May 2020 09:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9eOpZ82suR6PSFXe+pxl4JGXgk4uz1h7O5lJ491qTgs7gmge8bUb7ahDsW2BC1ZaC2U20qGbvJgiGqiEVSuGjouWCUxUDYQmgWpYnPO8J/3h9PFlZ7g+OysSd7MLEk6l7H1Rpo8omrNZOlwxPJNiEEXgHNLUThpJZRvCi5cFft5Fh+D5Uoeqzb3MSpPxTMzJSDSSnvyRscTHlGU6T2Ilp5gmEVp40lSFIw4D+THc/3fgrSt26eyOFixW4l+4Hwo+b8dXTk2L3jc1gdl11jrghEWbXv6mOaKqP3a8xS0rxlaA/m7LFj8f9A0rRKJ9hZB3LlFxtIkWK117OfbpY3/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHbwx8DDwAgkmuW5mQVte3k0zRqUyTVvLZAW8sLRfG0=;
 b=NLNn4+A9C+f5upke0CAwTHlbemAqyrlchVMip5IEPPXtPR29Ye1C+NrUB5UY7eT45yPtOtHOKcxNL0DRp8G1QbnZXBHOkeGkLyMWLjM3rzoz7lv7m62xN2QaviOcx8EO9dEt2qnbnAypxKFm/8TQpsoi4oGk2SpwWzuy6e05uivdJWCq16bVM9raRfLFQMMXfteu2l0Mszrfh8yInkkmo4rfBYCQuI7rgdxc1Iq3WzkmZ5ZbdGD+yPh6LUF7yWwSxFH8RyH+j186eRdOIHBk7iGFZSh0pfu6tbJUTr5OYEcYz8jJQtcY/zgDITWyvgOmdZapLQH8PkSUvp0nKjd+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHbwx8DDwAgkmuW5mQVte3k0zRqUyTVvLZAW8sLRfG0=;
 b=ek5Pv6QAOMqQ5lAUPOub954jQxlTWePmJnY4wMJrLYIhdgB4zXZoHc7AXvc++QeZqgjw+3twjjvIT765dY/mi94MnSLQziu0nxTe9myt8KNhupMczfdZAFhXqz6GXH4BbzzVJHuE4mBJL12HQtF1UlIjk7eB8tkDi4vRX28r75k=
Received: from SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41) by
 DM6PR02MB4908.namprd02.prod.outlook.com (2603:10b6:5:13::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.35; Tue, 12 May 2020 13:18:29 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::d2) by SN6PR01CA0028.outlook.office365.com
 (2603:10b6:805:b6::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend
 Transport; Tue, 12 May 2020 13:18:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:29
 +0000
Received: from [149.199.38.66] (port=47612 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnU-0002QG-NJ; Tue, 12 May 2020 06:18:12 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnk-0005Yf-Uu; Tue, 12 May 2020 06:18:29 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDISZb028644; 
 Tue, 12 May 2020 06:18:28 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnj-0005YS-PT; Tue, 12 May 2020 06:18:27 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 698EA13C0170; Tue, 12 May 2020 18:40:24 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 01/12] net: cadence_gem: Fix debug statements
Date: Tue, 12 May 2020 18:39:56 +0530
Message-Id: <1589289007-23629-2-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(136003)(346002)(39860400002)(376002)(396003)(46966005)(33430700001)(82740400003)(2616005)(186003)(4326008)(33440700001)(70206006)(70586007)(5660300002)(8676002)(2906002)(316002)(81166007)(42186006)(6266002)(426003)(82310400002)(8936002)(26005)(6666004)(47076004)(336012)(36756003)(478600001)(110136005)(356005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ccc5434-d55e-4862-c0f9-08d7f676f640
X-MS-TrafficTypeDiagnostic: DM6PR02MB4908:
X-Microsoft-Antispam-PRVS: <DM6PR02MB490861BAC778116A968202B1CABE0@DM6PR02MB4908.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uKY9oweROvC2AZDr0vdF/q3Up0SpJnOZu/prKtHyawrg832c/kOQ9XzEU3LmJYhZUxBaRLs1rRa0n8x1vlaaJOAT2plaOdPn6b9Ms0t8LRrd18g9Bo9gBZlPWR5raCUc+XafJXclJjQz3CXSGPEidt0fdK82at/vAOWkX2caPfTJS0dBxsYGjwwy4qbMYjo2dk7Q/ulWrZz5V4aUu6lBRazji1DXgQRP7R3e840goi2+l+9GqK5OxyOAWD0mFhbW+uRyaDxeBap/+e2RQDiB6aIN6Ej1FgEuYxbA4+cELdol+b+4+W8fAqQueldnxISv5XzZTt7SbFI6kWI1PRnN2+TwF8bua2pxQxtjZZoL2cF6iMRL6KTFOn3btWNNibOKDs/3PQoSoq3iOSM38gvRC0F9i/zyyM7KM7MJFus0FlAt98VPGUhIvdEBgZaNSSJ6nBJCOEs/zfBYwwed2LT8LU3Da0daODfjNRsvzQ1WicAzRyyOSUORs1n8C0bmXA8wjYdzGd5Dh0mgqmadpqImixlyHs0k2W0JxmgZ5f1RJBP/ZaVAvqQur1aLjqJjwjttxRQt1aHj3h6yyCqlE5hEQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:29.4087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc5434-d55e-4862-c0f9-08d7f676f640
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4908
Received-SPF: pass client-ip=40.107.94.66; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:31
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

Enabling debug breaks the build, Fix them and make debug statements
always compilable. Fix few statements to use sized integer casting.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 22a0b1b..5476c62 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -35,14 +35,13 @@
 #include "sysemu/dma.h"
 #include "net/checksum.h"
 
-#ifdef CADENCE_GEM_ERR_DEBUG
-#define DB_PRINT(...) do { \
-    fprintf(stderr,  ": %s: ", __func__); \
-    fprintf(stderr, ## __VA_ARGS__); \
-    } while (0)
-#else
-    #define DB_PRINT(...)
-#endif
+#define CADENCE_GEM_ERR_DEBUG 0
+#define DB_PRINT(...) do {\
+    if (CADENCE_GEM_ERR_DEBUG) {   \
+        qemu_log(": %s: ", __func__); \
+        qemu_log(__VA_ARGS__); \
+    } \
+} while (0)
 
 #define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
 #define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
@@ -979,7 +978,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         size += 4;
     }
 
-    DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size);
+    DB_PRINT("config bufsize: %u packet size: %zd\n", rxbufsize, size);
 
     /* Find which queue we are targeting */
     q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
@@ -992,9 +991,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %u bytes to 0x%" PRIx64 "\n",
-                 MIN(bytes_to_copy, rxbufsize),
-                 rx_desc_get_buffer(s, s->rx_desc[q]));
+        DB_PRINT("copy %" PRIu32 " bytes to 0x%" PRIx64 "\n",
+                MIN(bytes_to_copy, rxbufsize),
+                rx_desc_get_buffer(s, s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1160,8 +1159,8 @@ static void gem_transmit(CadenceGEMState *s)
              */
             if ((tx_desc_get_buffer(s, desc) == 0) ||
                 (tx_desc_get_length(desc) == 0)) {
-                DB_PRINT("Invalid TX descriptor @ 0x%x\n",
-                         (unsigned)packet_desc_addr);
+                DB_PRINT("Invalid TX descriptor @ 0x%" HWADDR_PRIx "\n",
+                         packet_desc_addr);
                 break;
             }
 
-- 
2.7.4


