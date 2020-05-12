Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CDC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BECF206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="jFGWO3wD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BECF206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLwg-0007nC-LF
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLtr-0002um-Hn
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:48:11 -0400
Received: from mail-eopbgr750134.outbound.protection.outlook.com
 ([40.107.75.134]:42296 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLtq-00087Y-2d
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lijSEKWbkqIEt4noTkxQVUlTP/Nk9qU7raAtNalnROl13Wk5vP2nTWcyHeQTWWoQZAg6DSLI8jA4bLNw+zxPlD7GFcfL1/Yu9uL5npaoa7SinNvzc9DwXey6dS0SUInRsfTC0EImHbkm2UcVe7RTDiS4WaSxZ/DLaI/gzGvxDc55HgF0wBSe6t2othBHOWszwzL6ogxbK+9Y3GfQejYjCaTM1Fj+GIg9dvTiHh2gBojf/U8u3EpA31QBdUkFBoiDg8NImWPqImPt+aAHoV4lyGyU10Ny9tMspniaj7PdnLcgEvmkiH8OpmUPJuZC8pWPv24VPF11aO36IFT8sNkmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k6wgadRoXlucyxXGAL5yKPn/+NG/tNvMvJWmAIS2Rg=;
 b=mNLWVTdAWFrsvtNpVZo87QXP4nzYw83LwvrqWePLI1RGYGwjNguYJOjlCkQQPCzMG7g7rD3y8QemJVJMRXF3YCjfQmVZ0lIwVA3EZVOLFTD3YEPvozAjXfVSGe3uJnNrZG72c5O568tz8xKn/OHgdWhFY2ThFAV2rIa4bj8tnEfjDE+tNr3sKIrJITepDzBFR3oI2Eq7XnaYFAZNpsFvY0L/yFjXC5Pz7Ra7IuKi6LzjwM+y5bOYKPa2qSHubel3h/d9Q/vmVrHEzbS1WrY3BXXqOi0UUvTHeJWaMTsyFB8TwmC5BywqljTWkbhbcTAz7OZZos4hfXTD/il9eJ6D1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k6wgadRoXlucyxXGAL5yKPn/+NG/tNvMvJWmAIS2Rg=;
 b=jFGWO3wDTcdnxH120XV1cdvKJ31ZSayLaR26RTTnuZ0/H3enyrKv29q47eNXUit726BPKr5AawIX6bjlDlIa1Th9wvU63YgUU7cdLIjMbe90liJ5JVOgR53x856RVP0n04sQGHWmdh/5pd4pE2Knhpp+W8tlNPzrfVAp0PCvRMo=
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
Subject: [PATCH v3 2/2] char-file: add test for distinct path= and pathin=
Date: Mon, 11 May 2020 23:47:50 -0400
Message-Id: <20200512034750.5773-3-alxndr@bu.edu>
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
 Transport; Tue, 12 May 2020 03:48:03 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 979ea051-6e0d-46b5-cabb-08d7f627461f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB43684481014258F7194EAFD8BABE0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB7jUvGyOlxyI4seWqWxr83dTKavWs+8a4ecsDwsJTIGzPS8Xs5zsar/rYFOkfJMo/t/haCwSDrIFZVF18Pdvr2MUenVsLc2+faoqYgOFSHFYGt4b0oPaE9wXNNeNGaamwXuKaCkofFKvRc4u4qGZm/i4oyoTLHe8QjKBNeV3GtUX6HLUMFjST/yzenmV37ZLCFvBQUQiw+1BiUWNJm+s4J1N9/HmwW0N5fy2CEXC7Fv8rLylRWsGfOZxZka0u0/gwRcCaC7JcOi9RBXso0GRNsa46q1EgnAiEs25k6MWAEn+PrRf9AGA/SsyltLXKX6mGT5qpfd7qyga7H/e6vl7VspOxtYxHM42LiE7fDFEvGzdmH7EckOKsW9983xEb4LTlD549VnYICuC+pFAKRdPe4eOTmY4T7La42Y9IN+/XMyKjG0I9y8TnZD1wUi9G3cVSBUgjWumiyOdfJHJu4S8zDhi5KJ9VCJgm+wMo3hCLCdE4W5WleJeq3m2SFutpCfsEhwxDdN8QS9uCdga/AHfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(33430700001)(6916009)(316002)(5660300002)(786003)(75432002)(16526019)(8676002)(26005)(66556008)(8936002)(186003)(66946007)(6486002)(66476007)(86362001)(6666004)(7696005)(2616005)(2906002)(52116002)(33440700001)(1076003)(36756003)(478600001)(4326008)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7vmMqisHwbGHcW9UPMY8sZchwcCX5bduwvhWa1xBT43Zu5a6snqqatym1+bpl8eBti7QQpv2oDf2yfWomvNZmgfCss1i3n/BtLR7YE/lH/bwdk+nWuQIZwoU6l6CpuOw5I1nLHYzJBWjY50DqLOHfrGWDPzvWOsvQdoUL9wTINlVS99oLYkBStWEAjPlrcmt5yHMuw/pQoYBMUfI8NFE1LAqyFHr3mmLdVuLuBlyTj8EvUHzW838NhE+pimBl//KnkKRvsx9Zckw4rRXQvIfgEeO7+8v8JY6ep6C0fwYV4njtGjSKcM1mhcKur6AQXx2mS/sdtWLgy1MtdkiJXGQaDaG6O+nkvJAGZ55ocbT5fY5RPwxXFxe8KdgJQoXhOknmHwqoI+jej+T7kH40quqewzLTucHveU3VzKGqu2ma0IWLdJqxu6SJulyh8qYuCyB+tI/t6floETWqynd5BOfwBVSWapNzkG69uV891aVw98=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 979ea051-6e0d-46b5-cabb-08d7f627461f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:48:03.8639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ay6qhZqkBigNYI6+riu5QD/Q/nhM/usB2RYMzwcsallQL4f9jegyvs/xVnDdiBL+
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
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/test-char.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 3afc9b1b8d..6c66fae86a 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1228,6 +1228,101 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
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
+    ret = qemu_chr_write_all(chr, (const uint8_t *)"world!", 6);
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
+    time_t in_mtime;
+    GStatBuf file_stat;
+
+    in = g_build_filename(tmp_path, "in", NULL);
+    out = g_build_filename(tmp_path, "out", NULL);
+
+    ret = g_file_set_contents(in, "hello!", 6, NULL);
+    g_assert(ret == TRUE);
+    g_stat(in, &file_stat);
+    in_mtime = file_stat.st_mtime;
+    /*
+     * Sleep to ensure that if the following actions modify the file, the mtime
+     * will be different
+     */
+    sleep(1);
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
+    g_assert_nonnull(chr);
+
+    main_loop(); /* should call file_read, and copy contents of in to out */
+
+    qemu_chr_fe_deinit(&be, true);
+
+    /* Check that out was written to */
+    ret = g_file_get_contents(out, &contents, &length, NULL);
+    g_assert(ret == TRUE);
+    g_assert_cmpint(length, ==, 6);
+    g_assert(strncmp(contents, "world!", 6) == 0);
+    g_free(contents);
+
+    /* Check that in hasn't been modified */
+    ret = g_file_get_contents(in, &contents, &length, NULL);
+    g_assert(ret == TRUE);
+    g_assert_cmpint(length, ==, 6);
+    g_assert(strncmp(contents, "hello!", 6) == 0);
+    g_stat(in, &file_stat);
+    g_assert(file_stat.st_mtime == in_mtime);
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
@@ -1398,6 +1493,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
     g_test_add_func("/char/file", char_file_test);
+    g_test_add_func("/char/file/pathin", char_file_separate_input_file);
 #ifndef _WIN32
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
-- 
2.26.2


