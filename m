Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B59C11D43
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5472465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="XjKlsHHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5472465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dFM-0004SA-02
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBo-0004fE-AM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBn-0005yV-7r
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:52 -0500
Received: from mail-co1nam11on2136.outbound.protection.outlook.com
 ([40.107.220.136]:38881 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBn-0005yE-19
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWZpHJia8RLSlDrwQlosHRvoHkVeZyREoqoUbgPs+FzIcrJRBiBQW5YE6y4XGXgMxdQkabPQ5beX7hcusXZgEeB7dLuqOg0C2KbaM9TsZGXV/UUtpLmbsE/rDdMaTjL+bl1rtx5mZTWhOcwKgunSJSEyetRBaXH7pOIFta78Qi4kT0XC6BMhWEtuJKA1M8vETmdhZKfGht+I+m38DoNiCvDUpN81BGx/thQ7q3lP5lhgZDqrjtgZIEPeahkzMqGQJ8pFlp8pq+1IygKdkQZqSQG+12Hx0ENYIvFGQ2Bpf7ffjAZt6D5rqURjtQSZ8sYN8/LLUUsyh1BB4HROvFvIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkh/R5nFd6Ghtc/QkVgwC9wl0JQAJ14dD2v8bKKRHCk=;
 b=GRopl2qt6tC+/sLNgBKxepJOUVjFef2ykFox/WTmt1ZZ6lmxEG+vK7tM5OHa6110FFDcOj5Es4dlQHkMQdt6D/LoBIF7Y7JZ8ohrKHdkl2WSV4rqRuOMWORlpYxWa7/W8qETAD5LlYctpAm2R+lfO7D3go73K70YltX/KOqVVdYiZs98cPo1GqMJ+ygei3Ex/m+do9BB2Xf6IR9reSbiCOrprl/HaEnX7UW4AJucIEA2pq1Uzgmt4BT6qxYCoU9uYurjzKaYvB3rgMA4lV/dh8kZAdfAN0uAiGmFrnDsLhVB9NguCYO3evV5Jhl8MTeF8ArwjsqmPDZmTLWf89rJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkh/R5nFd6Ghtc/QkVgwC9wl0JQAJ14dD2v8bKKRHCk=;
 b=XjKlsHHD77XndD3zkSkrjXkHhC5uWkfIAqd0gxpmybKyT1rptZOJvH4ytD0HvwV8DVn+bEx2UwJ9TGGaknADDgaChy+pwBpoNUM+nC9XEZ6sDYacnGDLz5R1cwUvH5Qfc1TZaYWGvwhtVJ91djspfCrSGlOQ1++69VK6WUtEguU=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:49 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:49 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 13/22] exec: keep ram block across fork when using qtest
Date: Wed, 19 Feb 2020 23:11:09 -0500
Message-ID: <20200220041118.23264-14-alxndr@bu.edu>
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
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3a4fae-1a7f-4251-8e1d-08d7b5bb013c
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807A600052B61982EE8FAB7BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
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
X-Microsoft-Antispam-Message-Info: e8dAkePISguXPOxS+uJxQ1sR+NzWre9ksV6hdN9JwMSTbRVv8Ir4blsCmvDCVp1gMH2GuWtk23+qd0zOSvGrPztkGGsGF9Bq3tmP2TIW7CWtqkVAiiP9qdYNpc/LYrYh3eYaX7svVQQ+6lZA3WUfywyJ+hSXDmDY0uiUIqvvIbfbiMRJP3ZgGsJDb4ql8Gx0e+Y3+C8tTWHzqV6xZ773Fr5BwRpOoEVLmKr5+Ou9i86+lpiV9Lt18zI862tWIICRrhCUFhfJT1pBZrhe2cm4EnAN6XEYSzHEFacYqQ3hzff7H2R+layKNFXQFk1kur+rRu00oSxRUJ9woaA8zqi2H7uOpGzV6bbrnRi/AnygCXTuFvtcxroAB2pcnxTgzYhretsONzzQmlIfxn68cWqytRJBJIjkN60mTBJj7JL5fXnd1eM2aoVH/IWPTY4/t1jA
X-MS-Exchange-AntiSpam-MessageData: sOVpe3l89tmNGwz1ILKopuBtIwcPsqPaPIqPJy9Hu4+30ctPX2vRIwYo5r6Vc1/YrA7TZJk3BtKiWH4qgbv9hFuiwhB7AzQvY96vvFZsKKfe7W/PT8TNBdacyYNtN0r8X7C8sfHMgapnbzbmR6ItCw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3a4fae-1a7f-4251-8e1d-08d7b5bb013c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:48.9387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2LDVr+KdFXI3quufqZlEg59z9fGFnSfcFmaCUVFoUBNJfWGDE+IXh2loVJMIUr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.136
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
 stefanha@redhat.com, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ram blocks were marked MADV_DONTFORK breaking fuzzing-tests which
execute each test-input in a forked process.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 exec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..43f6659d12 100644
--- a/exec.c
+++ b/exec.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
+#include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -2306,8 +2307,15 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+        /*
+         * MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU
+         * Configure it unless the machine is a qtest server, in which cas=
e
+         * KVM is not used and it may be forked (eg for fuzzing purposes).
+         */
+        if (!qtest_enabled()) {
+            qemu_madvise(new_block->host, new_block->max_length,
+                         QEMU_MADV_DONTFORK);
+        }
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
--=20
2.25.0


