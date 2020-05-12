Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C52FC54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0880D20674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="d9whPErF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0880D20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWbX-0008B2-4b
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSX-0001Th-A7; Tue, 12 May 2020 11:04:41 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com
 ([40.107.92.56]:22250 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSU-0002eS-7U; Tue, 12 May 2020 11:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF+eW+cGGRR7Q7Dqs6hpQ6plWEA7eMNumW6MhXYRRT8g4HzUm0yJmrFP20BKN82Gb7mq9mm+GFt+SsDlXFmS9C4kAHd3Q9sazsmtYkEdlH08JGiOmqQM08fmiIWG2Ozy6cWhDzh5QwzmX92M+Uqu1TZTcJwDtQ+sDrTykL4SAq7zB4ZY5yDhRgM9EO4Qped4E1N4fmvV+UE4TBn0EeZLGT/UBR5JRB5ingzaDp87WRvNqH9S4jrZRwnh8RVfThWa76B+5UVjVVMqgU2GO/nokdKBu39apA5Cn5OpEn+z71u5E0s1FcmzxKCGPu+wOIHzzPAqZuOlbWeixj71jJKh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDDfQay8WPdmdMcKmLynxs0u9Nr1s4msHPOvoJh9eKE=;
 b=hCNe9WQPZJBYeiMewbZ0KYzPw7Ud/2PJTyqDnY8fGywrRXKHxyLWpSnirD5ueFXX3UykKKW9HwH7haobjidL64VQEeTHE/JuHK94R4uDHRdJGNI8SKSFa6j79q37u1JD8wc0y3wvQV5LzcpOo1BMP+abCBsNICK1GH+Jcbdoy4HX6K6wN26k2HwtWN9YrS+Nf5V4czqOav/U72XIucftN9r60nAQRWqIUoi/o2R/2wJNIyxvCiuc7FIB3vcfaSgE9tvQofdrczKF2TjTsREgc7BVkfCsZon3om/QRkozHLaHcbT/vzWAMpPw21MhfgIfcMRYQ3S4HAnFyZuKzSg7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDDfQay8WPdmdMcKmLynxs0u9Nr1s4msHPOvoJh9eKE=;
 b=d9whPErFS5piPFhw2pFasvsUZAaDMI4+Vni+rT9onx6xYk5sM3H4G7h6/twe+v5t7OikVSs1cRXSRVbIcFvtCcGTPSSlBzZYGyabn7DyQJo9HQpSfxO45jUW1SY7dLhs/ZS7nltRpqT/O2vJ+aDl284ldfrmn04AlylI/EOPxLI=
Received: from BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) by MN2PR02MB6605.namprd02.prod.outlook.com
 (2603:10b6:208:15f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Tue, 12 May
 2020 15:04:35 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:17:cafe::3b) by BL0PR1501CA0026.outlook.office365.com
 (2603:10b6:207:17::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:35
 +0000
Received: from [149.199.38.66] (port=48874 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSA-00045v-JQ; Tue, 12 May 2020 08:04:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003oq-VA; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003o8-Oq; Tue, 12 May 2020 08:04:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5049813C0175; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 07/12] net: cadence_gem: Fix up code style
Date: Tue, 12 May 2020 20:24:49 +0530
Message-Id: <1589295294-26466-8-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(136003)(396003)(346002)(376002)(46966005)(33430700001)(186003)(8936002)(47076004)(5660300002)(81166007)(33440700001)(6266002)(6666004)(30864003)(4326008)(70206006)(36756003)(26005)(70586007)(356005)(82740400003)(42186006)(2906002)(316002)(82310400002)(8676002)(426003)(336012)(478600001)(2616005)(110136005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b891d3b-1774-427a-c667-08d7f685c8a6
X-MS-TrafficTypeDiagnostic: MN2PR02MB6605:
X-Microsoft-Antispam-PRVS: <MN2PR02MB66050440839753F6E572AAE0CABE0@MN2PR02MB6605.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkxo5DyGjCY6nqRhFQUaFc48yi3BjrGQ2+BgW7HfpufJEnDDu9XO2qBmM80p1vbNQHpvoJar2IGYPfIzlyi2qrFe8YICOQBgYO7zicBbB71vfdESxtOB0x+h9nMaEmhCozjMs5pVyL+bmxwSpm+AcxtYqaB6pI6gXr2xHd32edK/yOzmdDXkYng9u4YfuCJmbXKAIWvoftIzpc1aL6JTBE+qeVtIrjcTSbklQhM6L7HtiCco+wth7PIG5nNtLUpf5nuU7L/tewPc/WEpTf1GuR7rvc0NTrcFGiA25JUgnis/r/JG+lx1VGODYAnEKKb28OTEnD7LN+WzTwS9axiS5GgwZYamAno5AmfZGLjAShDmByKExG07G5a1N95KLdouZPrQQJVr95JQrqneWqEi9R4LsXoopIJeiRXrrW86r3//LPqToUlxoi8Di6CRrT8e/k9K8MkZg1lex1J0zUCsGBLG7wW3/idVDKfsIDlDtx22K3T0CyoWWtd/ew12grO4h3qeGjAwVTm6pkWZYI7aDuEuVOfcOydGECbzLE0JuODb4j4QC7PRpNAMlWH7aseMyixa2ARylMD1UTcCEd7erQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:35.3520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b891d3b-1774-427a-c667-08d7f685c8a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6605
Received-SPF: pass client-ip=40.107.92.56; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:36
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

Fix the code style for register definitions.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 204 ++++++++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 101 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 11e36d0..f6ff27c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -43,110 +43,112 @@
     } \
 } while (0)
 
