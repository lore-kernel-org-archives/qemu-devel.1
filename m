Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A48C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2A52075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="MM6FI8v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2A52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWZzO-0008LI-FW
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 02:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jWZyV-0007RL-4v
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:25:39 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com
 ([40.107.68.113]:50820 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jWZyR-0003wQ-GS
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5NL2JlfUFpOdnejq3KD77FfZ1jtsFTQJTm7DnVn9L2Uj0xmlv+oqGnbAaS/+itPbZ1MDHMc0xxGwUdNU18vRMjY1kN0aI9m8/s48rvcZKgt76WJqhGRXtd5I7bPEfyidRih0eeFzcXOZrifb99P5CWEDnYf1cs+GDJdgKjlBsOE5yF8v2PWE+Kj2ot9I0hbUuU7Miuo7WHopq7k91N/lraQxGDVXt6sP/GRfA8nUAYAZ74DLHlXSz9elywcHjRL/cS3baOQUxckon/OLM6dQA+PleoHz1VqesVL8yk4GZw3MXnqn+b6myclWKtcR4kqVCkkmW8nTCfzMn6EW1yUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28o2N1cLnh6R4oKLC2EdwvxWzWU5Sjt6kB74tupUqmU=;
 b=MeEWNLVxqNQe2xlq8mmPbh9A40r4CHwJHfOHOXF1f4OBLOfW0NcWEp4boS6Ec/vUcDNJbtrtrPhGNr/epYDOmW9fDsNLQoOoKVsRpDMNEyazzbv6fhAqAE2nNaaKpcRLrLKJFjJKrX1BjtO2y1/QOVkax64K09/PU9NAf6e+MC75zBRHBALCwLrzHKhJnRdO3DCd2lBehuH7+9/QZHcRJ2fMsT6KdE1Au3KsQjzXO+GVdF2dM6eWXImnGtCjr4ZeA/qsdmoCh35a9hqcNLhSENe7J9iHp0O3M9RrcqTuo9szuU5DFaTceZIcXpmZCJXDab3jB70rQn3YNvLXSIkHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28o2N1cLnh6R4oKLC2EdwvxWzWU5Sjt6kB74tupUqmU=;
 b=MM6FI8v3I7uozAj6QUFiMSy2UInETN20oHwWjiItcaudgXTH5s/RIYlL3sqnD9KrwoMRknWy1P/fpayFLecPqEWCVGlF2s7vOeRapVuAxpvc3Um7z7LckG/H9tmPCmkBlih6Adte5QhCTLHTguJnRGr/+CxcyUoqXyLtQzOFtfQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4591.namprd03.prod.outlook.com (2603:10b6:805:f6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 06:24:58 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:24:58 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] chardev: enable distinct input for -chardev file
Date: Thu,  7 May 2020 02:24:41 -0400
Message-Id: <20200507062442.15215-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507062442.15215-1-alxndr@bu.edu>
References: <20200507062442.15215-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:208:35::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 06:24:57 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24978b55-ffa8-4ba7-349f-08d7f24f5d6c
X-MS-TrafficTypeDiagnostic: SN6PR03MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB45918E192883FC0B2F3AF91ABAA50@SN6PR03MB4591.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3XhmBPUNb1VncfH/i3USSbVpZ5r0MX2MJEZtbVg0W1Cg4e2CUum0ruAzzuvrBdHfrpkKryftPXZl00TUXYRg5zq7bvrR/6EZWK4kR+KKHnCNhugmGvUs1Fuxi3t3orwtBSM3SZQ0rKsFQ791wFx4TQF5umP/fJK5oNk8MwlWtAs6ZMzrlNOWeX/KtWRThe5HuNKMoFezxo7v1bftw1+IUV2q9SfQI+2UMFtNEcy+OY3LLJCmyYNnq1/saCtqpidvKcMR/EGHHYRpZBrwvNOjkb+CbDaIQWbV8Vbj7XCJ4dcdJVLc37SeeKlUl8p/vA2UmtWjdSPNNyFQ8ualjuwzvUWqnakHQ2v2NKYI1LQWAlq63TFWFMZM17WOLY1KKCK0QZZ7GAGuSgl5f9HlRwF4+z1slYi/k/aBnEuJjHeMxXXQzHlp8HYFzMD4YMeYEhvWu9zlRistEdkYd964S0/mRJDsEDpXWP3z/z1/lbFSCexMrv6gBkKGuNojOmNsjpuA7apJm15pdT7t+1mA2biUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(33430700001)(33440700001)(5660300002)(2616005)(478600001)(66946007)(1076003)(83280400001)(8936002)(83300400001)(83310400001)(83290400001)(83320400001)(186003)(4326008)(956004)(6486002)(26005)(16526019)(66476007)(66556008)(54906003)(36756003)(8676002)(6666004)(86362001)(6916009)(75432002)(7696005)(316002)(2906002)(786003)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FJwd3dPy8tr0F2pZhgD5MxPOLpGufLy67Ehdn+gwEGce5sBM4e3GEXJ5iN9NTMBI7nORcB31c95oog8QF2X0TB4/MnS3ePCB8W0I+yizX4CJ1cu+2vEQzIU3rglLeT5LAhv+gb6jc5IRnXdXC2vgy3AeobKoaTvDUR8pnUETaxnGJcrBnhJvPXZ8ljuyLBjB38WzY8W4mQYGBadeGSkh13AnLVRtNMohlO1y0Dda1FTrIAd0PA9dj+5kvxmfdqTVCHA5YpQ6yOMr4l+LBaI4s27u4i9s5NbcJItQNDlH2NBwOMTk0Q5Md6Vj9/t68cv56tMjP4P330/+cjwXEjj+Gfa3TUbPqEs3MFpYKXag5jxrxzo9y2Vo5dqrOYOxD+Xu7JRWlxUSsO9ql6+03UMILHx5QbutdPgfFdlCMY6Df4i0/+NDcwE6j6vO/htht6w5RvgQqIo9xaXfVt1dk+pUTUdwuBZzr7XbJxInxV+2EzDI+P9MKEfdy0l7tEd4B/zt1t+EYI/p6cUFo5imn0yDItvWP+nekWH7NRsmkguJXy0MjUtpYXFl9cT7WpNP1rHARoNCf6jCVArsXbP0tViEp4gZYHMFzWqDNSc1papCFdIDJGZMTd8KCbDXEiGc8x8GBQ5BVogehJ95OeALZTcscIRPt6eyzXVB7EwNGsQI61wt/CvVQtvsuxylfBSCNqaKgB0mLTWw+hMTHJ7bOREjFahbxqE9Zv8hwJwyvkASNG9w9ndxXsH+IrNF6Njyq5OKClZl+q84yz6WKofpftpqCCzXjoaLx5ULX6d2Y0g747U=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 24978b55-ffa8-4ba7-349f-08d7f24f5d6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 06:24:58.1384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv08U1ekOEu35Hz5tcS/a4KyRSXGUgK0+ki9cDHi4pj7NDreo7xRVAUWgsPSmD7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4591
Received-SPF: pass client-ip=40.107.68.113; envelope-from=alxndr@bu.edu;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:25:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: berrange@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 marcandre.lureau@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

char-file already supports distinct paths for input/output but it was
only possible to specify a distinct input through QMP. With this change,
we can also specify a distinct input with the -chardev file argument:
    qemu -chardev file,id=char1,path=/out/file,pathin=/in/file

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 chardev/char-file.c | 5 +++++
 chardev/char.c      | 3 +++
 qemu-options.hx     | 7 +++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/chardev/char-file.c b/chardev/char-file.c
index 2fd80707e5..031f2aa7d7 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -100,6 +100,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
                                     Error **errp)
 {
     const char *path = qemu_opt_get(opts, "path");
+    const char *pathin = qemu_opt_get(opts, "pathin");
     ChardevFile *file;
 
     backend->type = CHARDEV_BACKEND_KIND_FILE;
@@ -110,6 +111,10 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
     file = backend->u.file.data = g_new0(ChardevFile, 1);
     qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
     file->out = g_strdup(path);
+    if (pathin) {
+        file->has_in = true;
+        file->in = g_strdup(pathin);
+    }
 
     file->has_append = true;
     file->append = qemu_opt_get_bool(opts, "append", false);
diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..97e03a8e48 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -849,6 +849,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "path",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "pathin",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "host",
             .type = QEMU_OPT_STRING,
diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0c..488961099b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]\n"
     "         [,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev ringbuf,id=id[,size=size][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev file,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev file,id=id,path=path[,pathin=PATH][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev pipe,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
 #ifdef _WIN32
     "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
@@ -3137,13 +3137,16 @@ The available backends are:
     Create a ring buffer with fixed size ``size``. size must be a power
     of two and defaults to ``64K``.
 
-``-chardev file,id=id,path=path``
+``-chardev file,id=id,path=path[,pathin=pathin]``
     Log all traffic received from the guest to a file.
 
     ``path`` specifies the path of the file to be opened. This file will
     be created if it does not already exist, and overwritten if it does.
     ``path`` is required.
 
+    ``pathin`` specifies a separate file as the input to the chardev. If
+    ``pathin`` is omitted, ``path`` is used for both input and output
+
 ``-chardev pipe,id=id,path=path``
     Create a two-way connection to the guest. The behaviour differs
     slightly between Windows hosts and other hosts:
-- 
2.26.2


