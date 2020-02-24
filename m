Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B921AC11D2A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891D720836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LpudzdZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891D720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6AIc-0002Ee-KM
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 04:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j6AHl-0000ny-Rs
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j6AHk-0007wS-Pw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:21 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com
 ([40.107.237.70]:6021 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j6AHk-0007w1-Jh; Mon, 24 Feb 2020 04:44:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emcM362LTYIKblLCjTxf52zDAtb1afH/NiQ+6uP+8zHfgG8y5aNsLsEMUXeV07ozncKvDeFNvR9Uq4gphsrLsYq7c3pRw6FSr9/xJVEGWyIJl/nPRBou7E34YaRkTUUU67WVcpvqkrGYJO6EoUypFcRUUk7iob2f0q9aIvHQ8qV72oFoNcdY+rd9jVITS4tSsJGQ9C+ZET1GDL4ZBBqygoRw2tXjzv46VaU8CBSo5lhQcRL3ApJt0WALmewb2qkRf3DMkNoOlLbfGhLbWTUVRBYQluwvfbTlENviwM1na7zT5DOmL+i2qWjJ/lXPsreUHclUfnGx1zoXT1nQ30ZljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WftwKRsIrb/fF0x7O6VjbxITpvbok74tcZgzj4cYi+A=;
 b=Yy5LgzrqKePmJMkzpFXRQcNIKZXdYsLHp3Z+zvcUe7ywbuVtj3ZA4hq8SAA8n15JYbg2UIH6L+i4lt64JzN/UOfe+gEASmIJ0PWu/vihMtnOQOXy6t5Xw3mmKNwf/EzV/Wux67aYQDnt5UECbBW0wJ+OXP0ZfDNLIc+gkuhP6TDE9RiRMZfmAxrrw45GsBJrUvkQIQxW81HvHjb6O7T1Hzr5sMyFNk0VjsXPuPSiQ0KE+m4Y+OUZgGX0x04hd6A5moicZijq8yXoLv5eR2xnCL98omOukF0/DHld2k68UXIF0O01pxucaRq7dqYx8NpVU2WUZVa55w7sb4MFg5FdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WftwKRsIrb/fF0x7O6VjbxITpvbok74tcZgzj4cYi+A=;
 b=LpudzdZOWa0uuJoHiYQW9/jIKQO+ZYB5Hc1NJtCICVWzTmxNoJ9sWAjPB9ZYNVXOrs1n5sUiSn1/UCVyhh/PmdU2a+kxFY875ze7XwzkCMi4FTYuGdDxHoePxoiFAq944p0VowcoVEW/hmTThi+KX0OsQHwW0qttIofTMreIcbw=
Received: from MWHPR02CA0021.namprd02.prod.outlook.com (2603:10b6:300:4b::31)
 by MW2PR02MB3820.namprd02.prod.outlook.com (2603:10b6:907:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 09:44:18 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR02CA0021.outlook.office365.com
 (2603:10b6:300:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21 via Frontend
 Transport; Mon, 24 Feb 2020 09:44:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 09:44:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHg-0003mu-W3; Mon, 24 Feb 2020 01:44:16 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHb-0008Pe-T0; Mon, 24 Feb 2020 01:44:11 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01O9iBJc025457; 
 Mon, 24 Feb 2020 01:44:11 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j6AHa-0008PX-SX; Mon, 24 Feb 2020 01:44:11 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 6DAD113C0BA2; Mon, 24 Feb 2020 15:09:38 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH v3 2/3] cpu/a9mpcore: Set number of GIC priority bits to 5
Date: Mon, 24 Feb 2020 15:09:23 +0530
Message-Id: <1582537164-764-3-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(316002)(356004)(5660300002)(6666004)(2616005)(81166006)(8936002)(26005)(186003)(2906002)(336012)(426003)(6266002)(36756003)(4326008)(42186006)(110136005)(70206006)(70586007)(81156014)(8676002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR02MB3820; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02857715-7e0c-4869-3a74-08d7b90e1de0
X-MS-TrafficTypeDiagnostic: MW2PR02MB3820:
X-Microsoft-Antispam-PRVS: <MW2PR02MB382038C70C816865E0A5C46DCAEC0@MW2PR02MB3820.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQRW0BA+xBC4f7O7IJgwmxed3Go3kbYYW1iyiyJZ+Q8XmCZc1IwdjjVaYEJsJKfT4EZ/+5gH/3O/f6liIz6fyz+ktqmN8BzbzjgmRS8WLeyLRpaEUTNc5rboy9NOis7UsjgAYSVgDmRcrTscvk3Yh7PGMguFPFrEaz2i9HhjLTivd/5AYm29OIr/5PSCkuqq11/23EILlq+f8kJmnkS9x4wWNiRD9gyB7CN0m31mkT9jhkWqJocHj7IZLwQ7f2Pthgxtp7/Z1bKQjBD4nWYS0IGk62G7KX/WRH/jtx5pTlq7s/YhhWkJhsMa4iXVuyT1nRlQT3HbobrpNbADxdlG6kYe1fjMttcdGQYpiUGI4249qz0TfbG+Wro7WGOV8Ev/+KVmEMtDcIEPy0DcUtHNVExFYUBiukU4BdLPWaPo8gn/tex5LUNO0DDEiTqNWaDY
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 09:44:17.6314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02857715-7e0c-4869-3a74-08d7b90e1de0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3820
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.70
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

All A9 CPUs have a GIC with 5 bits of priority.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a9mpcore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 1f8bc8a..b4f6a7e 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -16,6 +16,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
 
+#define A9_GIC_NUM_PRIORITY_BITS    5
+
 static void a9mp_priv_set_irq(void *opaque, int irq, int level)
 {
     A9MPPrivState *s = (A9MPPrivState *)opaque;
@@ -68,6 +70,8 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
+    qdev_prop_set_uint32(gicdev, "num-priority-bits",
+                         A9_GIC_NUM_PRIORITY_BITS);
 
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
-- 
2.7.4


