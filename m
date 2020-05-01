Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9144C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994DC2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3F2qLGL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994DC2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZRJ-0003Dn-LW
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jUZQW-0002Uv-Im
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jUZQV-0006WJ-Bd
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:26:16 -0400
Received: from mail-bn8nam11on2098.outbound.protection.outlook.com
 ([40.107.236.98]:57121 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jUZQU-0006Uq-RL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlbTkBwzDOyPV8mcmlANfbLpNH5/VCGkfrE3Q/WDHMVWuJPQVau1qO43MqbfRuQxdRUYU8CYfcXbDqZZInxPrvp2weDYmt6sIEMyZoVOho4q6w66f77MrIsrdGG0py0D1WF3/lqGMZhAvZz3JQLO4VZ/RBuiRrM11gNX5QaQrDOIY30xHSp0pbMRr3qSuIx8MVvgKv7atAFtGAEVxaxEzkpKyP3nfqwUUp5zjh2tBZtyMH+7G9XWXLR6CAIugX2H4Jj8j/0c/7OgQ9Al2iFHZRIGpF4G+lbnx655FfY+Q+NbIsjQq7db7X05VEiAGnR1UE6k7gN7usfSndQSGQbmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVxZYtRAvP/ya4RsQL938e9VwdbTPtHp82Z0jWH8Xpc=;
 b=Tq2eZwWshZYNEFdwKittWWxWlJb3+pxIq8N3zABN16jWrGnSLaD9Dkoofm1sZk+rE7LiE4e3uGYP2Ye21PXkI3j3in33iX0nxunI4brSEyLbgK9yy2ykm0MS7ixDa84vSr934nhuEmgIG+oviyuHEdHlnRmJeA1KX5n80z/90Vrwx66pqWvBvFF14oret8i+IKMl62eQvwV04cZcOFz3ni/u9OCrfnAchZZ5NOWgB1MGo9qNRdA+qFSBSag2l8Ix848uI/+UoIm6d+ruSGi7n3kGctgLrxpTof5q+T8y1H/PS3MFDo/Hm/c2+uezBrdms/ENzu1k0E84ntMKQLnRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVxZYtRAvP/ya4RsQL938e9VwdbTPtHp82Z0jWH8Xpc=;
 b=3F2qLGL8ZwyDkVs91D75zaBG9cOb1ljIIqDeQ+UgMfGdo2r8bRzEqvMjxEGwgjbBrumYTLZmpBls3Tcu6J+GDFa6S1dCpRQtKHA9Wh+NNTsWy892Vwt32MYgJYkQh6+CAHxjsQJBiSRUEzTLlmpUB68wFGnOlktDPvrxBL1tOGM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4416.namprd03.prod.outlook.com (2603:10b6:805:102::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Fri, 1 May
 2020 17:26:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2958.020; Fri, 1 May 2020
 17:26:13 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] chardev: enable distinct input for -chardev file
Date: Fri,  1 May 2020 13:25:59 -0400
Message-Id: <20200501172559.6470-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:2d::16) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Fri, 1 May 2020 17:26:12 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b720a4d-b2a8-494e-a3b2-08d7edf4bee2
X-MS-TrafficTypeDiagnostic: SN6PR03MB4416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4416EDA6AED871B770C30169BAAB0@SN6PR03MB4416.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhaOuRS9iWg8n8BnwQT6f9UV/6Wz/Nte3SojDfE2ec/8KoFs3bICBQ6r75vEJu0UsudtapVQVhFqYLxGL1RM1/Xn8DtTfHokm80hgCHFNg2NezZqKI/gC/XW42oS63iOIweAGHlGTNoXC7ZQn8yWVcwc+5opUdBzfycBTEwkgTWnl3wY069qV/8GQZuDX9uZh4ZMtWuh+dD4INrFiquKgF9Xm0d3cDk+qsAtzWNNUl63ynqlk5ALtxg3N5fb0PH25JkNPMtpaAksDOOpmnQkn/p48J/rZ7ugzLEKXeQEIjsn1btVJr7Gg2xkd0w+GtAh6QrBfDjqQCfUE7NPfYR/1qxXuyHYe9SWoz0C6NoUVh2J0/ypzRFKROBldzouMDAPmJrmhAew0Xg7kASD2YU6YzuRJy22cgiHdUST8DRVA8DZuVzexjFv9fXO2HfeooLx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(75432002)(54906003)(8676002)(6666004)(66556008)(4326008)(36756003)(316002)(786003)(66476007)(8936002)(66946007)(6916009)(86362001)(1076003)(7696005)(2616005)(26005)(52116002)(956004)(186003)(16526019)(6486002)(5660300002)(2906002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6GcT3360KcEPf3+wgX5cxxcrw69DQkrB4QcbAyM0ghYTqc00/GcbAKdcvG708nib4Gw2w5mSRDHdR11d7YxIv+P7L+nJ4Petqjw5D0MYe0+8L4fz+yWrd9lxOhq+uYCtXUR4Sh6Y1R2ZczWyewNuSvlzHKBvPT0flOqIcKghpSM3H9fgcWzaiAJNuh7JTiBVaULpWvshHnwZgjArojMHMPpOP2W0a+U7UY/8kPcFH4wSuRW15Lx3IT5r4YnLH6YpglcFuQUWE2s6ggtuTp4RSUHQJbr4bKEtBpCzFOhdx45StdHTGywNAutA4+VcdK1xavUEYvszwEAKE+irUTh4vclzZoJJ6/FbIziZJZZwK8VP4GYmNw1AmTjz+AojEUmXFP5MYDO4255BjB2/6T+xvUzjg8kgFm8g0h/5cwNthaXovLI1ln/FaqLmZInfy7KCwrq8DfiW6zQ4wjSi76WTtnCUeKoOaJmwiWwl5ybCPlogC/ExDmrHDFQ/551LPhOvc0LUumFMXSACWOuZfcxy3bTHQ7LDjgUPIz17WL7mH8a2ndB7JNrc9/enIM1PvXBBLJgzfhfUHRmOtbYoSRIoaYsmUwcQm97v2eSEeJI/JpWuVfT6TAhUlimrXj3Oop3gLKf3xy4nWhSBJsO1RZh+8nZYh5+XhDegNNXEUYl2xSknPmtP81Z4fX/9Ow9sa8wsdMpe9CvM78lZn6j9laACgHUWLLBeToVjKQH6Z9DNmxFStgQQKmoQvtbozZBAhxOsUY/YRcPMwGFTIezy+GrFo3cSI0XvSgC/c9Tiie15hdI=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b720a4d-b2a8-494e-a3b2-08d7edf4bee2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 17:26:12.8500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iarHORmKgBpHlbKuhmFs5CMPPSIe47/hN58ZXnU1X4NGVX/585Elryssa+b386js
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4416
Received-SPF: pass client-ip=40.107.236.98; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 13:26:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.236.98
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

char-file already supports distinct paths for input/output but it was
only possible to specify a distinct input through QMP. With this change,
we can also specify a distinct input with the -chardev file argument:
    qemu -chardev file,id=char1,path=/out/file,in=/in/file

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 chardev/char-file.c | 5 +++++
 chardev/char.c      | 3 +++
 qemu-options.hx     | 7 +++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

The naming here is awkward, with path= really turning into "out" when
in= is specified, though i'm not sure about what is a good solution.

diff --git a/chardev/char-file.c b/chardev/char-file.c
index 2fd80707e5..cc742cc234 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -100,6 +100,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
                                     Error **errp)
 {
     const char *path = qemu_opt_get(opts, "path");
+    const char *in = qemu_opt_get(opts, "in");
     ChardevFile *file;
 
     backend->type = CHARDEV_BACKEND_KIND_FILE;
@@ -110,6 +111,10 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
     file = backend->u.file.data = g_new0(ChardevFile, 1);
     qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
     file->out = g_strdup(path);
+    if (in) {
+        file->has_in = true;
+        file->in = g_strdup(qemu_opt_get(opts, "in"));
+    }
 
     file->has_append = true;
     file->append = qemu_opt_get_bool(opts, "append", false);
diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..797574f205 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -849,6 +849,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "path",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "in",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "host",
             .type = QEMU_OPT_STRING,
diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0c..bbb091872f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]\n"
     "         [,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev ringbuf,id=id[,size=size][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev file,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev file,id=id,path=path[,in=PATH][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev pipe,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
 #ifdef _WIN32
     "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
@@ -3137,13 +3137,16 @@ The available backends are:
     Create a ring buffer with fixed size ``size``. size must be a power
     of two and defaults to ``64K``.
 
-``-chardev file,id=id,path=path``
+``-chardev file,id=id,path=path,in=in``
     Log all traffic received from the guest to a file.
 
     ``path`` specifies the path of the file to be opened. This file will
     be created if it does not already exist, and overwritten if it does.
     ``path`` is required.
 
+    ``in`` specifies a separate file as the input to the chardev. If
+    ``in`` is omitted, ``path`` is used for both input and output
+
 ``-chardev pipe,id=id,path=path``
     Create a two-way connection to the guest. The behaviour differs
     slightly between Windows hosts and other hosts:
-- 
2.26.2


