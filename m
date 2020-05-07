Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A066C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D322075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="jHQ/4j8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D322075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWZzP-0008M5-Ag
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 02:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jWZyX-0007RS-1Z
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:25:41 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com
 ([40.107.68.113]:50820 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jWZyW-0003wQ-55
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:25:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh0ghTEs0sv8qTimlMQCzKR4vFyILg6xIM6RMcWq6eym7VWi7AV6jDyBLnRbP+PewN1PW0dlpcxR1WHEtXeqb8JAsW2tbTy3N/TERYZ+wR4un1uehWENUIrNSec9YDkJevhFPpZAIY1nMXPaCX2D7RZDJ+3t9nT4H4tRgbeUws/fqjN3typdHjNJtwEazPRX3HJPEmBEV4TVlRQh6V+qIALlgMkEuu3U/LqOwSdUXYK5/2ZyUdCeM+TnpTFEfroQx1V0CT+7NhXkM8nbc0FQTG2V/yUSBF8lzAgJZdDwKeVfr4NTU7f+M5IGYB5VAgsnGOJcy5yTp/Qfve6oYYhl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/fcKKS8BTR7zBVJiQLnJqk4l0RfdmKf1n1EIVwhEM8=;
 b=nDloH4+tYhBxSCWZlMZ5Il4Y9Ie27sSjyaK25MHwQ+Gk+EaEZRJQRgoThNNTS21ZdA6uxl9EHU1SNckHG9oZn3GN1uKK9n65KqF7lW1vGc65fNFcJ4ZTa0Zeh5tnkATsGGkvr+EmuZbX5sZ4273UJVCggJ7gerEcWWk0fQTsYJPnn2Up2fQ0s23uUNAKlQ0rDsvwlYUszqUHuWBA+7V9X3ELN45WzMB5C7sHBmlYElWxSIqfnOdHV8IrKNNuqab1aEASUtLOiXxuvXPD8/toD2SYYNshPskIbv8RFKb9uj19lzD8jFQocZACM3qUNGoyPuz7msp86vqWKRxH3SS/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/fcKKS8BTR7zBVJiQLnJqk4l0RfdmKf1n1EIVwhEM8=;
 b=jHQ/4j8wOjDBd+aBN08PH9ZHd3DvXMBSj0Ve4hs0gGY5GMamOT9PKIow0MKO7RBjQs0Z6mlcE+iGZpvZGOxW0H4RtKm9YdJXd0W3I8camBNC6U+b+N7nClF0QFFde+MzqO9RLUgZlfBU/GgJhYcIwfz6WhdsbE21aemTbTBi8po=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4591.namprd03.prod.outlook.com (2603:10b6:805:f6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 06:24:59 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:24:59 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] char-file: add test for distinct path= and pathin=
Date: Thu,  7 May 2020 02:24:42 -0400
Message-Id: <20200507062442.15215-3-alxndr@bu.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 06:24:58 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e92c92f-4e17-4413-4a8c-08d7f24f5de5
X-MS-TrafficTypeDiagnostic: SN6PR03MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB45919C7C2095ACB5A1705E8ABAA50@SN6PR03MB4591.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANp/hQcw0wZgaMPc3gLicNnsspw8Y6oBx1hr5h3jee6Xxx+UsVl5ZHDbbuYThvHBlMu+w48BmDZcCXzAuf9HsbLP023QYGHlnlQqClNb2EngJmmvLlcCHIAtANgXJTEPfVw2M1RrtkaBJCJVBYYl7PcKvJKh7PaqEy7nNu9KsMtYyYmgDlelkeKqUysPIaKAxPlI5WdmMGpu8EdTqcYRSY2CERkxvUnPvEhFQtwcA4tOZpOqOkrnfz3RHAaympZsVrMhpuzKQHJnAhp9b/+hS2LbTRNXE+OAnbWMk5AYzKVkrBwiuhAqBfoozjPyopMgYEBiJfCLlJiTINQknfeGLlU0RSlPjrTXYHZG1LD77ge/FKJBBDy88+OUWcQmKX+Tad3cYTxhGgUIi2uN9FvohkSdosdRG0v4PRIIkumjajjNTzt2NpaS9lXK72vvjVETRNpX/CHclqDmuQzAy60s3cpMeTX4v4gvNryhXW64g2gtaPAglxVV9XM9RIerSacOXPAGDSA04Vo+Y2aLYVmdJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(33430700001)(33440700001)(5660300002)(2616005)(478600001)(66946007)(1076003)(83280400001)(8936002)(83300400001)(83310400001)(83290400001)(83320400001)(186003)(4326008)(956004)(6486002)(26005)(16526019)(66476007)(66556008)(36756003)(8676002)(6666004)(86362001)(6916009)(75432002)(7696005)(316002)(2906002)(786003)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 01/gY8Yn+rBYcUrn+Rna5Ds58HS8hO7ABYfosnRZUM+Pn5TCNbUhlL8xobl0wcEntYKuyUCURscZzUsep0rSVLPCcmA6XOGg2Bh28F7v6SVAl0Vd/qLVxS84WfIyXqNmGUMVVnr0+IVrVnbnyn5eU/IOkCba20fv4d92+HInOGVeY9ouf+gK5Jqcl0KaD5HUFdAYeG52UkhnMKUmJv5bizvmaL8i9iCGvQLpaaz5ilX2yN0mlG52vxrKNd6A7EeN9vrwhAls9JV7f4O8yoINbUXzBnLj/tM9iH0SbBfYlpGDXKlnhXhL2w0a52CXIaP5U/JbmoUm77ADOlpmkeDyDL4to/qea5hrspfZOIGIaGUqIyzAdqJsVcBid2oSmfx7hpIyeX+maKA2FQS9oq0b1X3ikpSfxITz244quaOQqeBjRSBthd/A2925ppeLm9iHHgwK6akOYLIf40/SxVMQqLWtryFAPvmAT7u5GRVAKWu9AIqdNxJNqYwtWe+Jp/YF0V37xwzmW1Z8uyKpAAHBoBMSqt5rkBKO4nwyKavcuiewQrjSPbUSmHm0jK1SQgZgcLcG4HNfOn5Z7IoDV4y9pSQY99sc67F6+PbMr9AvsJYUw+6TLAc0jE7ceMfauevuDXKcBUSS77ARDIk0K9yL4ZhtLcuXsWyN8VFsFaLKrPk3gSDhJjPT1M5bGRPg1jBGJZsxhNio9ASm15ag/xM7TrQ/MrM4ro1yMm7QhNivpucVRU5vxLJMQatRpUbSqB7UVfljcWC2XuOLYIyVNznXtj0fYvx70UNmmpVtk/Zuel0=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e92c92f-4e17-4413-4a8c-08d7f24f5de5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 06:24:58.9719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok/heLd6oIO+tu11HYEUOV2XJHOMrcHMRLwjP+3D7/xsPOQ3sD3LSvr1IzoMouXE
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
Cc: marcandre.lureau@gmail.com, berrange@redhat.com, stefanha@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/test-char.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 3afc9b1b8d..9b3e1e2a9b 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1228,6 +1228,88 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
     g_free(out);
 }
 
