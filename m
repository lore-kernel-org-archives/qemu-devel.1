Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD3C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D5E208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S93Dt74I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D5E208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0tg-0001Wj-GZ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sI-0007ku-4J; Fri, 08 May 2020 07:09:03 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com
 ([40.107.236.55]:6139 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sG-0002Df-7N; Fri, 08 May 2020 07:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDGmlBBUbqX4Tn1qBMCHVpe0At0b9ivzzzNlOw3nsa1D8KO4B2MNRRu7I8sWPs5jgkExa1oLShKi73rHH3eBYtgCitQLB3h3kIuJ7uQgJhSawaCbOcVlfl1hToKV3B+/jp+0vhpsZsOyYnHu4jxe5PVbRZnyTapAIXxZY0BRL8M/kNAB9qs44DdqzIgdB36P/fwPJxAWkxH3D00eWQWBONuvveySId57Zc20E9BPL7uSnKkuxuojG8cNU1EMnHCy47wQdT/IYMCly8401XKzDZGMuSEuyg3eQnjQ5cMj0d3VrOKK6XOmKnf/S+J/+e/rXJskILa0fkCqznKMEF1e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhO7baxXC785Pes0oMdQ65hgslSRme54fITQLtZfb8o=;
 b=PA1wQGHnAEnFJ5PqB9PcTMFYmxC2P/qZ0zKN9MfXjGafKHePKZx2JfFlL1gjw0BfA/Qx+/A3Tk4SHcml3JVlBVbE8xKv+kDDJ8JPMwPMWDxYi2eiCENlcz+KEIYdMdLRHF28dSlYJ37+o3+yE/OLRiPii1KMhs8dybw5eMibhClZJvhi1LYKVNF+rc8lxd0ptiqaUMKp4Ng0zkLZXmLczEk33tH135y291ajPWWJ+//HPcfKGs7vNYwSG5OEihS8hP0rS+F8pFEF32xQox6m9CloEV7ylw7T0l1iSFfwHBKCuiR57hgimHoQioOBxZPV92I2SuiISUMa5s2YMaG65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhO7baxXC785Pes0oMdQ65hgslSRme54fITQLtZfb8o=;
 b=S93Dt74IOKaIm0IwuhBbkCUV+bUN8Fz06UrI2rNBOeJjMkX503w4idshIoIQUaYcE3XaKuK3F3uxs/hMTfy4VizJjcEnQVfu8NT5MU38pEqKGE/X9wqOSSfs77hISgH1PuyrIqNctCG52LM170I2YJhyXcCGlJDpBxae3sqqo+4=
Received: from SN6PR05CA0004.namprd05.prod.outlook.com (2603:10b6:805:de::17)
 by MN2PR02MB6126.namprd02.prod.outlook.com (2603:10b6:208:1be::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 11:08:58 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::c2) by SN6PR05CA0004.outlook.office365.com
 (2603:10b6:805:de::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Fri, 8 May 2020 11:08:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:57
 +0000
Received: from [149.199.38.66] (port=36252 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s2-0002UB-4I; Fri, 08 May 2020 04:08:46 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0sC-0005fv-Tp; Fri, 08 May 2020 04:08:56 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8tOQ017637; 
 Fri, 8 May 2020 04:08:55 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0sB-0005f6-AG; Fri, 08 May 2020 04:08:55 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 41EFB13C03F7; Fri,  8 May 2020 16:31:03 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 09/11] net: cadence_gem: Update the reset value for
 interrupt mask register
Date: Fri,  8 May 2020 16:30:43 +0530
Message-Id: <1588935645-20351-10-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(136003)(396003)(376002)(39860400002)(346002)(46966005)(33430700001)(2906002)(70206006)(36756003)(186003)(110136005)(4326008)(8676002)(81166007)(356005)(6266002)(82740400003)(47076004)(5660300002)(316002)(42186006)(82310400002)(478600001)(4744005)(2616005)(70586007)(33440700001)(26005)(336012)(426003)(6666004)(8936002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa2474bb-2a49-4813-7221-08d7f3403405
X-MS-TrafficTypeDiagnostic: MN2PR02MB6126:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6126205C37B6B5D14A0D5545CAA20@MN2PR02MB6126.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MroVFnJ3XvYbq7ieEgZlUjrVgUXZ6c8Y2llCBmbAuQMmBLSR8j6/mHLy8bjIDi404z4+c1Ok3jnOmu2nEmwZTru4/n3jtoTKM02+zkU7KBd4GqP8HviIhkhLyWNYR7QzMrUuiLw9okvq7Z5GnZnYgeMV2srJI5Z5SbX/qh/Rsoi0nqYsSKjum7iDcKvCzhEKqsQBkTvH/LHMotmSjHBVlgh14MuzkdzwI7EnF0fuvmM3ggsj5R+gfRKDgTS6ubhHddcZAsWYMV7FFg4vFeHtKkM/BFRv3DtkjNckU+zBTMTaZW97twmOSuxzwgMua+cRvN6ynHz5/C3ajc3s/4CaqKCOMBVJD4KofnJsMBc+OTgQr6iuMVEtggDY1U9Ka8bdEGZwZUI5pYQ/IltVdhoVUukaV6o9mszSz7Q3u4sQO7rK0suMR+w8bzPlZTFzN5Iac4Kh/iOvlvJ2kp3yKjre0stkXaJb7HLLGtfqnodUY3I84zhxhR71JTXRDX1EmNPR4ChKGYISMbdKoy0lWdMylk4B2Skm6qbT2yNcvN/NpLd7aGzRJAXN0zYGVPtaMk8jutfssqHUQuyo8BIpw/LkYw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:57.2303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2474bb-2a49-4813-7221-08d7f3403405
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6126
Received-SPF: pass client-ip=40.107.236.55; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:58
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

Mask all interrupt on reset.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 65b29cc..45c7390 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1348,6 +1348,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
     s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
-- 
2.7.4


