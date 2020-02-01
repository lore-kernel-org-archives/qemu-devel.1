Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094AC33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 03:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBBF20643
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 03:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBBF20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixjlq-0005Ss-52
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 22:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1ixjkv-0004WE-U1
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 22:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1ixjku-0004Re-Q8
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 22:47:37 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:53348)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>)
 id 1ixjkr-0004Li-5p; Fri, 31 Jan 2020 22:47:33 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0013g.houston.softwaregrp.com WITH ESMTP; 
 Sat,  1 Feb 2020 03:46:32 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 1 Feb 2020 03:47:07 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sat, 1 Feb 2020 03:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g34YlLcHOJFB3y3LX7dZMnoYtyGUhLPOHQFZg59tgIOlJWP8VAo/6vFCt5PZxll+yy4e8bCPxuX4rcm6r5QJRqLaffzDP82wJ3wev9eTGrh/jbD0wIciJmDO7vwcqYPYf2PUrMU2w/o4rVxRMz+WtHw0KXsfOhv7ky/68K02Fu8M5flc42FvTyl93yvXwQiKuXcvC22U5mVwjLGQWexae6Gmlfu/wojTIFrGaH03oPCVlgDT5QD1YVoYOaQNDQYqG7ZyyjwMVlgRBI2eggcV69tZD6AZgg1C5rHKcctmwYoLCU1Yxeqh3ess5cWFQZ9gaNUVtSH+MXeRT7uUtnZoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxW394MgnPCgp3P0qpFea1TYnNaaKz96+//0F41LRZQ=;
 b=VNSx+BvaDQIOud8B/BvEZmUPHJPZqPIKrAMEgswbSU3m61vnKa1+bz6ROJzd6Wjql3qyW3etRmPqceHAhsOUJOxBJTK69N5et26EER++er5xY/if+2wYH+PYriTF00BVQYkoZZflUNZe6gFZPim5L0MT2iazmKvsX+w4Q8YMdkVqbdge0y5hNff+PQqmbu2JTfA6plEntHIjcmYcmm2gYEGVwtUY6S2tiLmBOuU4kqzkjcMV/p54aGp458/BrRkt8ZzOirOYnQEMFvVMjSSV7sG6M/OwL2kQjEhsnbsGKnVEyEDoDV3xSrmZIWJ8A+8AbheD9mp16YxEem0zurSCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2664.namprd18.prod.outlook.com (20.179.93.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sat, 1 Feb 2020 03:47:04 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829%7]) with mapi id 15.20.2686.030; Sat, 1 Feb 2020
 03:47:03 +0000
From: Liang Yan <lyan@suse.com>
To: <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>
Subject: [PATCH v3] target/arm/monitor: query-cpu-model-expansion crashed qemu
 when using machine type none
Date: Fri, 31 Jan 2020 22:46:49 -0500
Message-ID: <20200201034649.26815-1-lyan@suse.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:610:4d::11) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
MIME-Version: 1.0
Received: from leonstudio.lan (2605:a000:160e:228::7d0) by
 CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 03:47:02 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [2605:a000:160e:228::7d0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f699d9e-a772-4a55-26cf-08d7a6c9660c
X-MS-TrafficTypeDiagnostic: BYAPR18MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2664C62557B7137921799D8DBF060@BYAPR18MB2664.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(199004)(189003)(36756003)(4326008)(186003)(16526019)(2616005)(8936002)(8886007)(86362001)(6666004)(508600001)(6512007)(6486002)(66946007)(52116002)(81156014)(66476007)(66556008)(6506007)(81166006)(5660300002)(1076003)(2906002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR18MB2664;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0T/5TRPQfLs5wW7aO+1KuMy43Ci3tyN/jFp+kKQemDjM+SI3qH35jRG+rdG8ZoHH/LT/Y18tqU24AQvJpRwUOceYfN1u1EjsQa23NPZWkozHjwvKz3gS9KvDh7CsB89C+DBXonjKs1f/uxgb/o86w+KIOHSVcUzsrs07mAYo4rc0wgEyNz4oAepvz1P/KRvegB+5WydMRtHW3AScHWQBP9sq931EXEWPNbDzDDeitYibZuzjnEVCdGi1vr/pcDkU9BeZUIhT91FctF05HjP0A4iHlGFGmb8f/cRGx6vIVLb71+Mzb/WF7IGXJeLw6Z7DwUKW3LAGBJ3oSz7zTX/KNPtZNFfYROoF9DtJCP+vlsrF5Z5n5gqVTvssoxFgJHROwCvyALyyp++Irg/7qIugzQzivaEA4Pn+wMy1undLvcy6/iLpr5yNqD+kMhglxEJ
X-MS-Exchange-AntiSpam-MessageData: hidOqQBFSBEPQH9/ws/PdKU4cSPGr6QthLPptwXdUSfCwlaoACa6al57Jy42fy+em6uVt3T/pK+hwG9O102jdLcFNtbUgW56dv5pboZuWWpGCFglFG7LcfIMiEyL99gUwG02PkiMPg3UKnJr9dwthRND3wjTw2ARRb3rrzmsQf8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f699d9e-a772-4a55-26cf-08d7a6c9660c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 03:47:03.3130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juOk/I7avB6chz6hw3VGZ/HAn4GXQ2EPGyLlLwDsu8hNYP7GXBl3haMojy9IGN0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2664
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.91
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e19afd56 mentioned that target-arm only supports queryable
cpu models 'max', 'host', and the current type when KVM is in use.
The logic works well until using machine type none.

For machine type none, cpu_type will be null if cpu option is not
set by command line, strlen(cpu_type) will terminate process.
So We add a check above it.

This won't affect i386 and s390x since they do not use current_cpu.

Signed-off-by: Liang Yan <lyan@suse.com>
---
 v3: change git commit message
 v2: fix code style issue
---
 target/arm/monitor.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 9725dfff16..3350cd65d0 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -137,17 +137,19 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
     }
=20
     if (kvm_enabled()) {
-        const char *cpu_type =3D current_machine->cpu_type;
-        int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
         bool supported =3D false;
=20
         if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
             /* These are kvmarm's recommended cpu types */
             supported =3D true;
-        } else if (strlen(model->name) =3D=3D len &&
-                   !strncmp(model->name, cpu_type, len)) {
-            /* KVM is enabled and we're using this type, so it works. */
-            supported =3D true;
+        } else if (current_machine->cpu_type) {
+            const char *cpu_type =3D current_machine->cpu_type;
+            int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
+            if (strlen(model->name) =3D=3D len &&
+                    !strncmp(model->name, cpu_type, len)) {
+                /* KVM is enabled and we're using this type, so it works. =
*/
+                supported =3D true;
+            }
         }
         if (!supported) {
             error_setg(errp, "We cannot guarantee the CPU type '%s' works =
"
--=20
2.25.0


