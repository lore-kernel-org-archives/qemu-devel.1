Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09BC54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A953820714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tX/IFbQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A953820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlcm-0002Ol-O6
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbm-0000aL-V7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbl-0005df-Mt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:50 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com
 ([40.107.7.133]:6087 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbl-0005br-FF; Tue, 24 Mar 2020 11:36:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfWpc9v03hoa6XscRgPV21VkpsaTgP1EwxHB5kez1544Vt132GYq+IzZAj0+WHYBRjhLvyuIf0lAZsrvMTVxzSqSdyiS1JfqCxsig451u0kldWaiQOjG9d+H5ZXYbMBeJ91oI+/sU5ltOxV9+TY6dYPxiv4j9RvdGXgVAbKg2zZXQYyEHxP7r6Z/3l7G3pDuh6IbnkeZxxOpzd4O4uSMGkilwHCh06tQwbV1YN9akhfqGs2U0fuGL3GkL3pnBvxp58Ag7Fw9IgpWtjnZkkSf9JPL8jcvKjghmFnmMaKj5z16kQcCetW/ql4fuG8o+8Lu++LYetI+nP5j2oFhJ8AgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvVI1rv2dAOmET5uFzSQbNMMIFXMCPCpWSFvcQJ9m3I=;
 b=hSQhLjbXZVUDeK27tbBi0ecd9QBd430S+eWFO/NM0DJyJzXLdNjGIp2EYzciuBlqw21Hg5e5eRFt/MuEYwwfQY4pjVHWX+dR57yQ06AOF25D4mdENYgk/tMVGjBcPEAHz80eEPSM4xkDxt9GLEq5ybARBXU3xDMlhQ3nr+uk/iVKCx3PvghI2QeVy8UwMnNlrZDBZn4UqnaHfQqCiAhMbEDjktQOttcJ/4IXbFQBcrOemLN3RUYSpQeObPe1vxYKjkKAfRAioKhITMOxKqejrgO2zVa+cchO1XYQX+WKfTG+eX4EHcxIzYKXteFxBsgRwO2+kI7j6PI0U56DuALGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvVI1rv2dAOmET5uFzSQbNMMIFXMCPCpWSFvcQJ9m3I=;
 b=tX/IFbQRAwr+nv6pz14+aRnmblW2Cgs9NvITJ9UoWkY9YDbeKwBIaIJPaQ2XXv5KK6PQqvoTlEjQL1iH5zaoQWeGr7XFIUo0z2nnbJ0nua8KqBEECCW/Mh4dRowuu9trtuK4SyiMiycPC5gdokewKqbnvjf4u2crwIeXNSblIZs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
Date: Tue, 24 Mar 2020 18:36:25 +0300
Message-ID: <20200324153630.11882-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324153630.11882-1-vsementsov@virtuozzo.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0401CA0062.eurprd04.prod.outlook.com
 (2603:10a6:3:19::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.15) by
 HE1PR0401CA0062.eurprd04.prod.outlook.com (2603:10a6:3:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:46 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84905608-077e-4b1b-b16b-08d7d0092a14
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336396B584CB91FB1F52128C1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(66946007)(81166006)(66556008)(5660300002)(4326008)(66476007)(2906002)(81156014)(8676002)(16526019)(6666004)(107886003)(26005)(8936002)(186003)(316002)(6512007)(6486002)(52116002)(36756003)(6506007)(1076003)(478600001)(956004)(86362001)(6916009)(2616005)(7416002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5336;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KwKB8WffMk9yRqThFpY0PXLvgc20iw669PxuNihAHW6TOWpHookRfXpUGx2lNo5b8CEyUliZy8MI4TjEMGWHob36kGCg/RkCy1zcPk7fDAWyUV1ReYIXPipWrvuv7dSGUGwihBYr9MkXMCYGYn78X2cIrePViwJuS3ealH36Uzl0URqDxs19iiLEPfqLcb0m0TAjiz7fZjmwgISCCaf9jHOIn98sRrsKtv6bGd6YZfvMavgLuwE7xED0TNoxfCe5dDVu4eKN3r9f2yxZkVHzPzWcR/vjwDWdjYEC8/++s50w1hg7+ZgbDeclAHnvE7/jhYhNpUDIvl3wAihXFX6RwIexLkdWIUX80ImOD2/pXzQeOl9MYidhfkqQuIoY9Sh1Y019iueFoaIIl/0YcCACf9cJLQQRIv2z7kMWA6f0Aj1F8ZtZRHP2/j1L6A2HgpA1jliO/ArELimhgnuHlyVvGLThpGF7kBPhGpwSp2OspGyFx6qd4fV2SIpgBuwLo+IXENH69JNUvfV685400oyrMk08d608X2RKL0gu/nBLYD6Igw7tBAhkPNuN6qkkic4
X-MS-Exchange-AntiSpam-MessageData: M0z1/QwuOUdHIMYjWrFHktcDk6LbQzt7q3grBwk5ElFp5zF3HcEfBMf6cx1JQphLRDsLV3DGrgPMMxPIPKIFYCBmvy7ikR8uui081sEA5Q42LMJX8KDu//gSBaCgihBIZORp4sqfASp2NI8SUcg5Fg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84905608-077e-4b1b-b16b-08d7d0092a14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:47.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU8Xg36GcbHqwnfzQh6F3Ap4X2p1s4jMlfcZ0/nWDRk7zJnmJC892Nj/KU1ZJ+mogyMW1cPF6GIS/0va6TDc9ANOy24bhNUtt+EOptczdrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.133
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, den@openvz.org,
 marcandre.lureau@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add script to find and fix trivial use-after-free of Error objects.
How to use:
spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
 --macro-file scripts/cocci-macro-file.h --in-place \
 --no-show-diff ( FILES... | --use-gitgrep . )

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/coccinelle/error-use-after-free.cocci | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/error-use-after-free.cocci

diff --git a/scripts/coccinelle/error-use-after-free.cocci b/scripts/coccin=
elle/error-use-after-free.cocci
new file mode 100644
index 0000000000..7cfa42355b
--- /dev/null
+++ b/scripts/coccinelle/error-use-after-free.cocci
@@ -0,0 +1,52 @@
+// Find and fix trivial use-after-free of Error objects
+//
+// Copyright (c) 2020 Virtuozzo International GmbH.
+//
+// This program is free software; you can redistribute it and/or
+// modify it under the terms of the GNU General Public License as
+// published by the Free Software Foundation; either version 2 of the
+// License, or (at your option) any later version.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License
+// along with this program.  If not, see
+// <http://www.gnu.org/licenses/>.
+//
+// How to use:
+// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
+//  --macro-file scripts/cocci-macro-file.h --in-place \
+//  --no-show-diff ( FILES... | --use-gitgrep . )
+
+@ exists@
+identifier fn, fn2;
+expression err;
+@@
+
+ fn(...)
+ {
+     <...
+(
+     error_free(err);
++    err =3D NULL;
+|
+     error_report_err(err);
++    err =3D NULL;
+|
+     error_reportf_err(err, ...);
++    err =3D NULL;
+|
+     warn_report_err(err);
++    err =3D NULL;
+|
+     warn_reportf_err(err, ...);
++    err =3D NULL;
+)
+     ... when !=3D err =3D NULL
+         when !=3D exit(...)
+     fn2(..., err, ...)
+     ...>
+ }
diff --git a/MAINTAINERS b/MAINTAINERS
index b5c86ec494..ba97cc43fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2037,6 +2037,7 @@ F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
 F: util/qemu-error.c
+F: scripts/coccinelle/*err*.cocci
=20
 GDB stub
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
--=20
2.21.0


