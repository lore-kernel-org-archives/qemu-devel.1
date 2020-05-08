Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A1C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849ED208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dbupSTAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849ED208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0vg-00057H-Mf
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sB-0007cO-5k; Fri, 08 May 2020 07:08:55 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com
 ([40.107.92.89]:35520 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sA-000259-63; Fri, 08 May 2020 07:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoT1hfpMlDhvW/3CVCm8LmD4oGwj+reE0pfh8Z1fCnWYaQx7AICf7MSQq7fio5qQYt4tA0hFFifXz3CDeT5fsVoQMjw9gT3IuBxjQoj3UwgB0PSLb6d2rDmdvnpcsIsysdVC9vZKLUeSXdA1IvwsLb01ogQFBg+hOcyZ5ntikMCnGiJe1HNCI+LboLrgWDK4KDPpUcn5iFQIYX0D07+R1yvWyqdKqw/eRZh2mq7H5HKEebYQOQAzTKzWyaf/YnypFIA0ZlS8lpQPTQAg7VcReo076Az/sOdqxIgooogbufE38QMOzfc3Og/w70320sBTQCM+jENuF9wEmiBMvSzPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLOYenqEtuGgmrBcfmMAAzSvT4SGfW2/NxjXbQv1+Kk=;
 b=PE9QNwfeYOWdcU15LNkmAt2u5qNhQIt1dJ7n8TWtG1A3rMU8PxOjXwiqxfjlyJ/FCgc54z2iTgwv2arRbomsMHemAprRSs9cInppxutIZWf4ChbHDby0s+Wo3WyQdW/6P96FebdapFa1peRS6+F+ZiPAbYarR2aEuktbB2e9egX85mtW9LF+zTty9nFIstNmAvZnbqFfjlwYq082nCA3VVieHKQGeGn5LgsF4lCSU7tamLI/NKVoCMt6+2xGOt819sWpuu0+nT6zgQUpBt6PU7Mb8waj0cO1V2TsuBaRiyx9nSufLDT9DYCcqniGXgR9BmLAUO+M9h0kEw6OsIABzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLOYenqEtuGgmrBcfmMAAzSvT4SGfW2/NxjXbQv1+Kk=;
 b=dbupSTAZ31nZIgqJF8PajjRG9xAHIRIcQ3FtpZhHO/G078PgCt23yqA/QM0tFFT4vX3m/Je3APHqXEDEqVkxa5/DhqyLz/nNs8gBZUZCl+k0tVBNvlhUiBlMqJ90htd+0G6AxVL0B+rKVgJhDrOkKEqYCVwXp1m1HxCk5nB9WzE=
Received: from MN2PR02CA0004.namprd02.prod.outlook.com (2603:10b6:208:fc::17)
 by MN2PR02MB5789.namprd02.prod.outlook.com (2603:10b6:208:11e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Fri, 8 May
 2020 11:08:51 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::9b) by MN2PR02CA0004.outlook.office365.com
 (2603:10b6:208:fc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Fri, 8 May 2020 11:08:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:50
 +0000
Received: from [149.199.38.66] (port=35938 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0rv-0002Tu-Ls; Fri, 08 May 2020 04:08:39 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s6-0005cO-FF; Fri, 08 May 2020 04:08:50 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8nDZ021206; 
 Fri, 8 May 2020 04:08:49 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0s5-0005bV-4O; Fri, 08 May 2020 04:08:49 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 1723313C03F7; Fri,  8 May 2020 16:30:57 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 05/11] net: cadence_gem: Set ISR according to queue in use
Date: Fri,  8 May 2020 16:30:39 +0530
Message-Id: <1588935645-20351-6-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(33430700001)(81166007)(33440700001)(356005)(6666004)(2906002)(70206006)(42186006)(316002)(26005)(82310400002)(70586007)(336012)(110136005)(47076004)(82740400003)(5660300002)(2616005)(6266002)(36756003)(426003)(186003)(4326008)(8936002)(8676002)(478600001);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3fad829-dbfe-4d17-86a5-08d7f340303b
X-MS-TrafficTypeDiagnostic: MN2PR02MB5789:
X-Microsoft-Antispam-PRVS: <MN2PR02MB5789B75ED2C23477F6EEFE37CAA20@MN2PR02MB5789.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CZ5FghUr0Z5qGxOnYHeWcayCPXDipba6dlNy138O8PCNgb6G5BcRDTuQKPGY9OgwMOLqSWwararCWE97fWY5GUqnzaWW2cizLn+9pB5kHvxrdQlXoqbgcRJjYcS9B50yQ5sOfAUXRl0JkbfGS5sgqYLf1JCJWxox5HOAyCb3VObDAQBwqWGCD26J/+XD0Af3Hm3agOftJl2StEL6lgHpqjv0vmXIW7/UI4Twon0vFMGRtpeoARsRKIwDAZj/macO2r0du71dV+ikrlNo0xwmaPNFrfotESKczY8LjFqL2uZt7Ci6Jw397+WtFTVqXlwbEV8uyQSnPV0Aa9NvJVD5U/ic+m52NuLU7ZEQ1/CDfooEc0mvlE8nbrSKCWB6E6UclzZwM6lP1fzCGS9VyvRJw+vuSykWOmCQxFNJbM0r7+GJsdD7tYjtw80s9zrzOGkJWO5YjBMbtzNfoPqwq85TnKkOikcpeu+jHdMyrjsy/8BDXxetYDUWIvmHrpKqLHwkQfqpdbxh+pWuIMQSI8mgebxBcie/cAuTYd1J8Di7qJCFCDiPGXSMHtrRpjXaqn4KluTpkSWRPTlw7VS3yeTcw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:50.8748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fad829-dbfe-4d17-86a5-08d7f340303b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5789
Received-SPF: pass client-ip=40.107.92.89; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:53
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
index 74ef447..77a0588 100644
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


