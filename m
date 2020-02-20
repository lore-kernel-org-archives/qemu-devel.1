Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F4FC761A1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F51A24658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="WCSfCPvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F51A24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dDt-00017P-6z
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBe-0004Hr-Cg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBd-0005vj-Cv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:42 -0500
Received: from mail-co1nam11on2123.outbound.protection.outlook.com
 ([40.107.220.123]:19041 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBd-0005uk-6S
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iymHqJu6UlRTm4Djvq/7H6c6WuMkksLRxzij3LxmlO+Y+3lcDSdGcwP9FSRt8hwVsqkK/wpVa1UkkP1n3+QLuUS7Leq4n+FTDO4CA+Lqbbrg3kOMgdEMocfps9kr/Z9JnJXV8NjmHoLGfCSif6euhh8GwXh7YUcAzN2eOmlrbK8PO6s0kQ6qDHBAdVMFGe6bX7MO/MBZkZmm0rS+vGTylUOYjb2CnSl09g01LV9/GOZbetinyJRwQxzaKgRLZ+eUz5QLgiJekMI3JtQlLa1aCHGnQYAbXshAEgfhllegNHdoCR/Dxefs9BqaEtLhW9kWN3wJ9XA52bJ205SxLbXWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zAlL1Y8f6UQLppCwhd1T8uBK3hXFKCnVJjjBWDRtdU=;
 b=i089o+R/YD+2p+TqCOBzDnvXfeQdFLx7vhyhlJvtSVxswkCWv+KUw+5XN/W6i87RZtYQ6FXAuy5aO4k7jzfEkvUl9NV2u4arbwFt24ZEGpzF+XnUq3dc5cPJre+bza0rdAtbSxdsVmejGYej18Tr6hdzprPRDuciqqS7mGdOXl1otAYla6/YBxP/We0nUen85P3erZo77+d7mQ7JqL4kEhH3qn9SEtxmqRW48SNUKVcJ84xZqIoUkXtmY11vINbN5moYeLwL4iDZimkXS26UQMcaloGnjlxok/vEcQW+tfarepdYXS3bEiBoy/Tj6/EFmxUscqK/whkYDMb2dAw2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zAlL1Y8f6UQLppCwhd1T8uBK3hXFKCnVJjjBWDRtdU=;
 b=WCSfCPvMZKWdaJx88ia2vaTpQYLHp6qvCSflzI+700ifza9KkL5V2E0Yhpo6+Zpl1yz7QEKgBFdIWhyhR0c6xtj8Oz733YZTW6T1NLHPwVf2kZs/dJyl1eL5KHBJIhox8DB8peblH+czKtQP4XtEzkiRW/Pg+J4yKsf4TWJblqo=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:39 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:39 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 04/22] fuzz: add FUZZ_TARGET module type
Date: Wed, 19 Feb 2020 23:11:00 -0500
Message-ID: <20200220041118.23264-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:38 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d89c517d-fc72-4806-f6cd-08d7b5bafbc3
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807BAD61F5091C05CC3BC37BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0RrYfmWUtHPyEG0f+lK4NtcssZGZIrUi4FIqDkc9/e+kzyiS+D6JdYC85i7Wf+CrxrvcfwF5TitEtugDBCsJhGgruuspbtYFqgRCjzjP4sL6Ca4AXuzlyMfTb3wDxlhdGn2Le2PooecB/5Dzj9hGcWiFXkxYsgAt0AIQuWuzhdQsGuzPLf/u7Ko422lPnOo2gzzv2DKMxpy/Itz+lbz4rjOxYfz5//R2DAc0yasPnsBULO69kI3KIE3ir/e7zr4mOMlkmdnsz93Y5epdncmvuUhUFGH1647GtQe+fBjgP10rPVPNS04T8FZP00T9wj3nA2naHcbyqc0Dg0FYt6gkrMna0e34T4LFB/DDGkrXBDS7wxYd+IrjIbasMxcDeOGcJANo/gu/R9LSx4ROtY0ZtPXPisgiihcpPf5oWdzQ0825EGvOriC6D1REYFY2d+q
X-MS-Exchange-AntiSpam-MessageData: TylEcuD66imtwsNfsYfuMNsPXO8wIDU31yKCmQrgexchBZjqqNumgdj93AXcvEvJxK3mASMMLWGi/zb/IileoPkXQH2+BuERKV0bKJpYdCV4r6htOijXxKk6rMSHACrCLbebGEiaQVo7qnUiJWzEkA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d89c517d-fc72-4806-f6cd-08d7b5bafbc3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:39.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggXWL9BEjYdvHA4fLeJBFTSyZMTIZoDPWmmZOS5xa3E3o1+oIpVEeyscBXNx2rHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.123
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 include/qemu/module.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 65ba596e46..684753d808 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -46,6 +46,7 @@ typedef enum {
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_LIBQOS,
+    MODULE_INIT_FUZZ_TARGET,
     MODULE_INIT_MAX
 } module_init_type;
=20
@@ -56,7 +57,8 @@ typedef enum {
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
 #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
-
+#define fuzz_target_init(function) module_init(function, \
+                                               MODULE_INIT_FUZZ_TARGET)
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
 #define audio_module_load_one(lib) module_load_one("audio-", lib)
--=20
2.25.0


