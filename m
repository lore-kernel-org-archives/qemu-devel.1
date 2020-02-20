Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3281C3404C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9181E2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="PGH1jEVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9181E2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dCW-00062O-Pd
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBd-0004Ho-VP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBc-0005vY-SO
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:41 -0500
Received: from mail-co1nam11on2123.outbound.protection.outlook.com
 ([40.107.220.123]:19041 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBc-0005uk-LI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUkwGPyw0gCto+OtxlTodh3HS/e1+JaxQyY2CF8yakRAYPQSqstmMoOOROMoRB277/mB+Roswn5S28KwhGHwjhYue58qRAXbznVQJOrVi5NX1R67pNvS5yvoTX6CoGxCMVmIPHTKCVPqkm9QCd4NH3oMAdu/p50gSVfue7t+nEVDgAS75F4ydOEmHYjP6usTJX8lUhhYzk6KBVi8F+DAqt13eZYaJzRp0XGYD6sal9V+K9a+icmf0MFhCSMMS36aW3pl/eHjE6qOulxE8tXdhFMOZeESTeLa3q0cJRVdoZ0UXokyvEmym41iBcf/tvZ981QFbAn7YvCP7JYKvfbBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kycl+yJH8ldMwQbjFEZ9KwmnURppMBCTUzF3EL9XjKI=;
 b=oX3tMtKotFHWkyjvPannS4IWO8xS2ajG5FxXyjGsm6IRHwFow+EUUjwUfT8PrDHAjDZKF711XdJ/6F41NpgE655GzIiNvKDoW0m56ek6d8+n/40HQ4eJIVF7YeEavtC+j4LXmR/lQMdYFgNw0Q4ItrrLJ4Z77PFIZ0DYvUEDCcYLU003FWsfC172jEZN/cas5IRC83Lclh7wWOcnr1jgApsAYpwvM97yTVUYKm5RlzYjuSl0JhQZmI7HtmbdagyqYuTdg2DCIsfL5LnWsPbiEbHC3zX3yi+B7O9EPzjdeDuR+S3PzQeWKRSK/SuOSuNG80meNsbOtQC86C6w+9wBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kycl+yJH8ldMwQbjFEZ9KwmnURppMBCTUzF3EL9XjKI=;
 b=PGH1jEVj9ILSrFxDVgS5afnlnAf8kxVdVUoGxCmp08U1Uc1hkVbzqQ+Fot/+BEYcWKj/nc6VmqW+HAaVNRXYhMss0+9cNBuvQG1aaBPRjwsQips4H6dr4wR3CsyWuAVHyno/ZAv5F7ALLXRi6jRVq3yZWm0OYvxTYGj+9dZqm90=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:38 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:38 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 03/22] module: check module wasn't already initialized
Date: Wed, 19 Feb 2020 23:10:59 -0500
Message-ID: <20200220041118.23264-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:37 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3caed889-9a6c-4d99-3c6a-08d7b5bafb3c
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807F7535C4EB65C3CCC08E8BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8kmQirvFYEibtNwO5m7Bj/nFgsoqGs5OaWN6r9cIbZeVzvCn8ucRSRoC09njzgje1BoU3ZDBJxKSIHoyE4ITNJHX5CTSW4CRsP+mHXrKpAmMsEN5Bz5uQbqNAmveB+Cr8vyNxJGFvsk18z2t9Rf814LDE/E9UMFXYXr9UZo8NttCp/HUgyxE4qDbPgSOd7dDv6K8XEBEHHwvqCIY11XVmy5rxEvCYcOY1N5SKX9E3vEfEfs0xmkkWEjCb/pfxP0tz6KFpKeZ/PKMsvXZTmWh0hp6Oxe1mHFDxTmUb41jiua9QDr0RQRXBXD9UvekPvFim3zTOuy1hMzH5cBS6MkXfjqiJhnkWIkbohAN+oUqX6LgnYZscssbjcfgmnLKyCgs/i2pqfhqUnlib4RDJ6/CRiw9Zn6DhCeIBVpnKtgIWvwPY+OPMTAU2kvfq2pWIBS
X-MS-Exchange-AntiSpam-MessageData: Rm/9YRfFsE+jKf2D4qQab40hCsc7YSUn+iFT84JcSG2l37EwO93wMHagdgRFVmFjLO6xVU2ukgrKROk58Q+NZPHLPrp4Bgr4TccNkTfJbxNYwnO2qAkCaKJUOXy4a/r3O79zKLXg/jsT2/SYSPDG0g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caed889-9a6c-4d99-3c6a-08d7b5bafb3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:38.2976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAyiHylOW3LfnRHRFmBBSvdFct5bSg5aJtcQ7Bc1vIRBZIjA7n1ypNQ0Bm2NuGzd
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


