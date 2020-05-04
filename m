Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E08A20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qeubX+2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E08A20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbxB-0007zm-Oj
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrT-0007Fd-Hc; Mon, 04 May 2020 10:14:23 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com
 ([40.107.220.42]:6168 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrS-0005fA-Ki; Mon, 04 May 2020 10:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXdTvabhVC5hHhHNyTk5VpPHgb1HuiH10bV76ExHo74fvwpL+xDbTjOHjXT9FYVh6UziWJ3kLa2SsPnMrLKTSDk2T283aYwOE2nwCaZ6Denk5AAlUFn4GXWhaq7pm1sDKptCmuhABmqrGLfyT7GVUpzWEU+nVURL9q+Fq/ia6OxYAD78HheSa/iKKT50eFOy+ksZTVk7Tdz/uxafaE0KvEKZK3h35ZcyTGuIaPbfMamBRjKoN1g92WlCNnYQhJ83BmD7TruFWn5qqA3HxLKWRIkKJpcdOMmfr2qLsbdgts3sZNOVI6015rlOR0/VvZt/w9hJy/3SqfipTIP/kFYpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGx+SxXbXZIAxhdl9mfewkcW+atilS8t+n5VksQTe54=;
 b=MKN9GCvYWGF2bMMW0Et74tBrk4WrzI++h8fUzrV6lNe34oUv/uzeNN/8N/wlacCfoNmndsbhLOpTKSabIbOej66ASxycgrC9981kcjxgOEMqN1rcpVxlyUvDfoqNa5GLQVmKJyNDuxAXuB7S0G0AtSvA1aNQTuzVes/x2JVuEEqW9lQ9USHTm2ZplEAPRy5vR4aEUf/YnPlRiDSs3p4f54t5e6ANi97vIEJFbNJyfwhwILK/I4EYof9TKmrcRv3kf6DHD5zMXAqGJLdwbPO9JXP1XBV2RWiJmeySmo6WEY3GaLJXX2NwxIRUr6kaTtjE6oxYZfzTguPNUcTwoCJ4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGx+SxXbXZIAxhdl9mfewkcW+atilS8t+n5VksQTe54=;
 b=qeubX+2Y7hU9dXh+Ga9wXzlpiCd9QU/az0c0W7lFMNvp0fqsaEmM/92hy3vIasU1qHrCSe/F+8bW0gG/S4UjJHk8uFEY0Mg3nEUA1d+/yjduZNSll0lnhpfO6XsbOJQ0vw32qwLU3gboHBv6w3R4qD35bXIhzycqpsdrMOhqszQ=
Received: from SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) by BN7PR02MB5201.namprd02.prod.outlook.com
 (2603:10b6:408:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Mon, 4 May
 2020 14:14:19 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::98) by SN4PR0501CA0109.outlook.office365.com
 (2603:10b6:803:42::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.16 via Frontend
 Transport; Mon, 4 May 2020 14:14:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:18
 +0000
Received: from [149.199.38.66] (port=43096 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrI-0000H2-QW; Mon, 04 May 2020 07:14:12 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrO-0000x7-FR; Mon, 04 May 2020 07:14:18 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrN-0000wu-PQ; Mon, 04 May 2020 07:14:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 7FB7213C304C; Mon,  4 May 2020 19:36:36 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 09/10] net: cadence_gem: TX_LAST bit should be set by guest
Date: Mon,  4 May 2020 19:36:07 +0530
Message-Id: <1588601168-27576-10-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(46966005)(26005)(4326008)(36756003)(2906002)(82310400002)(356005)(81166007)(47076004)(2616005)(426003)(498600001)(186003)(5660300002)(70586007)(4744005)(70206006)(336012)(6666004)(42186006)(110136005)(8936002)(8676002)(6266002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00232cb5-2f1f-4493-add3-08d7f0356f58
X-MS-TrafficTypeDiagnostic: BN7PR02MB5201:
X-Microsoft-Antispam-PRVS: <BN7PR02MB520175D233CEB4348CF2B25CCAA60@BN7PR02MB5201.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOslS5waQLZtN8USdiikpWnQceMoD3qgA8CITmb2W48BJ5v9di1ca8kR+GefX1Z3+NI5t6m6ENY2BsDX0VPvOomZS734n1g/dpuRb8XgqNM3tSfxvMwiMNNxXdzA6lh6a6yk/Lj6Lxs0/7SxD90PchIhStBVxW7vr+Y4YdXNN7J1YaqqLfOibZiAe1v6ckjN0TcFq0QbGjiUW4u1rn7+EJST7J3nwBDIE8Gt84lvEyJ9uYSxMD/dap7umT3uczuutdKV182Wy1h/lSHwQN3yMpTkn9q4H4lAkEv1TxTbudMll5iVHHkfvNqfPrBTfJMkogkhiok5XfpuCwAW7xaR3ZknkabfNFnosKBvyiMRCew3Y5lkiBcgwBrmVUpyzRjdB1PZPJ2LR3De/18B0D7DVjfyRjVvRvWbYEVHQTQgLDdclN+RUpPgMutIOA9Gh9UUNdm1vhE18YcE2zBq2f//8+2Tb0u9s7Rfw7gEOGfrxMeAZMk1LUoccjBkvGhSUiTipBm3OYaGctP6R9pei/gutQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:18.8090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00232cb5-2f1f-4493-add3-08d7f0356f58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5201
Received-SPF: pass client-ip=40.107.220.42; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:20
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
---
 hw/net/cadence_gem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ac3a553..f0bf2e7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -345,11 +345,6 @@ static inline unsigned tx_desc_get_last(uint32_t *desc)
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
@@ -1270,7 +1265,6 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-                tx_desc_set_last(desc);
 
                 if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
                     packet_desc_addr = s->regs[GEM_TBQPH];
-- 
2.7.4


