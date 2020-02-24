Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC4C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5436C20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FxapW9xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5436C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6AId-0002GT-FZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 04:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j6AHm-0000oS-Q1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j6AHl-0007wv-M5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:22 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com
 ([40.107.244.73]:37856 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j6AHl-0007wG-GI; Mon, 24 Feb 2020 04:44:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHl1k3c86WV+Pbo6xTmN9FKlg0bEbF6VtHiHTzMBCjQlx4zcdvKQBRz9Hn6rCLB2GTq//6uAPUsbT50rZgZXzZp0gOZfSmtL23elyr2gAeOdQQ60TizHBsoK253duKqjL7DeTiphcb8hcWRo1mAVoP/EQEORnVjgoEsCa2llwI/Rl5/zEqHSkLf8py/FDwRFpS6ua85wx9bKGo87UiVjHfFGnXShRCXRDKj5quu6yz24UArzAFC4T9xj/DmmWAzsVoGy1VjRwCnyzZ9Y33Tj8K8e3lllPR66LJ1VB7ELlZx2yD0aUax5CkoR6yt1vm1AvS/SXeuPE35WdPyYFGPOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7KRx2345ZT5T5nvdOVWQlLqLx+WW31JKpvdK/TAyAc=;
 b=iDhA00YgRjco48juyWuL2TDCq4z0CP5b07GvyVODOT5kOfYIV/vxnp48W5sfe6CXP7sJ804ksKhBYSrtEbCywc4OXeRjwSnJmpmGxrU0eU4qZQTvCxj7HXflvojYunexuAysV5UZq3nkw4fmZI95J6y+9Rf7UU1cziitRX1a97OMz23RCbaOoZtTABwXzKgbiWBNHTHkd5PugRYtNMXWoZ0ILmQU5y8cNwl1NEbvNm8MsDrw/agu3zrFVKkUTphVTcJmx0lloAYVI1Z/Kx+1bVcdq7iZZwW/PoZdbDZdpEIwH8i7d082XQ7RFXfEuIOiH2YsARTehVGFFtUtuLjibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7KRx2345ZT5T5nvdOVWQlLqLx+WW31JKpvdK/TAyAc=;
 b=FxapW9xS7sWALS0aG7zm3SeFtUlGzYPFqysKGhQ8BtlypWN93fpNsHS09g+43ICPR4eYigUUJzgCEoOlEFIUyO9pVtyvTfWv4H21R5PAeA8I2ZsvdwM18+zv4ouL803FIRaE6BgZ/P5eHQu6ml0xN74f9DIRr+c9zvoDJgI9LNw=
Received: from BN6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:404:5f::27)
 by BYAPR02MB5941.namprd02.prod.outlook.com (2603:10b6:a03:11c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 09:44:19 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR02CA0041.outlook.office365.com
 (2603:10b6:404:5f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Mon, 24 Feb 2020 09:44:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 09:44:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHh-0003mv-U6; Mon, 24 Feb 2020 01:44:17 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHc-0008Pn-R4; Mon, 24 Feb 2020 01:44:12 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01O9iCpG025463; 
 Mon, 24 Feb 2020 01:44:12 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j6AHb-0008Pd-Pf; Mon, 24 Feb 2020 01:44:12 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5F79E13C0374; Mon, 24 Feb 2020 15:09:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH v3 3/3] cpu/arm11mpcore: Set number of GIC priority bits to 4
Date: Mon, 24 Feb 2020 15:09:24 +0530
Message-Id: <1582537164-764-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(316002)(110136005)(6266002)(8936002)(81156014)(42186006)(2906002)(426003)(36756003)(8676002)(2616005)(336012)(81166006)(478600001)(6666004)(356004)(5660300002)(26005)(70586007)(4326008)(70206006)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB5941; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eccd0ca0-ea91-4f31-448e-08d7b90e1e4c
X-MS-TrafficTypeDiagnostic: BYAPR02MB5941:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5941E887265BBB48382E1FCFCAEC0@BYAPR02MB5941.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itcAr0mLWVWDDCi/jJeIC99gnJppkAhIsKtOXFGX5Q7OxznIAbFd626oc49Ml86WC8q6DOx2dBax6Xb6UcXwR8zNQAALP2tm7oiLpDF8x+7x5Y7daSHxf0ZHZ16p406XYo7FjDkELWVYrDcCJik3aVGI1lT/5cYPCrJrN0dApJhZeQD6mUo+VRJcz9Qtj7LZSesaQvgvmtwCwNki1PTWMYVpT/vuIo6LoQa0iePKZ4vrLg6fbywT/VpqailLjahxATXK6DkWAnrUbQiRIAXX4o/stljpJvCU1JYblgjTkiyvZSn+KOTvel+TGt8Gmpn7f/SDmcjLuYKCVmLmQW1pJ1XhJYuWFSblc9v+a4z7dWz99eqi7jHz78eTJrdaGLu/pSjIJZ+kDgPVjGpMlyiuqECWTgxKz65EmqU5CnrTgGRndPoykkfTXeT3ji6XALCg
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 09:44:18.3928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd0ca0-ea91-4f31-448e-08d7b90e1e4c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5941
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.73
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

ARM11MPCore GIC is implemented with 4 priority bits.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/arm11mpcore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 2e3e87c..ab9fadb 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 
+#define ARM11MPCORE_NUM_GIC_PRIORITY_BITS    4
 
 static void mpcore_priv_set_irq(void *opaque, int irq, int level)
 {
@@ -86,6 +87,10 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
 
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
+    qdev_prop_set_uint32(gicdev, "num-priority-bits",
+                         ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
+
+
     object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
2.7.4


