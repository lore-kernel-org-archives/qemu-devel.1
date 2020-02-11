Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7466C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D9920659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QZiohgjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D9920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cH9-000846-Dx
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFi-0006MN-Ak
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFh-00087j-7x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:26 -0500
Received: from mail-bn8nam11on2092.outbound.protection.outlook.com
 ([40.107.236.92]:44875 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFh-00086O-1J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePWSDCE85i2wckDEuwTEv7Zbt6mtcXbE5MV6SrR4R/XpG6oBlLTycLKTcLemjWgnwrKNss8hvz+msS1WqmIq+Nz0VMawY6qokU5Xp3PAkOlhIuMsuvyyhop5+SpyfdH5b07q+Dt0U4CN2aWZyPBZisElsJveT1aHhNyNwV1QSMdTVFzvIUirLWcAh8JLont3COwNzXIGjwwJqpCNWp0QYjeoMezKgbmQHeS38w99L5v/QiZ0HdtX7RPFfVOwNI01XhojxNVoNIexfuYSYQNpHMR+/ewb+bGXI8JSsN3fZYBdj/ptNm36LugmYL6RKKxUPYjJTnebF4WtV0WdMyKxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPb+uhgPYlvdJyG/R+X2+zMJUtQFZJ0QzQ4q5gowrp4=;
 b=eugSuEYsIdQ8pfjmWJf1pcAPD12MWJG11isi1F0jjjSIytWRYRTlfShZIWuZN7fplWF7dp3Syh5m4ZG7J4OEtIgP5ILWQf6nuAzoxawN6yrx+rw4AbhQvHCoyq3Njelwee9LrWi2ipaeOlX8HoAOXQZxVOUPiJ+M5JPMM+OJh1MAFM10YBEDbEaqTXgp7BQ6XlJsKEQb54GT3ONCjIVYJgBHM4Bv5sFnZSxE58onG1zk+tv86+t+PTHrNBk9Q3h1mBpNLjbdJfM6HN5KJ5yVnix2DbLGIsyp3wY7kVGQI5arblpCUb9YdUeupabLvtjvIn0t+xw+U6kqIIc6i9GP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPb+uhgPYlvdJyG/R+X2+zMJUtQFZJ0QzQ4q5gowrp4=;
 b=QZiohgjW/UVRH6J5ll2TTpHF44Umvbe72F91+H3PwBtn4szK2Ws8B5Lp5K4gPc5LZCj7TsktjWac1SvrpOKDVQFO1ArzhpLSr/YR9gUA/C1xXgyqX8io20FxeG+1YrcqWwuJ9Fz04WebpP8BxrRH25rOQTwahTg5yqYFw3f/6gE=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:24 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:24 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/23] softmmu: move vl.c to softmmu/
Date: Tue, 11 Feb 2020 15:34:49 -0500
Message-ID: <20200211203510.3534-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:23 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 818b6f64-7a8c-438f-de66-08d7af31eb91
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35999B4A5AA00CE83BB18F10BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pf6G9dzRmMugIrZZ/i+fYR7rHShITsfnANsnfGKdq8xwsZa0MHzzcmrbfQu0xXe9lVUCoR8M8nCT8sg/20/8SAh5puaLw73QdxgIovSrUkZXyAlnig/NRI353ICnrFtkTP4Kq2A+ys0+KU4YIu4mIa/o38pj+fj/4k3wgsBmyHof+dn3WVDnrtC/M7EuoizSffjCTCDBPMPJgkWJJk4DBrYwJGTtO1R5/ADZf46DOWl28Y6Y0ofUrVkBvPJPZRS/aeMOyAJzVWRfSzxrsqaf7BcMEgJC81epCnTZDjYZx/9CFDW6WBWJNuNWcYdlBTxEOLTgDwDcow8ETdgw8r5E4YoRbWwZNusuMeAcUowX+TLiFazhgOw79aiAw1pbaorw3xw/1tzWwR0BVHArT/X90kzmJYwj10YMkSg+tYInEEgOvh3dCnD3XYmx7kkgdmlo
X-MS-Exchange-AntiSpam-MessageData: BV6cjTXxxjeoJ6qWXWCQb2tw1ou+NxsuIODbrSOWjd2p+5YivCTDrIaj6q0nppr8FNbu4We2EO3Zjt9TUWYngNUQSZcizgMsr5n/X3jw9usOARm4EyQ/HuxR6Fv8dHiZZmHf4qhhwgvnP4SeKDWLBg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 818b6f64-7a8c-438f-de66-08d7af31eb91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:23.9476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVIhdNZD3EyxrBSSUuJZKJ+b09qH+8dfLyyq7pvnCul+1IU3aCL0es+XKNiqPe6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.92
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
---
 Makefile.objs         | 2 --
 Makefile.target       | 1 +
 softmmu/Makefile.objs | 2 ++
 vl.c =3D> softmmu/vl.c  | 0
 4 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 softmmu/Makefile.objs
 rename vl.c =3D> softmmu/vl.c (100%)

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