-#define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
-#define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
-#define GEM_NWSTATUS      (0x00000008/4) /* Network Status reg */
-#define GEM_USERIO        (0x0000000C/4) /* User IO reg */
-#define GEM_DMACFG        (0x00000010/4) /* DMA Control reg */
-#define GEM_TXSTATUS      (0x00000014/4) /* TX Status reg */
-#define GEM_RXQBASE       (0x00000018/4) /* RX Q Base address reg */
-#define GEM_TXQBASE       (0x0000001C/4) /* TX Q Base address reg */
-#define GEM_RXSTATUS      (0x00000020/4) /* RX Status reg */
-#define GEM_ISR           (0x00000024/4) /* Interrupt Status reg */
-#define GEM_IER           (0x00000028/4) /* Interrupt Enable reg */
-#define GEM_IDR           (0x0000002C/4) /* Interrupt Disable reg */
-#define GEM_IMR           (0x00000030/4) /* Interrupt Mask reg */
-#define GEM_PHYMNTNC      (0x00000034/4) /* Phy Maintenance reg */
-#define GEM_RXPAUSE       (0x00000038/4) /* RX Pause Time reg */
-#define GEM_TXPAUSE       (0x0000003C/4) /* TX Pause Time reg */
-#define GEM_TXPARTIALSF   (0x00000040/4) /* TX Partial Store and Forward */
-#define GEM_RXPARTIALSF   (0x00000044/4) /* RX Partial Store and Forward */
-#define GEM_HASHLO        (0x00000080/4) /* Hash Low address reg */
-#define GEM_HASHHI        (0x00000084/4) /* Hash High address reg */
-#define GEM_SPADDR1LO     (0x00000088/4) /* Specific addr 1 low reg */
-#define GEM_SPADDR1HI     (0x0000008C/4) /* Specific addr 1 high reg */
-#define GEM_SPADDR2LO     (0x00000090/4) /* Specific addr 2 low reg */
-#define GEM_SPADDR2HI     (0x00000094/4) /* Specific addr 2 high reg */
-#define GEM_SPADDR3LO     (0x00000098/4) /* Specific addr 3 low reg */
-#define GEM_SPADDR3HI     (0x0000009C/4) /* Specific addr 3 high reg */
-#define GEM_SPADDR4LO     (0x000000A0/4) /* Specific addr 4 low reg */
-#define GEM_SPADDR4HI     (0x000000A4/4) /* Specific addr 4 high reg */
-#define GEM_TIDMATCH1     (0x000000A8/4) /* Type ID1 Match reg */
-#define GEM_TIDMATCH2     (0x000000AC/4) /* Type ID2 Match reg */
-#define GEM_TIDMATCH3     (0x000000B0/4) /* Type ID3 Match reg */
-#define GEM_TIDMATCH4     (0x000000B4/4) /* Type ID4 Match reg */
-#define GEM_WOLAN         (0x000000B8/4) /* Wake on LAN reg */
-#define GEM_IPGSTRETCH    (0x000000BC/4) /* IPG Stretch reg */
-#define GEM_SVLAN         (0x000000C0/4) /* Stacked VLAN reg */
-#define GEM_MODID         (0x000000FC/4) /* Module ID reg */
-#define GEM_OCTTXLO       (0x00000100/4) /* Octects transmitted Low reg */
-#define GEM_OCTTXHI       (0x00000104/4) /* Octects transmitted High reg */
-#define GEM_TXCNT         (0x00000108/4) /* Error-free Frames transmitted */
-#define GEM_TXBCNT        (0x0000010C/4) /* Error-free Broadcast Frames */
-#define GEM_TXMCNT        (0x00000110/4) /* Error-free Multicast Frame */
-#define GEM_TXPAUSECNT    (0x00000114/4) /* Pause Frames Transmitted */
-#define GEM_TX64CNT       (0x00000118/4) /* Error-free 64 TX */
-#define GEM_TX65CNT       (0x0000011C/4) /* Error-free 65-127 TX */
-#define GEM_TX128CNT      (0x00000120/4) /* Error-free 128-255 TX */
-#define GEM_TX256CNT      (0x00000124/4) /* Error-free 256-511 */
-#define GEM_TX512CNT      (0x00000128/4) /* Error-free 512-1023 TX */
-#define GEM_TX1024CNT     (0x0000012C/4) /* Error-free 1024-1518 TX */
-#define GEM_TX1519CNT     (0x00000130/4) /* Error-free larger than 1519 TX */
-#define GEM_TXURUNCNT     (0x00000134/4) /* TX under run error counter */
-#define GEM_SINGLECOLLCNT (0x00000138/4) /* Single Collision Frames */
-#define GEM_MULTCOLLCNT   (0x0000013C/4) /* Multiple Collision Frames */
-#define GEM_EXCESSCOLLCNT (0x00000140/4) /* Excessive Collision Frames */
-#define GEM_LATECOLLCNT   (0x00000144/4) /* Late Collision Frames */
-#define GEM_DEFERTXCNT    (0x00000148/4) /* Deferred Transmission Frames */
-#define GEM_CSENSECNT     (0x0000014C/4) /* Carrier Sense Error Counter */
-#define GEM_OCTRXLO       (0x00000150/4) /* Octects Received register Low */
-#define GEM_OCTRXHI       (0x00000154/4) /* Octects Received register High */
-#define GEM_RXCNT         (0x00000158/4) /* Error-free Frames Received */
-#define GEM_RXBROADCNT    (0x0000015C/4) /* Error-free Broadcast Frames RX */
-#define GEM_RXMULTICNT    (0x00000160/4) /* Error-free Multicast Frames RX */
-#define GEM_RXPAUSECNT    (0x00000164/4) /* Pause Frames Received Counter */
-#define GEM_RX64CNT       (0x00000168/4) /* Error-free 64 byte Frames RX */
-#define GEM_RX65CNT       (0x0000016C/4) /* Error-free 65-127B Frames RX */
-#define GEM_RX128CNT      (0x00000170/4) /* Error-free 128-255B Frames RX */
-#define GEM_RX256CNT      (0x00000174/4) /* Error-free 256-512B Frames RX */
-#define GEM_RX512CNT      (0x00000178/4) /* Error-free 512-1023B Frames RX */
-#define GEM_RX1024CNT     (0x0000017C/4) /* Error-free 1024-1518B Frames RX */
-#define GEM_RX1519CNT     (0x00000180/4) /* Error-free 1519-max Frames RX */
-#define GEM_RXUNDERCNT    (0x00000184/4) /* Undersize Frames Received */
-#define GEM_RXOVERCNT     (0x00000188/4) /* Oversize Frames Received */
-#define GEM_RXJABCNT      (0x0000018C/4) /* Jabbers Received Counter */
-#define GEM_RXFCSCNT      (0x00000190/4) /* Frame Check seq. Error Counter */
-#define GEM_RXLENERRCNT   (0x00000194/4) /* Length Field Error Counter */
-#define GEM_RXSYMERRCNT   (0x00000198/4) /* Symbol Error Counter */
-#define GEM_RXALIGNERRCNT (0x0000019C/4) /* Alignment Error Counter */
-#define GEM_RXRSCERRCNT   (0x000001A0/4) /* Receive Resource Error Counter */
-#define GEM_RXORUNCNT     (0x000001A4/4) /* Receive Overrun Counter */
-#define GEM_RXIPCSERRCNT  (0x000001A8/4) /* IP header Checksum Error Counter */
-#define GEM_RXTCPCCNT     (0x000001AC/4) /* TCP Checksum Error Counter */
-#define GEM_RXUDPCCNT     (0x000001B0/4) /* UDP Checksum Error Counter */
-
-#define GEM_1588S         (0x000001D0/4) /* 1588 Timer Seconds */
-#define GEM_1588NS        (0x000001D4/4) /* 1588 Timer Nanoseconds */
-#define GEM_1588ADJ       (0x000001D8/4) /* 1588 Timer Adjust */
-#define GEM_1588INC       (0x000001DC/4) /* 1588 Timer Increment */
-#define GEM_PTPETXS       (0x000001E0/4) /* PTP Event Frame Transmitted (s) */
-#define GEM_PTPETXNS      (0x000001E4/4) /* PTP Event Frame Transmitted (ns) */
-#define GEM_PTPERXS       (0x000001E8/4) /* PTP Event Frame Received (s) */
-#define GEM_PTPERXNS      (0x000001EC/4) /* PTP Event Frame Received (ns) */
-#define GEM_PTPPTXS       (0x000001E0/4) /* PTP Peer Frame Transmitted (s) */
-#define GEM_PTPPTXNS      (0x000001E4/4) /* PTP Peer Frame Transmitted (ns) */
-#define GEM_PTPPRXS       (0x000001E8/4) /* PTP Peer Frame Received (s) */
-#define GEM_PTPPRXNS      (0x000001EC/4) /* PTP Peer Frame Received (ns) */
+#define GEM_NWCTRL        (0x00000000 / 4) /* Network Control reg */
+#define GEM_NWCFG         (0x00000004 / 4) /* Network Config reg */
+#define GEM_NWSTATUS      (0x00000008 / 4) /* Network Status reg */
+#define GEM_USERIO        (0x0000000C / 4) /* User IO reg */
+#define GEM_DMACFG        (0x00000010 / 4) /* DMA Control reg */
+#define GEM_TXSTATUS      (0x00000014 / 4) /* TX Status reg */
+#define GEM_RXQBASE       (0x00000018 / 4) /* RX Q Base address reg */
+#define GEM_TXQBASE       (0x0000001C / 4) /* TX Q Base address reg */
+#define GEM_RXSTATUS      (0x00000020 / 4) /* RX Status reg */
+#define GEM_ISR           (0x00000024 / 4) /* Interrupt Status reg */
+#define GEM_IER           (0x00000028 / 4) /* Interrupt Enable reg */
+#define GEM_IDR           (0x0000002C / 4) /* Interrupt Disable reg */
+#define GEM_IMR           (0x00000030 / 4) /* Interrupt Mask reg */
+#define GEM_PHYMNTNC      (0x00000034 / 4) /* Phy Maintenance reg */
+#define GEM_RXPAUSE       (0x00000038 / 4) /* RX Pause Time reg */
+#define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
+#define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
+#define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
+#define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
+#define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
+#define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
+#define GEM_SPADDR1HI     (0x0000008C / 4) /* Specific addr 1 high reg */
+#define GEM_SPADDR2LO     (0x00000090 / 4) /* Specific addr 2 low reg */
+#define GEM_SPADDR2HI     (0x00000094 / 4) /* Specific addr 2 high reg */
+#define GEM_SPADDR3LO     (0x00000098 / 4) /* Specific addr 3 low reg */
+#define GEM_SPADDR3HI     (0x0000009C / 4) /* Specific addr 3 high reg */
+#define GEM_SPADDR4LO     (0x000000A0 / 4) /* Specific addr 4 low reg */
+#define GEM_SPADDR4HI     (0x000000A4 / 4) /* Specific addr 4 high reg */
+#define GEM_TIDMATCH1     (0x000000A8 / 4) /* Type ID1 Match reg */
+#define GEM_TIDMATCH2     (0x000000AC / 4) /* Type ID2 Match reg */
+#define GEM_TIDMATCH3     (0x000000B0 / 4) /* Type ID3 Match reg */
+#define GEM_TIDMATCH4     (0x000000B4 / 4) /* Type ID4 Match reg */
+#define GEM_WOLAN         (0x000000B8 / 4) /* Wake on LAN reg */
+#define GEM_IPGSTRETCH    (0x000000BC / 4) /* IPG Stretch reg */
+#define GEM_SVLAN         (0x000000C0 / 4) /* Stacked VLAN reg */
+#define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
+#define GEM_OCTTXLO       (0x00000100 / 4) /* Octects transmitted Low reg */
+#define GEM_OCTTXHI       (0x00000104 / 4) /* Octects transmitted High reg */
+#define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
+#define GEM_TXBCNT        (0x0000010C / 4) /* Error-free Broadcast Frames */
+#define GEM_TXMCNT        (0x00000110 / 4) /* Error-free Multicast Frame */
+#define GEM_TXPAUSECNT    (0x00000114 / 4) /* Pause Frames Transmitted */
+#define GEM_TX64CNT       (0x00000118 / 4) /* Error-free 64 TX */
+#define GEM_TX65CNT       (0x0000011C / 4) /* Error-free 65-127 TX */
+#define GEM_TX128CNT      (0x00000120 / 4) /* Error-free 128-255 TX */
+#define GEM_TX256CNT      (0x00000124 / 4) /* Error-free 256-511 */
+#define GEM_TX512CNT      (0x00000128 / 4) /* Error-free 512-1023 TX */
+#define GEM_TX1024CNT     (0x0000012C / 4) /* Error-free 1024-1518 TX */
+#define GEM_TX1519CNT     (0x00000130 / 4) /* Error-free larger than 1519 TX */
+#define GEM_TXURUNCNT     (0x00000134 / 4) /* TX under run error counter */
+#define GEM_SINGLECOLLCNT (0x00000138 / 4) /* Single Collision Frames */
+#define GEM_MULTCOLLCNT   (0x0000013C / 4) /* Multiple Collision Frames */
+#define GEM_EXCESSCOLLCNT (0x00000140 / 4) /* Excessive Collision Frames */
+#define GEM_LATECOLLCNT   (0x00000144 / 4) /* Late Collision Frames */
+#define GEM_DEFERTXCNT    (0x00000148 / 4) /* Deferred Transmission Frames */
+#define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
+#define GEM_OCTRXLO       (0x00000150 / 4) /* Octects Received register Low */
+#define GEM_OCTRXHI       (0x00000154 / 4) /* Octects Received register High */
+#define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
+#define GEM_RXBROADCNT    (0x0000015C / 4) /* Error-free Broadcast Frames RX */
+#define GEM_RXMULTICNT    (0x00000160 / 4) /* Error-free Multicast Frames RX */
+#define GEM_RXPAUSECNT    (0x00000164 / 4) /* Pause Frames Received Counter */
+#define GEM_RX64CNT       (0x00000168 / 4) /* Error-free 64 byte Frames RX */
+#define GEM_RX65CNT       (0x0000016C / 4) /* Error-free 65-127B Frames RX */
+#define GEM_RX128CNT      (0x00000170 / 4) /* Error-free 128-255B Frames RX */
+#define GEM_RX256CNT      (0x00000174 / 4) /* Error-free 256-512B Frames RX */
+#define GEM_RX512CNT      (0x00000178 / 4) /* Error-free 512-1023B Frames RX */
+#define GEM_RX1024CNT     (0x0000017C / 4) /* Error-free 1024-1518B Frames RX */
+#define GEM_RX1519CNT     (0x00000180 / 4) /* Error-free 1519-max Frames RX */
+#define GEM_RXUNDERCNT    (0x00000184 / 4) /* Undersize Frames Received */
+#define GEM_RXOVERCNT     (0x00000188 / 4) /* Oversize Frames Received */
+#define GEM_RXJABCNT      (0x0000018C / 4) /* Jabbers Received Counter */
+#define GEM_RXFCSCNT      (0x00000190 / 4) /* Frame Check seq. Error Counter */
+#define GEM_RXLENERRCNT   (0x00000194 / 4) /* Length Field Error Counter */
+#define GEM_RXSYMERRCNT   (0x00000198 / 4) /* Symbol Error Counter */
+#define GEM_RXALIGNERRCNT (0x0000019C / 4) /* Alignment Error Counter */
+#define GEM_RXRSCERRCNT   (0x000001A0 / 4) /* Receive Resource Error Counter */
+#define GEM_RXORUNCNT     (0x000001A4 / 4) /* Receive Overrun Counter */
+#define GEM_RXIPCSERRCNT  (0x000001A8 / 4) /* IP header Checksum Err Counter */
+#define GEM_RXTCPCCNT     (0x000001AC / 4) /* TCP Checksum Error Counter */
+#define GEM_RXUDPCCNT     (0x000001B0 / 4) /* UDP Checksum Error Counter */
+
+#define GEM_1588S         (0x000001D0 / 4) /* 1588 Timer Seconds */
+#define GEM_1588NS        (0x000001D4 / 4) /* 1588 Timer Nanoseconds */
+#define GEM_1588ADJ       (0x000001D8 / 4) /* 1588 Timer Adjust */
+#define GEM_1588INC       (0x000001DC / 4) /* 1588 Timer Increment */
+#define GEM_PTPETXS       (0x000001E0 / 4) /* PTP Event Frame Transmitted (s) */
+#define GEM_PTPETXNS      (0x000001E4 / 4) /*
+                                            * PTP Event Frame Transmitted (ns)
+                                            */
+#define GEM_PTPERXS       (0x000001E8 / 4) /* PTP Event Frame Received (s) */
+#define GEM_PTPERXNS      (0x000001EC / 4) /* PTP Event Frame Received (ns) */
+#define GEM_PTPPTXS       (0x000001E0 / 4) /* PTP Peer Frame Transmitted (s) */
+#define GEM_PTPPTXNS      (0x000001E4 / 4) /* PTP Peer Frame Transmitted (ns) */
+#define GEM_PTPPRXS       (0x000001E8 / 4) /* PTP Peer Frame Received (s) */
+#define GEM_PTPPRXNS      (0x000001EC / 4) /* PTP Peer Frame Received (ns) */
 
 /* Design Configuration Registers */
-#define GEM_DESCONF       (0x00000280/4)
-#define GEM_DESCONF2      (0x00000284/4)
-#define GEM_DESCONF3      (0x00000288/4)
-#define GEM_DESCONF4      (0x0000028C/4)
-#define GEM_DESCONF5      (0x00000290/4)
-#define GEM_DESCONF6      (0x00000294/4)
+#define GEM_DESCONF       (0x00000280 / 4)
+#define GEM_DESCONF2      (0x00000284 / 4)
+#define GEM_DESCONF3      (0x00000288 / 4)
+#define GEM_DESCONF4      (0x0000028C / 4)
+#define GEM_DESCONF5      (0x00000290 / 4)
+#define GEM_DESCONF6      (0x00000294 / 4)
 #define GEM_DESCONF6_64B_MASK (1U << 23)
-#define GEM_DESCONF7      (0x00000298/4)
+#define GEM_DESCONF7      (0x00000298 / 4)
 
 #define GEM_INT_Q1_STATUS               (0x00000400 / 4)
 #define GEM_INT_Q1_MASK                 (0x00000640 / 4)
-- 
2.7.4


