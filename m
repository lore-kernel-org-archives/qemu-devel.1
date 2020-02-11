Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDAAC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D3120659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Ds8WutXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cJt-0004Q1-TJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFl-0006N2-By
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFj-0008CM-5e
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:29 -0500
Received: from mail-bn8nam11on2118.outbound.protection.outlook.com
 ([40.107.236.118]:3988 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFj-0008AB-0K
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCbLvgsnFdyl7FDRbRKUKMJ417czMpoCeJ3wMPKccxoyAbDb+UI3Q9W1qR3Cf0MpGTAXTYPFYUOqcoLNzhUadGb6ccJqVNjJDiG9NdBgnluKijmAYLDrnbPtomwvsuF70RbWEC5yWqcSRSPTP3AHEtsvb6WCIKEeqmjnyPQpa6NyTFeYhhecEQAfd3CWza2yh3el4Mx9QkYkXlKUD63TbUJ5QvN6PQOaNieq6YWpuHCTtANQw8RHwq3uHEM+Nc6QWcJzPhKdxkyJu6ku2XF0WgHpoK6AvOzDIa2vVzhiTW51CA0scM/8NvQu9F7wfOOTYZ8KpcKQ+dF0lzhlx3WR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kycl+yJH8ldMwQbjFEZ9KwmnURppMBCTUzF3EL9XjKI=;
 b=Oh6XJddwJL9lD26Dfy1a43TnJ4lySOq/FL1rZxqnnhuu0pqeaaUTTwUYx5Z5blktbrh0dg3gs6qZqOSwyrpWFc7FYiBEjCmMoRqW8LWA7ManQyYkhzuZq9uRa+z/2msg5E6DdZ/+a8DxCYvMVeX0NgxZou2Veh9CSvHPr+8Xn3eLpIyZmiy7ggtwn8chc+JG8DPsJ+K+HV2KH0vdiJV10GXBuXLwx9UZVMCJtoaHK/vi67MaecSj3fcjJkRDIOyY7PzXSqfMz2vRZhaCCWaJQokZC93UL4iljQ19pziBoEOi6t8CLUd4Hq02SXANgzWEXdS/RCNXEf/OxWQu4/sQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kycl+yJH8ldMwQbjFEZ9KwmnURppMBCTUzF3EL9XjKI=;
 b=Ds8WutXb4SCUm4td2S3rVYaDGDmiWrYzSn9XcZkFTASoaIxDgYENzHFCN0U4IwgKG4VpdS66/S5E8gj5cbI425Fo3IhjbCU1Ep7poApdmB51uOYywZTk7LSsN3BgdC2Jg9rof1jWsMZ5+/ENZvKYV9AGaQCUcnSIzIhNXrjhH3Y=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:25 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:25 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 04/23] module: check module wasn't already initialized
Date: Tue, 11 Feb 2020 15:34:51 -0500
Message-ID: <20200211203510.3534-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:25 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac6df2d2-19df-4880-21e1-08d7af31eca5
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3599691C0A1A354FB5642C51BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(54906003)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaoxOs/fXaW31pVuB8cejSdVWrwBGsbjpDyFZmX4qM0cnvoKBYHuEvE1P0PsgXLjaOC3aKZI0RE2yGqTrbMG9SmWFTEy5bQkuueWsjbJ1o4k1PhKBYIqWH7bgoKvU0GfRX6t5uu6OlxqdL6E0y2SwPqWJQDN3KKBdL6sE14fdIBu64b2GRSL6SMeFtG2IdGVYAJrTSpWBBvFm1BUtaF81hCsKPIGNstuk/WKM6LkNg+YE5oM3esb6/V5FpyuksFIwxcvzVA8Ra2Cpc8eFcRGVv+VaRrbi1DwvrQL7NXN9lUxeT8u6XgJni15CnwtfDD7Sgeq1yEh5SK9NG+04WmySDhKBfsQ9LlbFxm4hfwqK/Hs/TXdJ7iS6qD7oNaXMXA9qio0HVq/RFpOrezlr0k3w3UmqTshK0dDu8bHldwSiKeACzt6pWnKIEVE4n9TQX3N
X-MS-Exchange-AntiSpam-MessageData: 2VOZG6knDKgvSkzyLj9c0PJQ2/G/RlYq2AFO50aX7voSMO1R1WnNidU8Gm0aL8lsxSBdaXfROXP3CpXCZ4LbCRbKbNROizvbxh+IHLbECWzo9fTx5SZgriqhxuktascdjiqpTDoZZhE5GMrCfKqJtQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6df2d2-19df-4880-21e1-08d7af31eca5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:25.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEgKD1JsfQd6fD9YjJsdNJuuvqgbf7GegrK7Sp/a4D4zswFF3yFFFDqmA6H2JvYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.118
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
Cc: darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual-device fuzzer must initialize QOM, prior to running
vl:qemu_init, so that it can use the qos_graph to identify the arguments
required to initialize a guest for libqos-assisted fuzzing. This change
prevents errors when vl:qemu_init tries to (re)initialize the previously
initialized QOM module.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/module.c b/util/module.c
index 8c5315a7a3..236a7bb52a 100644
--- a/util/module.c
+++ b/util/module.c
@@ -30,6 +30,7 @@ typedef struct ModuleEntry
 typedef QTAILQ_HEAD(, ModuleEntry) ModuleTypeList;
=20
 static ModuleTypeList init_type_list[MODULE_INIT_MAX];
+static bool modules_init_done[MODULE_INIT_MAX];
=20
 static ModuleTypeList dso_init_list;
=20
@@ -91,11 +92,17 @@ void module_call_init(module_init_type type)
     ModuleTypeList *l;
     ModuleEntry *e;
=20
+    if (modules_init_done[type]) {
+        return;
+    }
+
     l =3D find_type(type);
=20
     QTAILQ_FOREACH(e, l, node) {
         e->init();
     }
+
+    modules_init_done[type] =3D true;
 }
=20
 #ifdef CONFIG_MODULES
--=20
2.25.0


