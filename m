Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7828CC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004C720EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004C720EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvZv-0006fC-Vf
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <780f9da880e45280ce4e0a1b7c72fce618623a05@lizzy.crudebyte.com>)
 id 1kVvYD-00049r-9x
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:48:06 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <780f9da880e45280ce4e0a1b7c72fce618623a05@lizzy.crudebyte.com>)
 id 1kVvYC-0004Jf-15
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:48:05 -0400
Message-Id: <780f9da880e45280ce4e0a1b7c72fce618623a05.1603452058.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603452058.git.qemu_oss@crudebyte.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Oct 2020 18:09:41 +0200
Subject: [PULL 05/13] tests/9pfs: Turn fs_mkdir() into a helper
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=780f9da880e45280ce4e0a1b7c72fce618623a05@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 07:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fs_mkdir() isn't a top level test function and thus shouldn't take
the "void *obj, void *data, QGuestAllocator *t_alloc" arguments.
Turn it into a helper to be used by test functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160321018148.266767.15959608711038504029.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 3c187cdc08..2ea555fa04 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -972,11 +972,8 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wnames[0]);
 }
 
-static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
-                     const char *path, const char *cname)
+static void do_mkdir(QVirtio9P *v9p, const char *path, const char *cname)
 {
-    QVirtio9P *v9p = obj;
-    alloc = t_alloc;
     char **wnames;
     char *const name = g_strdup(cname);
     P9Req *req;
@@ -1031,7 +1028,7 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert(root_path != NULL);
 
     do_attach(v9p);
-    fs_mkdir(v9p, data, t_alloc, "/", "01");
+    do_mkdir(v9p, "/", "01");
 
     /* check if created directory really exists now ... */
     g_assert(stat(new_dir, &st) == 0);
-- 
2.20.1


