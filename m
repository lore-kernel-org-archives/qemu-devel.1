Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4641C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A959A206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="plTMOdOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A959A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLui-00045a-Nk
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLtn-0002nr-Qo
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:48:07 -0400
Received: from mail-eopbgr750134.outbound.protection.outlook.com
 ([40.107.75.134]:42296 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLtm-00087Y-35
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:48:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBEyjAVQ29h5UulgMrCOVnxhPP84/VzOvySasRIcMBBPMhYmhtMvAbMkr52xh2ojQKdwOxELZ6yTS8QvH6WJVHTlPWgwUj/Hr2tc7pvRrjmf+oW6+GqwGynAmqx4CCxZA4u8SQ3z8ps+E8XdciDtm1RF9zRK/RAlD87CdF0cZRNSAt2HfhCHnw87qhgMuJt6Ht55lyxV/jlYFy4gXSlzt6j6LBh2itmSszD4g/GsCcEFy1h1d+Ra/PoteflfzFtWR1De2fdOK4jklEOe7HnKWVae867JXze4dfBfmcnUw/bJdzCUtai3GbitYh0BQBpHE1kX80FyN9zf9++RkwzFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX9qzyTh8nX+O+pqH8+xs5jZxczBKR3q6UPSSmowVTo=;
 b=HcdgXqTzsP6KQ81JtOzfEooZEhM/165klHaPr2wm2VvgB+rxflpa2D28f/KrGTJB4ACSnKNdbAy0qqDi7AbOWcVR25K7pEg5zNW2OWbzXFaUJEYTCn8ia0V4+m0/nJCZLwr5qkhGx9jUHsrcJIrK7EFeRv/uz1bJaArpSuUr3uzZgexy6Hn53RptvLKbGRrN5DxXA2P/lODW3wJwSe+LWhS0psJdlOdEe1reVLB7CEJ1Z1PbIEBtBTQ/pKdu+0aN/iUpe6rH+ufpCCaJHRLHpxpDWw1YaFe8HfW5D1N3NwJsusFDFImmqHvbY/m2cNMPQPYwjXo7puH0APFcKzIkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX9qzyTh8nX+O+pqH8+xs5jZxczBKR3q6UPSSmowVTo=;
 b=plTMOdOnANuicn8vvNYI1WpXB+Uu7YAHCokOy6g8U5XnrM8TpYgqM5OWVyxCFoyOg3hDe/T2p2g5JE5eRukQ74K4SstoEeZm0KkePFqfDNMmdiGvWTAQQAspjjWXzUJceKzJeCfFfpHXEkHVADVsLuJZ3RSLuEwEvImAkerENWI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 03:48:03 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:48:03 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] chardev: enable distinct input for -chardev file
Date: Mon, 11 May 2020 23:47:49 -0400
Message-Id: <20200512034750.5773-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512034750.5773-1-alxndr@bu.edu>
References: <20200512034750.5773-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:208:1b4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Tue, 12 May 2020 03:48:02 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb5040fb-1f9b-4268-d7fc-08d7f627459f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4368DDF2EB7465A883F2EE27BABE0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAT8LYNNPvGkFBB5x/D48SdYmwijs5MTTb+/7F/vYF8HPrD0Y5V1DzT9h1ifoc74uLul51u8HKX8VwNE1TskwfexoAJMd9O5WUWRwZV06oVHj14Juwa1ABH8UDMupO2wQy4K0WxXm/vWWp97gJ+7PpkAFWGznTFYeVitQUENid4ecFJDl53/46D79VEkCH+dmNvW78W5DbohNpqIeULv2LqHrOiQCAMtKnDoBxetu6M5Hi21sCN2OZt+3FFRyiBMm4L5ox9JNpEwvOw/Dj+sAqULrz/pCqLq3oBSM13+frU9Dlhe8vCJq2/BjabdrYqa/vUSrELcm5mLny7nEL9nAR99ZetQkxNS/0B7a3W0e/vaXzB3chg6U0s3eNjZpRDaDu4kUcjfGUvxc/BgqI/wPM0gRqcvROtLLqX72zHeiBEt+2MxC+Z8o0aVpuWgcZLtnTK+Z231cGMVodp9FF0z4vzdt0IkXMIuVnimW1HdnUsxGy7k+eZwk/OfmmCM4wPTwaC274UFy+bag50YlUiYnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(33430700001)(6916009)(316002)(5660300002)(786003)(75432002)(16526019)(8676002)(26005)(66556008)(8936002)(186003)(66946007)(6486002)(66476007)(86362001)(6666004)(7696005)(2616005)(2906002)(52116002)(33440700001)(54906003)(1076003)(36756003)(478600001)(4326008)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wBpLA3gjaJAhKgXvezz7Lj9p0bOKSi0DDW8BD6x0QdjRI/nIAeljE2Ly4uVKnPU6fKoA7J9LUXe8EVO5Ms724vA7NXVx0YczRiZKVAC+YN/vtALq/IhFbzmHFSKtlOflht1eif5gLpLkxKqrts0hJzLLeQRfsrtOsVN9/aTsHZ/vaa3ex8QjiXTUP5kH7nMdYSJuVk9qaQ07VvvgRoVmatcpc2ilSHh+P9eT8rhHL+18ico8qL5+qGC5jT7vjDqh1qWGXxgL33zWSPODf39vS938t2Jmg1rob9pNpg5iQ/eis7j5aNKp5e035JtQUKputgTBtM0ckWOn0FyhYrUmkQxbjrM2sx+6Pi9YkTyeLmI8e/++smPyitLTggjyJsqEYk+lWMGy/z2Zox5Gpc0fXY7esLmiti1Upts4odLE+qgwAGBSgpjo6mdT7M4OdQP3USDnllmabU9tdiOUrkWpf/EkvOLYZMcpR8tQst0ExwE=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5040fb-1f9b-4268-d7fc-08d7f627459f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:48:03.0354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eupur+RWYyOgjWckXaqA/OjGvGafh5PG/cWwek+VR98VNnInFoEd7jBrA4HnDzft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4368
Received-SPF: pass client-ip=40.107.75.134; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:48:04
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
 darren.kenny@oracle.com, bsd@redhat.com, marcandre.lureau@gmail.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
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
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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


