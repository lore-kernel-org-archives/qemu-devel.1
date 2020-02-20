Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0152EC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B749624658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0pG7U/po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B749624658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dCU-0005vu-TR
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBd-0004Hl-2L
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBb-0005v7-Ow
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:40 -0500
Received: from mail-co1nam11on2123.outbound.protection.outlook.com
 ([40.107.220.123]:19041 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBb-0005uk-Ff
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRPWzY/Eupk2vRUAA2JBhPt+YisHGTWDdEZ/+OsVaU678vMumMG3GVHHwbf6XifyzKPWWO32r6zyuxNFT/fgn8h6aGiYLb05Va1cZErGTKJgZ5JcCo4uDSp6fKo0Zs74FZcZLXEg7QjgP/zoHrkFJneQ8TlActR26A/WWnDxhbDdN+LK6tT/AWUBb/wBMPmTbLKFDLYMX6tV0RbGHreSaU2xZZtWvyTxWN+zumK6higi8/F3tQTLnam2kQN028YnYGpPcZ5aYe+VVUx/tLowepB9oKKmTQ38tBZC6dFddO1ORGoAln1rTa1AJlZ7YCALifa3nrISzyDONf/3PsJppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHFxYKfMyKMNf2sdfMdUNyNPaUZ2Rm0bD9gdp+7mZJU=;
 b=K51b/Bodkzuh8UO8/pyJEGIMF+fZ1AsXe1Xrcjd0sL69yLmcoAqTq+5K7NljeVBPz/kzVqhHF2vzWz4yH5m8lJnzbiM80bJw3IhSa9K80QZkc078/aYoBPg0RxG81fv/L+Pnh9pbLY1r/enhTc+/kX293b2wYRFTjDP1LO1V287xdxgoVpbHJ2mbGaLSP30ELj5EMDGlPFe/raqnItoNetzycbcUCcMc4inmoBiKM/2nt4ZVWqkc6vE0Ty3Ea2ZdD6JV4Ob+a5Y1q6oURTSgZeaEtFGf9oPbkiWYohWWs+lAwWZ0uNLjGK2xuyB2b8JH299s1haCGwexX2YYesHNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHFxYKfMyKMNf2sdfMdUNyNPaUZ2Rm0bD9gdp+7mZJU=;
 b=0pG7U/po1FJykP+JRCjzIwEKgJBDsnaQAd5xVK8w7FcVGlZBeb5rP09eXr5PnNBdjZXJ4Lhb5/wK4yekFtWIeiDF5IvdArpuglWS+/STG/WZeGV3KLaKjKel06r3VKdD4xAfp2XYeO/EO9jhwTtUpT1IzRw9dggY7qFkpXGg/hg=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:36 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:36 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 01/22] softmmu: move vl.c to softmmu/
Date: Wed, 19 Feb 2020 23:10:57 -0500
Message-ID: <20200220041118.23264-2-alxndr@bu.edu>
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
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:35 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27ea1c4c-e53d-4c13-8790-08d7b5bafa1d
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38072474A9892810E7D9A494BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
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
X-Microsoft-Antispam-Message-Info: Z19+4tcU7V5Z/6qutS+eS3GTKdFcHKSxruPRP+CnBaLKGSjFMv2sQ2VEsnedmI1J6fBAJ4zCX3GNU6rQuoPI1MBwb6yV7E9m8tZkwJ9k517o/XQkEx1iLblUsMbtyqZoi/WE2SrMBCBA9zw+DI/+fjB7oirlnMqBLzy2ixy/Kdd3pHhkBB//Vp3q3BRSNgYzvE4LFp48haeUTV9yJg0g/FfQRWW6LnSena/53PatS5ww+jkm3/fyEupKI6e6YUmKNsLI0ZirRbryyqU+aqy9XwF3RHqtfz/tcqpv0vFgTwcOianbLoSuZVolJuLQk4cJimbyRRxjnpZ4nTHsxksAG7XGph0qJCJnZWYoXMbDnZr9aB49Rdye8nn7r/qNMxfBY50pwrJAl71v/nDqo7ByNt7vFpDAZETYZnFeOg7cQTRTVFe3rLcCwS45OyXoBCCG
X-MS-Exchange-AntiSpam-MessageData: s1PoH2Zve87yz6tEBmp7QwK7KHvVzO87l7uMphhFToWYx6yXoSg5Fb8zjIOLxe3t6yCBG7tkjCjqimjtS0++Km9mdQWklVPvBAkI7dbp+LAb7Y3wKndHg7uwLFj6KuPatvvNyYnUa+hd0xmwlhlolw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea1c4c-e53d-4c13-8790-08d7b5bafa1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:36.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54e4ZY98quBcqx34SE8NJAbDkHCIJHJqZNaHOzSUHMhSbSmMFE8o8kaYsNoR9bhB
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

Move vl.c to a separate directory, similar to linux-user/
Update the chechpatch and get_maintainer scripts, since they relied on
/vl.c for top_of_tree checks.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 MAINTAINERS               | 2 +-
 Makefile.objs             | 2 --
 Makefile.target           | 1 +
 scripts/checkpatch.pl     | 2 +-
 scripts/get_maintainer.pl | 3 ++-
 softmmu/Makefile.objs     | 2 ++
 vl.c =3D> softmmu/vl.c      | 0
 7 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 softmmu/Makefile.objs
 rename vl.c =3D> softmmu/vl.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7717df720..98cbeaab97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2023,7 +2023,7 @@ F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: util/main-loop.c
 F: util/qemu-timer.c
-F: vl.c
+F: softmmu/vl.c
 F: qapi/run-state.json
=20
 Human Monitor (HMP)
diff --git a/Makefile.objs b/Makefile.objs
index 26b9cff954..8a1cbe8000 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -58,8 +58,6 @@ common-obj-y +=3D ui/
 common-obj-m +=3D ui/
=20
 common-obj-y +=3D dma-helpers.o
-common-obj-y +=3D vl.o
-vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
 common-obj-y +=3D backends/
diff --git a/Makefile.target b/Makefile.target
index 6e61f607b1..06c36d1161 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -160,6 +160,7 @@ obj-y +=3D qapi/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
 obj-y +=3D migration/ram.o
+obj-y +=3D softmmu/
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
 # Hardware support
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ce43a306f8..c85ad11de1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -462,7 +462,7 @@ sub top_of_kernel_tree {
 	my @tree_check =3D (
 		"COPYING", "MAINTAINERS", "Makefile",
 		"README.rst", "docs", "VERSION",
-		"vl.c"
+		"linux-user", "softmmu"
 	);
=20
 	foreach my $check (@tree_check) {
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 27991eb1cf..271f5ff42a 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -795,7 +795,8 @@ sub top_of_tree {
         && (-f "${lk_path}Makefile")
         && (-d "${lk_path}docs")
         && (-f "${lk_path}VERSION")
-        && (-f "${lk_path}vl.c")) {
+        && (-d "${lk_path}linux-user/")
+        && (-d "${lk_path}softmmu/")) {
 	return 1;
     }
     return 0;
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
new file mode 100644
index 0000000000..d80a5ffe5a
--- /dev/null
+++ b/softmmu/Makefile.objs
@@ -0,0 +1,2 @@
+obj-y +=3D vl.o
+vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/vl.c b/softmmu/vl.c
similarity index 100%
rename from vl.c
rename to softmmu/vl.c
--=20
2.25.0


