Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3C9C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA64206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gJqmh8zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA64206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUsW-0005QF-As
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnt-0007TX-2W; Tue, 12 May 2020 09:18:37 -0400
Received: from mail-eopbgr760052.outbound.protection.outlook.com
 ([40.107.76.52]:49603 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnr-0001zP-Ht; Tue, 12 May 2020 09:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aaj7qqvTK9u4piXC7q6SLmosLDlmp6cH8Tg43QRZ2nXMNrhGp0JqXl0z0vg6A18Ri51LWNbVaW/kDGMeXEYIPdUWAJOLP1mFIP4VNyosgmaz3F/hzH16vPu+sXtODhJAQcXmlNBGecHf2/9dHKbmDns6028IoXWVVroxNjwmGlq1xrD8EuWdpbdPZUJG7QSmantOWhj4RbWPtGanL2LMQ90E0cpE6M/g04A14ZfBMatFSedwkPisGCyucKmi+yuEG3GgejIQ+0Xq6wz+sKQIYe0MGrycwUwtp+3T8X9zU+o65zcadFRESTNBT609zXTEUUQrG901m35r1BAZZ+93qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gmBS/gl8DIe0Nae4lgoBJbrAZ6fMSyNH5h3lK7sZ90=;
 b=RygAKkrtyuf6anrvBrIPveAOHEpPFDQmUyn0GDy0yc26x72HttvQ0t8j3SiutTykf2VX7iSYj8mjXPz6oPMqOR+VgiOeFgbtNrNxVqzBg23QJ3YJD8t00ll9EELXtaZlTBmrRJ3bQjWnUcs1aC6nSPbx6SfxWc0/+1Qigubp/LB02TxQq/sAabyZTDbm4j6kVkj8ecHI5+aQKQz51gO0VCAVZOsj+GfZoK/xQpD2E/prnM4+R/Kiyb83ZKelXDPtaLP86wVsLrpiKogg4WoH4jmEfIwBZpUat+bHFkXrER85yZHtzspbNI4QLCqnuo3h8O865AONwH5gSG5BAih+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gmBS/gl8DIe0Nae4lgoBJbrAZ6fMSyNH5h3lK7sZ90=;
 b=gJqmh8zIZbzto7BlJxJzUcW4fNqKWUbGr79vYFMJkMPLMPzBn6JWOr6scssyvG/x7nkx7fHwUEdCWhC5OmcBg7BbzCvwaKUnVYJTgLozI8CjpPcxE0TdagfuJfVJHhRustZDZ94NjaIxErP3aBT1wm+iKHXgiU+p+Ek6jdrWHps=
Received: from CY4PR21CA0039.namprd21.prod.outlook.com (2603:10b6:903:12b::25)
 by DM6PR02MB4026.namprd02.prod.outlook.com (2603:10b6:5:99::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 13:18:32 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:12b:cafe::9a) by CY4PR21CA0039.outlook.office365.com
 (2603:10b6:903:12b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2 via Frontend
 Transport; Tue, 12 May 2020 13:18:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:31
 +0000
Received: from [149.199.38.66] (port=47661 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnX-0002QU-0K; Tue, 12 May 2020 06:18:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnn-0005ZB-7r; Tue, 12 May 2020 06:18:31 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIUdo016844; 
 Tue, 12 May 2020 06:18:30 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnm-0005Yh-0u; Tue, 12 May 2020 06:18:30 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 1379313C0170; Tue, 12 May 2020 18:40:27 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 05/12] net: cadence_gem: Set ISR according to queue in use
Date: Tue, 12 May 2020 18:40:00 +0530
Message-Id: <1589289007-23629-6-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(136003)(346002)(39860400002)(396003)(376002)(46966005)(33430700001)(2616005)(33440700001)(6666004)(336012)(8676002)(70206006)(70586007)(81166007)(5660300002)(36756003)(8936002)(82310400002)(26005)(47076004)(2906002)(42186006)(82740400003)(4326008)(110136005)(478600001)(186003)(6266002)(316002)(426003)(356005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89418467-c9db-4402-84ac-08d7f676f784
X-MS-TrafficTypeDiagnostic: DM6PR02MB4026:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4026AD2081E760101E71BF19CABE0@DM6PR02MB4026.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyEPC1a8W8FihLi4Wt42xxnuD/xOjtVTzAjJipUGcwNBtRSrMHLSchF0AuT9VUBm5O1s33IEEc1hQILVVs7c8lIToYR9jErt0gBN/bXkFTrl1r3IpgE5cLsDy81D2MIxq/i3A6mPRYk4VKP7/lOR3jN1wg+cAjxdr73YcY2PKxjhdAK/ln50D4tr+EiY8WTHgz5u3MFm8iUBL+l2AycbjlQMVzaoEPcEo3TYGEALcYVkllmgoBzV42ecHl6lYqhtiVjR/1qNxNIoyuzjrGfGvTMBH6xzdIi3xoq2dUTkoJ+Sov2rE8JMj4dOY/pCg0EEoOMhnD9EIaLLIM9VTQ+29meD70gc/w/L2+JOkxwV6JbrYHqMPA8969gHFpfu1XT/45zz0l3LEimWP3u6Kb0PULV2E8SLzmr9wMlBylmsvFdSKxr2Bhl1hVYyJIXKxp9ptUI5q3wc5ssIY2gsliuPbXgRTxRixrak/Nh9NMH3rMn9sX8zKNciGi7sYh/ICy/nz0dys0PmPBAD43fFVpvUphzpOIR0rfD0Shl6RS0SBEL4twVvcTIW5KjypEUUae36KVKtFU9ZNrHNK7vVHNaL6w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:31.5295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89418467-c9db-4402-84ac-08d7f676f784
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4026
Received-SPF: pass client-ip=40.107.76.52; envelope-from=saipava@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:33
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

Set ISR according to queue in use, added interrupt support for
all queues.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 40bfa5b..d3f7166 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -451,6 +451,16 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 /* The broadcast MAC address: 0xFFFFFFFFFFFF */
 static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
+static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
+{
+    if (q == 0) {
+        s->regs[GEM_ISR] |= flag & ~(s->regs[GEM_IMR]);
+    } else {
+        s->regs[GEM_INT_Q1_STATUS + q - 1] |= flag &
+                                      ~(s->regs[GEM_INT_Q1_MASK + q - 1]);
+    }
+}
+
 /*
  * gem_init_register_masks:
  * One time initialization.
@@ -906,7 +916,7 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
         s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
-        s->regs[GEM_ISR] |= GEM_INT_RXUSED & ~(s->regs[GEM_IMR]);
+        gem_set_isr(s, q, GEM_INT_RXUSED);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
@@ -1080,7 +1090,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     gem_receive_updatestats(s, buf, size);
 
     s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
-    s->regs[GEM_ISR] |= GEM_INT_RXCMPL & ~(s->regs[GEM_IMR]);
+    gem_set_isr(s, q, GEM_INT_RXCMPL);
 
     /* Handle interrupt consequences */
     gem_update_int_status(s);
@@ -1231,13 +1241,7 @@ static void gem_transmit(CadenceGEMState *s)
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
                 s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
-                s->regs[GEM_ISR] |= GEM_INT_TXCMPL & ~(s->regs[GEM_IMR]);
-
-                /* Update queue interrupt status */
-                if (s->num_priority_queues > 1) {
-                    s->regs[GEM_INT_Q1_STATUS + q] |=
-                            GEM_INT_TXCMPL & ~(s->regs[GEM_INT_Q1_MASK + q]);
-                }
+                gem_set_isr(s, q, GEM_INT_TXCMPL);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
@@ -1287,7 +1291,10 @@ static void gem_transmit(CadenceGEMState *s)
 
         if (tx_desc_get_used(desc)) {
             s->regs[GEM_TXSTATUS] |= GEM_TXSTATUS_USED;
-            s->regs[GEM_ISR] |= GEM_INT_TXUSED & ~(s->regs[GEM_IMR]);
+            /* IRQ TXUSED is defined only for queue 0 */
+            if (q == 0) {
+                gem_set_isr(s, 0, GEM_INT_TXUSED);
+            }
             gem_update_int_status(s);
         }
     }
-- 
2.7.4


