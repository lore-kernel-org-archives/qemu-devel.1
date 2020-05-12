Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03DCC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF9D206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="J2j6tPFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF9D206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUw8-00033q-No
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnw-0007Y7-3q; Tue, 12 May 2020 09:18:40 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com
 ([40.107.243.72]:6190 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnu-00020b-Td; Tue, 12 May 2020 09:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQhezXpYw9Tu8gSjHXu27ClNN9lU7NNTnAIcT2cgWDBN5aW7WCr9fJY07kseNT2otabU4XBsOIbLH4Ivh1Lbws1nT/2a2TI+7fnNvi6oFfEIGCr7K/euADHXySsnSGkZQS34paEG/5CfRwjrQyNsYV0Nrb15T9xBSJgp27ZzvsH12eghiBZkLPdlRF6hb0YTb5FbJLZ/z0d1x3xpsHx19/kHX/gggsgjAR9RntrCkW21RaHGTffYXMEIIi7ty/degYOGLTQNwy+Ie3t4mkPRY33nwM+plhU2Ks5mp1EfVU0Q7gOzJMlzyQdQ2Vd7cr4lEq5Sk4+L4P4hurzoh6iBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiCAYYWSKAdgAGxBCh2o5jla2c/4m9/c42RLwzsMhUQ=;
 b=jCeSFyVTW5tV7lQ8SabjOlGjJEuT3I41HduljR67YlaQYq+xS+0StqkXO6inUhQL3sRkEQVSmkD12q+r7FFHiwQz08T6n6DZ3p8K/M65mOmrT9ZwGiuobwNVoL275GtMluPl9PgS0MOJ7wQjjUSjd6pYkr/oGPkDxNra4MatA5IV6OCdMuNYwnukSCvSYR9bR5K+PowxNMTDdGZrVLT4TnCqVlzpu2V2oexXInbuIDxSniPXpz2RKVcLo/8HnFZ4w3faGzPXZY6G5mibwz09HkT7jYosLmeNXE83dEuVDXCKlbQ+K661Sh1xpJLwYDwcBCFNejbQJGoWkdvm+84QlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiCAYYWSKAdgAGxBCh2o5jla2c/4m9/c42RLwzsMhUQ=;
 b=J2j6tPFMfDGxyDsHk3pTIviyrvWzeDMBouwoEj9OGn+UP/2qV5lVJEnuGrGIeLWKLHVSE2d5GrzrY/4AGKrb39MsgOLKGeA9WqVu/HR+5Furuen5HbitoYEfpUI8m42Z/ZLa7TEzMPQU10XVmGjZqPdaEtBcJS1mENzt8Po9CnA=
Received: from DM5PR18CA0060.namprd18.prod.outlook.com (2603:10b6:3:22::22) by
 MW2PR02MB3692.namprd02.prod.outlook.com (2603:10b6:907:e::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Tue, 12 May 2020 13:18:36 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::fd) by DM5PR18CA0060.outlook.office365.com
 (2603:10b6:3:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Tue, 12 May 2020 13:18:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:35
 +0000
Received: from [149.199.38.66] (port=47738 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUna-0002Qp-QG; Tue, 12 May 2020 06:18:18 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnr-0005Zw-1Y; Tue, 12 May 2020 06:18:35 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIYv7028685; 
 Tue, 12 May 2020 06:18:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnp-0005Yh-Oe; Tue, 12 May 2020 06:18:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C785613C0168; Tue, 12 May 2020 18:40:30 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 11/12] net: cadence_gem: TX_LAST bit should be set by guest
Date: Tue, 12 May 2020 18:40:06 +0530
Message-Id: <1589289007-23629-12-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(39860400002)(346002)(376002)(136003)(396003)(46966005)(33430700001)(81166007)(26005)(6266002)(33440700001)(4326008)(2906002)(186003)(6666004)(478600001)(2616005)(110136005)(42186006)(8676002)(426003)(47076004)(316002)(5660300002)(356005)(8936002)(70206006)(82740400003)(36756003)(82310400002)(70586007)(336012);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ea89f56-5ce1-4e1b-6c66-08d7f676f9ca
X-MS-TrafficTypeDiagnostic: MW2PR02MB3692:
X-Microsoft-Antispam-PRVS: <MW2PR02MB36920100C2C40D28B74FB278CABE0@MW2PR02MB3692.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wW7piYRJKerenFDPuNYBXCNGXUsfUygD3jteIZyUzhsL794x+EdifHxwa/YMmjgxLQuS+iKuxifKObd1fDgTdm6kIyJ3Ez8GitfKcv5z4K3iTCK0pE887cSCSZwoKHon7XvQmxiRx8BYrfBBtUGqVQcHwmJqAQo0+FLNOly4u0ZKGRRwloodG1EaaL3bbKvKtjN1oe2UTRFrCfmKyq51dAQLKkUqjox0diek7Bkaf2D6NQXSAnmCDOeW8h2ZeKNI0oovwJWc9SAut29YSYqSRJe6eMIm3GvKLzkDnM7E8UapQlfgSEOKxCCOB8KSTyL9NI7q/d1+cKB5QtKheTRoYqQzN7SZ4IonbiFn3Dqz6x3xd9zQR8SbDvWtUtxamPykd9KPmCxnk2jCj5qvq/hvNBGHolxDGlvnzBH1169drcmW97jrsugejlt48r3wioFFVTdivT8F6HaYArqN+LzhaMU2ZvKLTLLJJjy2ZHoGvwxStkWzamqPCilh/3FiNX+zTez6AwISnJaUABsWRdl9orRPo7W3hm73oOfRiqL1LGQ8UielGoDFehVGaZj8+X3lOf3AWxc6/vdkUWHSPC4rA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:35.3441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea89f56-5ce1-4e1b-6c66-08d7f676f9ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3692
Received-SPF: pass client-ip=40.107.243.72; envelope-from=saipava@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:37
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

TX_LAST bit should not be set by hardware, its set by guest to inform
the last bd of the frame.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 1b2e31d..00fe5d7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -350,11 +350,6 @@ static inline unsigned tx_desc_get_last(uint32_t *desc)
     return (desc[1] & DESC_1_TX_LAST) ? 1 : 0;
 }
 
-static inline void tx_desc_set_last(uint32_t *desc)
-{
-    desc[1] |= DESC_1_TX_LAST;
-}
-
 static inline unsigned tx_desc_get_length(uint32_t *desc)
 {
     return desc[1] & DESC_1_LENGTH;
@@ -1293,7 +1288,6 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-                tx_desc_set_last(desc);
 
                 if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
                     packet_desc_addr = s->regs[GEM_TBQPH];
-- 
2.7.4


