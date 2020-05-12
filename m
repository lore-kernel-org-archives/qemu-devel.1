Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E056C54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580642054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SJOyTdJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580642054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWhG-0007UK-Gt
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSV-0001PZ-IV; Tue, 12 May 2020 11:04:39 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com
 ([40.107.69.81]:4096 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWST-0002dM-Jk; Tue, 12 May 2020 11:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmYqNMBbUFpUT3b4fKa49lykdaYB2tQzUeNQoiupAViZkkRk71oSed2FoxJj09LDvpnTT+n3FlvQHUY/b+ZK6OHNLIpTKxkB8ptkWeudiy7s8ELwJX7VjeAgMG5OwG2oj/X/mAj2Rui3t8AbD7UH3jamZP+ZE1C0LE6vr270HNuT1dZGt/XCYqWjsNhboH4ZP9ybesmI0DslbiIF4KRkQjCadZ8+78V2DmgCn6yxbpwzHEjwXgdGJjbbc4kM2jyPxxE+xfbSVn9ZQkPMF/g7OIdEl2DGdismhq0lSesyNWz8BrNvuKXXUgZKsK1PaCi5Yxp04e7uHDQVlVpcY/ElNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHbwx8DDwAgkmuW5mQVte3k0zRqUyTVvLZAW8sLRfG0=;
 b=Paoel3/nlUePqz32175ycFRbwtRTXk4XXZRNQos5aMZBenZfYDjU8UfkCNY4L4S09eoADZrg0G3rJSc+dUXPekfSFGTHAx3nBfr90mXoSUGjkzdxnU9sBqjsbQwZChDj0/PaPRMRy822Ux+VnMqKL+Kk0F2m+LPs3DavqG68IyIg+vPOUs4gRtjkA+6p26vqmltE6spsn198g6t5UH9UwnNVIjRN+/bJcgisGvOd9XVeRV1IY4UW++QbyYHtDvPG8w6X+KC434UooRkLRgmGvHRpC6qzWjVDNg2qJHlEmiZSZ2RuJZIBDFDbYMwx2IpdJT2fvdgb9vzJBEcA+0Px0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHbwx8DDwAgkmuW5mQVte3k0zRqUyTVvLZAW8sLRfG0=;
 b=SJOyTdJ4VyPd/jIkUN6B7C++7Cd2XRlQl2VM5pw7LD9QUKNQbRRS37mv6npLRBcCAG10aLMk+Xp1d+IcZGj/H0yekURrhSU/hXSnGtdRFoe9wgfQbH5RWLZHT6opP5BPENKqODB1RY4Nk7DluO0YUBuj0ed/8Jig2PcyPbSlkT8=
Received: from MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25) by
 BL0PR02MB5396.namprd02.prod.outlook.com (2603:10b6:208:86::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Tue, 12 May 2020 15:04:34 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:10c:cafe::47) by MN2PR01CA0012.outlook.office365.com
 (2603:10b6:208:10c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Tue, 12 May 2020 15:04:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:33
 +0000
Received: from [149.199.38.66] (port=48762 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWS8-00045M-Uw; Tue, 12 May 2020 08:04:16 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSP-0003nu-9M; Tue, 12 May 2020 08:04:33 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSO-0003nk-NS; Tue, 12 May 2020 08:04:32 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 258CB13C00F6; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 01/12] net: cadence_gem: Fix debug statements
Date: Tue, 12 May 2020 20:24:43 +0530
Message-Id: <1589295294-26466-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(376002)(39860400002)(396003)(46966005)(33430700001)(5660300002)(33440700001)(82310400002)(8936002)(8676002)(36756003)(478600001)(6666004)(186003)(4326008)(356005)(42186006)(316002)(2906002)(70586007)(70206006)(81166007)(110136005)(47076004)(336012)(426003)(2616005)(26005)(82740400003)(6266002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 595f0322-56ba-4b68-57d2-08d7f685c7a9
X-MS-TrafficTypeDiagnostic: BL0PR02MB5396:
X-Microsoft-Antispam-PRVS: <BL0PR02MB53963358D4C67E39955FA519CABE0@BL0PR02MB5396.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7B+BO3cXEo0U2IGWUtVh1Wl7NsxN1vxYknKkJeGH3SAp5I2dwZhGffmGPzh9l94eLyl0MY3RF4l3UXfCKP/AnW0KxPO3TmOoYd0FqiqEtp7HPCTzNOjL1lAOj1nO1GjkTgZ58ls5ET4KRCFA96UCuCVxuE1+ohmsUu44BMs3oTnDkrdrRQeCFdsg9ukMKvqJa3k5rumdJH4cIBR5t+ydCn8r+1McPSO30Hj1GuaRyu7GDzR3PUyKSu6jCea3MJfR9/Zammaaerq3ArK7Znmh/ZoGlSno+U30OP9a59ioYlu6BzIxMp/LCg67eGD+o9zmx1+nTnQP5svEHftAiefs+5bSSze9zueaf0tLU+RQl6rS4Y5wvLqx5toF4fq24toXuk1UN/tslt6HcWVVIpw7QeB80wZjYrisKw/QigvOthD1q/RAtHTd2FKHT08Rla6EpUJvOtJJWd1P7NLejYtSbjWT+3CzLDP9p7FhEj+mDjJaZvbabAiv/m6y+7phYwLSc2gcBljkEjCbhKo74xkuPLSCGCXpdYvom9msle8UaW94NkKaXI6oW7piioLk39nflfrTNs6YkmFJGV9Ms2EZg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:33.6911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595f0322-56ba-4b68-57d2-08d7f685c7a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5396
Received-SPF: pass client-ip=40.107.69.81; envelope-from=saipava@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


