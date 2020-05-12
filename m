Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B507C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D72206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="peP/6b30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D72206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUtO-0006xn-Av
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnw-0007ZN-L4; Tue, 12 May 2020 09:18:40 -0400
Received: from mail-eopbgr760052.outbound.protection.outlook.com
 ([40.107.76.52]:41286 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnv-00020f-71; Tue, 12 May 2020 09:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX19zkeNLZYum6Hx1tXVen0pHkEJKhRWcaahKClYAPw5QwMlXC/w9xpmLHwuz6TALGmEsif001cSKKwsxVzrEnBv+BaNkYotH5Toyqp/ABXNiC2ktf7IVzZUundG2l8uyZ4WXMCIm6UgyKvgW/ymlHuizENX/E5mbDiHcSPresRY5kK0JPRiBE8i+YKbHmccDX8TtNm5f+LVgw1bij1uO+6KtkIwibw7EWizrW6opwiy2wGt4xfs1TmPBg8wiQrJs62V+itHjymkQ9TzvwsPqLsgr4IkMvuzET+ZE9EkS7zrslz0yvSHAYLgVyS4pkwLNPslKezZJi/+Y4uNBc22CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM3L9vIT53CsI7LryR5moDnPHpoe37dlZRZ8NoCe+og=;
 b=DLzXsA/t7iLSEKNVLiKGhllQJQeGN/JOv8AatbzeBYGin8ouesr3VP+g0l/UEUWjw1zUNbe+j8kZmepzykTlh3TF7GJS2L9rDRITDsIAEAJeIV9RfJgaL8o3Gg4Ebi6yho2EiIdcLeQbNJ3yiADVjEi+PkkGsIgdCCnlz812wuzcAQU3d8KJgU7lVpSOFaWiv/UMZBNKw5jO8RTod9q+9k5wItxwx8LG1XX0fhTy9hANrD2RJg8P8hYqGzlnOHJH3QvPNPYNyS3Yjqizj7oUrA9PZ5E97NQ/qdCY4cWC3KwfiREQ0h+/St46bSq0xSEIYX64L8HVKvC3k27NtkvdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM3L9vIT53CsI7LryR5moDnPHpoe37dlZRZ8NoCe+og=;
 b=peP/6b307GycH627A/5R7JKPDC9NPZFyI/TFRQrPryFDy8vv1NqfkAvR03D0as5BakYXwh5DqLGFc87kpk8aJ7gxdL7ddj8gAOfmJ+BEGzL4OFRNBRXj7/gFB+QCMa4pVdLK8LgaU1Bo2ZdGZQnyoK71uX3x5GrWtuFrcAV+dGw=
Received: from SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) by BYAPR02MB5352.namprd02.prod.outlook.com
 (2603:10b6:a03:63::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 13:18:36 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::7a) by SN6PR2101CA0013.outlook.office365.com
 (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2 via Frontend
 Transport; Tue, 12 May 2020 13:18:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:36
 +0000
Received: from [149.199.38.66] (port=47733 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUna-0002Qm-K5; Tue, 12 May 2020 06:18:18 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnq-0005Zu-Rn; Tue, 12 May 2020 06:18:34 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIXXw016854; 
 Tue, 12 May 2020 06:18:33 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnp-0005ZZ-Ec; Tue, 12 May 2020 06:18:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 1651713C0175; Tue, 12 May 2020 18:40:30 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 10/12] net: cadence_gem: Update the reset value for
 interrupt mask register
Date: Tue, 12 May 2020 18:40:05 +0530
Message-Id: <1589289007-23629-11-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(136003)(346002)(39860400002)(396003)(376002)(46966005)(33430700001)(82740400003)(6666004)(2616005)(33440700001)(8676002)(70586007)(336012)(82310400002)(5660300002)(36756003)(8936002)(81166007)(70206006)(47076004)(2906002)(478600001)(426003)(356005)(42186006)(6266002)(186003)(4744005)(4326008)(110136005)(316002)(26005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b5f651a-8a0d-4414-4e7e-08d7f676fa39
X-MS-TrafficTypeDiagnostic: BYAPR02MB5352:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5352A9D807A6C10A619E631CCABE0@BYAPR02MB5352.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E84SPnocAiLNuEXi9/UgxpSsVXttnHRUkcJ598p22BSKzhX+cwDhLlkRMjsAPVO6sOFXsFnUz3p2yU3OuwuzqCr5OAQYgMucd7YkpVoLuGww8hZ6mLAcU6M2yZgjzq7ukXWflHy+Lpm7Gm43Gg/goi4yCg91nfiqx+RnNhd3T6hv4o5pNCw0JZ5tSsJDIPZok8UoJB3TzQfNF+muLs7aczR94eOaEEy5RqKjy7giCGZfVSHxGh+M0PNRqDQerpWIUKEjmX0XC8vOcP665Ao1EOx8qMdem+avUz8BBTy5h1lHGBfoSqbKj3goEynwLN7rU9VvSQZZP/8lvv7TQ5LvpUe65abQfneQOO+aYTNVtUn4dZadpbfMLm3k9NKBICed0L+K29Oto8bcv5Xt+whvTsMFHdlFTDSO/mliG5OF4LA5qrw+QREYMdnwi6MDBSyQblhHQKRBd/usHFbSWuz3EMtqdLdIhsDVKmsjnIONnGevrMWbh8P9hblPbcTzISNdMXCKZcflsp372nSFWuOJuTb9ar2iysgL9LNHK5hzeqIMg23y3iy3f5OGFZb4HDD3S9TaAaJKwxTe7Tip7LkoQQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:36.0678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5f651a-8a0d-4414-4e7e-08d7f676fa39
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5352
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

Mask all interrupt on reset.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 423b47a..1b2e31d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1370,6 +1370,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
     s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
 
     if (s->num_priority_queues > 1) {
-- 
2.7.4


