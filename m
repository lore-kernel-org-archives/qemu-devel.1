Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D81C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E0B206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JLWVKyR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E0B206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWo6-0005rK-DM
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSY-0001WQ-J3; Tue, 12 May 2020 11:04:42 -0400
Received: from mail-co1nam11on2089.outbound.protection.outlook.com
 ([40.107.220.89]:24289 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSX-0002gZ-4m; Tue, 12 May 2020 11:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSNUrsdl08kQ+d83y7pzju7CrLIbm2QWLJy4FAva0/8cTFmOIagGk7S6xVGO8TadEJgd5DJdnF6SbutpFaXQL+sztRPnVbea6x3GdN1PEeFVPzy9rSy3lziguguQFI3hImXCv7WwCGd8nODm2Eu41FomyWIwK+RNOZtc2roI6yTNDk6qFW7+YSWbP6+yg1ZOls2FSblTpPve3D/CEZibFQ+meZnCwYT0YE2XDmzmj/0QXNkz7pN/YxHrD9QMwFl0Pzi3UPW6mktJxqQBYa6WiITjhNFsWsT9tugw7hQgggIf8hIoUMPITVuqnovV40h4yOuW1GtRzBQnQuWUsnBp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnC3G1iYLJc1lfSHi6nV47xp0nfJ5dHDU3wj+tt+JB0=;
 b=Be2qv38fpEV8iXmniWyx1xUhsL75do4LhkbZzJTNjT3xwEuGc8wc/PAx/L6EIli9jiaoB8MBksvcXzdcbKg6pqCySwFIhWQd4GaDkH0KMHQDPlnmvIi30ryoaQtDSBvJ8HURnHW4SXsUpwnlDXDJepnqc0GWF2vxR7nZaBW1a/MrMPuFkSIEN8M7cXNgmOMVOPhQYOepQMI2wF/35yKw0Wiy8dJANf1K35XODFtK5Y8FNtWYaUNIkmLlOE0wYFfj4cwY8w18ezYo+qJ8jMZbLsTZBzl7FDMMFvmPy8HgZqLHe6Sn/5eZK37pWw/jVrt4IPSDH8aBPfDvQOuttT07Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnC3G1iYLJc1lfSHi6nV47xp0nfJ5dHDU3wj+tt+JB0=;
 b=JLWVKyR5GmeDxKKnpe1Gjz2yEsK3jDKz3jozmgfYrg42Khh0Ith72LDunj7wxnpTeDmfjqqWxqMXgPaaIMjidU8A/fbKkQcoCoXzXkPcFgtLLLfERp5nxoUNKw1zZeak7FNg08r108I7ATJ6SOEbbbAmDdgzRMiaLIggnbJo9YU=
Received: from BL0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:207:3d::22)
 by BYAPR02MB5701.namprd02.prod.outlook.com (2603:10b6:a03:97::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 15:04:35 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::92) by BL0PR02CA0045.outlook.office365.com
 (2603:10b6:207:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:35
 +0000
Received: from [149.199.38.66] (port=48869 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSA-00045s-Ek; Tue, 12 May 2020 08:04:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003oh-PV; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003oE-Pi; Tue, 12 May 2020 08:04:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 668B613C0185; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 10/12] net: cadence_gem: Update the reset value for
 interrupt mask register
Date: Tue, 12 May 2020 20:24:52 +0530
Message-Id: <1589295294-26466-11-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(376002)(136003)(346002)(39860400002)(396003)(46966005)(33430700001)(4326008)(356005)(6666004)(82310400002)(478600001)(36756003)(81166007)(47076004)(8936002)(4744005)(186003)(110136005)(70206006)(70586007)(2616005)(26005)(5660300002)(8676002)(2906002)(426003)(33440700001)(82740400003)(336012)(42186006)(6266002)(316002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a2c9855-ff21-4060-6eec-08d7f685c890
X-MS-TrafficTypeDiagnostic: BYAPR02MB5701:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5701EBFC482368915456EFFACABE0@BYAPR02MB5701.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsIWKQLZaob/KvNsk87e5u0KGuNy3/bzHD6YQIpP4fmrIs0te5vg2SvgJBKocuTVeIxdPQKlYagEJD8ZyQztiGqGeM3z81aomr9x54tluWx7Wgc/r5hNKIZ87h5hliKVSo4ir++0YkvDjCZyO99y7flaZX6qU+AVcWdHplSMQNqxHKkc9ho1Moz6t/fEG+62Xtp9r2wuWl0VZipSkBFhNzhpegaQy5Ts6HLmu3eOMp6g+h+SQeASz3w1WDhZxh/qUhgR/fAQAJC3mzXpa5tqffbptYbza356UMvR9/EY96T9VzDLrdxF2OIFvuL2YHyFv06B7JJXNYLQyr74LPsbHPbRtR29IhlFnK2BnO8/ciBMSfzxGg2XpxXmg/9VPlHfOCYFzYsZ6pdg24l24wjVQe9Sju50OwDTkCCd/IquqD54LIcOmzJ5yIRAkSGtVBoi6EkRMN7TbznK7idrd4D1g4EfVUrOMzKqLYNNrX23+YdYqG1STRh6+zayLFKriG3bmvkshyb6Y5NTQm3zmFkrq6RW1Dr8LB8VTsZnmnfi4vcEkdejXa1loFuZH9SVUrvukIgrYAIANoyesyRVl/f2mA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:35.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2c9855-ff21-4060-6eec-08d7f685c890
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5701
Received-SPF: pass client-ip=40.107.220.89; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:39
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
index 3e7b32f..ddb8938 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1375,6 +1375,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
     s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
-- 
2.7.4