+static int file_can_read(void *opaque)
+{
+    return 4096;
+}
+
+static void file_read(void *opaque, const uint8_t *buf, int size)
+{
+    int ret;
+    Chardev *chr = *(Chardev **)opaque;
+    g_assert_cmpint(size, <=, file_can_read(opaque));
+
+    g_assert_cmpint(size, ==, 6);
+    g_assert(strncmp((const char *)buf, "hello!", 6) == 0);
+    ret = qemu_chr_write_all(chr, buf, size);
+    g_assert_cmpint(ret, ==, 6);
+    quit = true;
+}
+
+static void char_file_separate_input_file(void)
+{
+    char *tmp_path = g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *in;
+    char *out;
+    QemuOpts *opts;
+    Chardev *chr;
+    ChardevFile file = {};
+    CharBackend be;
+    ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
+                               .u.file.data = &file };
+    char *contents = NULL;
+    gsize length;
+    int ret;
+
+    in = g_build_filename(tmp_path, "in", NULL);
+    out = g_build_filename(tmp_path, "out", NULL);
+
+    ret = g_file_set_contents(in, "hello!", 6, NULL);
+
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "serial-id",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "file", &error_abort);
+    qemu_opt_set(opts, "pathin", in, &error_abort);
+    qemu_opt_set(opts, "path", out, &error_abort);
+
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+    file.has_in = true;
+    file.in = in;
+    file.out = out;
+
+
+    qemu_chr_fe_set_handlers(&be, file_can_read,
+                             file_read,
+                             NULL, NULL, &chr, NULL, true);
+
+    chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+                               NULL, &error_abort);
+    main_loop(); /* should call file_read, and copy contents of in to out */
+
+    qemu_chr_fe_deinit(&be, true);
+
+    /* Check that contents of in were copied to out */
+    ret = g_file_get_contents(out, &contents, &length, NULL);
+    g_assert(ret == TRUE);
+    g_assert_cmpint(length, ==, 6);
+    g_assert(strncmp(contents, "hello!", 6) == 0);
+    g_free(contents);
+
+    /* Check that in hasn't changed */
+    ret = g_file_get_contents(in, &contents, &length, NULL);
+    g_assert(ret == TRUE);
+    g_assert_cmpint(length, ==, 6);
+    g_assert(strncmp(contents, "hello!", 6) == 0);
+
+    g_free(contents);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(in);
+    g_free(out);
+}
+
 static void char_file_test(void)
 {
     char_file_test_internal(NULL, NULL);
@@ -1398,6 +1480,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
     g_test_add_func("/char/file", char_file_test);
+    g_test_add_func("/char/file/pathin", char_file_separate_input_file);
 #ifndef _WIN32
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
-- 
2.26.2


