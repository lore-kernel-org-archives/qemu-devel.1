Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3BC3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D4920659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="GeTXgNfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D4920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cHD-00085a-6T
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFh-0006MJ-M0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFg-00086B-GO
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:25 -0500
Received: from mail-bn8nam11on2120.outbound.protection.outlook.com
 ([40.107.236.120]:36865 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFg-00083m-AB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ/2Fr/Hsz2dvgDD7C3qvUB616mkMH4SxGUTOohErequH1Ej3Ym6ATwNXFHR1iRhS+Ak0NrGz+XsXR62SghYGUfTvIWlbhKZhPnu514vUiIWuslyaSvK0upcn9vLmjY2J3lJYO+oHULi3firr2f9Fo3coQ9XKzvdJq/L+nK1FVZzRZzAhm2wP3J78LY9bM2SqGyBPJcyefF3SOxG6XS5brs/ZldI5fMaSZUMED882Y2JRR/iAggwYgBShik4lPjFmoMZf2/4HeJP0ekGHt2+rYwUgbjtUZxIoOPiX95+YRmko+10anhM375qxaEvn6e9bu4bVrldlC3133xZNc1ZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUMEykh+dDY//Vw1UGoqCnJC+qKIQtaWZcMAcdP4hV4=;
 b=VDG3kpKO/mO9AIcVqpce/OzqfrsdiXarrnRWae9ll8gPwXV99tlKETVVxeRHBtj5zn6l8ZEd+mQXoK7I4Ub7z1TSZAX+FjbjokA9gnPyXoiQvmGKFZSomDJQdNWSFXZAjUKRLUr7FuCIlsEEB4jEqQiVDa/ttChN0lSTmpZzKTI/Y3kPGcIczTv/mEMiBfUbwvHbtafOoCMnf3A7SveSHUaJWGPD1GqcvlJ1iiHMmuCOKoE9Th/9u+zEDiAMv9NmC2E0uA6Cu8FKWHo78uFY9zGidnvgxmSsT82KodOFtZJYekCMRECTLhRmEkLjN6NO1bOfkakC7bl5BMEv8ZdGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUMEykh+dDY//Vw1UGoqCnJC+qKIQtaWZcMAcdP4hV4=;
 b=GeTXgNfHTjKybVgymyD8QoqktLLRCTrudqvxIhTenRmdfeIHYUUVJ5VWNlqK366qkTToE7TQpuLHKEoRYCFl0AO1BEXvrXWn7lKzqy5NHl0uiRUWUddTmifnsjjv/K2GCw/FbuJUfD6/oPDqRl35IBhpAzSDrz10ZOmU7bJbgwQ=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:23 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:23 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 01/23] checkpatch: replace vl.c in the top of repo check
Date: Tue, 11 Feb 2020 15:34:48 -0500
Message-ID: <20200211203510.3534-2-alxndr@bu.edu>
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
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:22 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ecf2a23-424c-45e9-60bf-08d7af31ead5
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35991441A68B2862A92DD303BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4744005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrpbYx3xFA//Adz8MI5UmozoqbxTDMhAPhXXj+YEjdspIKMyDpxphO6jzlnNwoCOESiHKKF1QFRkblTdBxysQzzWsbzipUw0QV1HBkYFMD7CbB6oi48oL9u2bj2nKX0UNcvdacJ+jHI/owkPo5XSLQZ7Yo9CmOAvShPG9gqEaE0xjgROWj+paWCmgqChONVIcW2ewRtj7xFl8n9qso1FmfUwpiQ403TMTGjAhMd27Wdvg7zbXOjKIFNjyTzFDTKbRSXYtoNmeiE2KLR13G7ea2v9XFCsobr2ayweOouSLQILGGU8ByS/vXb4BuyrrkWebI+ylxbZ9ci0IdiDqKLsVvTdW3CRaaU4kgCmU7sdK4npzd3Z5YZvSnTjpF/q9RuLwE/fbVxVrNwmHdnMGh/81z75nmO8rdTZjIyWoz7UVHh3zfp8zPhRqC9HrgSdzU/k
X-MS-Exchange-AntiSpam-MessageData: E5txaHFvGK8+ESOIKUsgmm6129hz5Gr25who7WxWF4/hV6EHCpgw5XvNrxXzYNA1eVho+k68x6ZLR54T9BeRljXOmzjvWNzSQsXm89LYiKJo3qr61Ww9ssToxuC4WO8g/vj4yupDz+ioPVKQ3ce4WQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecf2a23-424c-45e9-60bf-08d7af31ead5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:23.0311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqpTD9RNFtaGN+qWkJFi67O1xLx/Jw4Q4nnMEAuiId0IJCzh+/nAIe0bjuOwrQGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.120
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

524b4c2c5c moves vl.c into softmmu/ , breaking the checkpatch
top-of-kernel-tree check. Replace with checks for softmmu and linux-user

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ce43a306f8..2e2273b8a3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -462,7 +462,7 @@ sub top_of_kernel_tree {
 	my @tree_check =3D (
 		"COPYING", "MAINTAINERS", "Makefile",
 		"README.rst", "docs", "VERSION",
-		"vl.c"
+		"softmmu", "linux-user"
 	);
=20
 	foreach my $check (@tree_check) {
--=20
2.25.0


