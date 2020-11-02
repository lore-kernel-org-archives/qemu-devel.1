Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EFAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334DF22226
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334DF22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYPh-0002tu-Q5
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZYOh-0002I6-Ro; Mon, 02 Nov 2020 06:53:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZYOf-0001aC-1u; Mon, 02 Nov 2020 06:53:15 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPrrv4CwZz15PnV;
 Mon,  2 Nov 2020 19:53:03 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 19:52:58 +0800
Message-ID: <5F9FF319.7060108@huawei.com>
Date: Mon, 2 Nov 2020 19:52:57 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH] block/vvfat: Fix bad printf format specifiers
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=alex.chen@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 06:53:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should use printf format specifier "%u" instead of "%d" for
argument of type "unsigned int".
In addition, fix two error format problems found by checkpatch.pl:
ERROR: space required after that ',' (ctx:VxV)
+        fprintf(stderr,"%s attributes=0x%02x begin=%u size=%d\n",
                       ^
ERROR: line over 90 characters
+        fprintf(stderr, "%d, %s (%u, %d)\n", i, commit->path ? commit->path : "(null)", commit->param.rename.cluster, commit->action);

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
---
 block/vvfat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 5abb90e7c7..cc2ec9af21 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1437,7 +1437,7 @@ static void print_direntry(const direntry_t* direntry)
         for(i=0;i<11;i++)
             ADD_CHAR(direntry->name[i]);
         buffer[j] = 0;
-        fprintf(stderr,"%s attributes=0x%02x begin=%d size=%d\n",
+        fprintf(stderr, "%s attributes=0x%02x begin=%u size=%d\n",
                 buffer,
                 direntry->attributes,
                 begin_of_direntry(direntry),le32_to_cpu(direntry->size));
@@ -1446,7 +1446,7 @@ static void print_direntry(const direntry_t* direntry)

 static void print_mapping(const mapping_t* mapping)
 {
-    fprintf(stderr, "mapping (%p): begin, end = %d, %d, dir_index = %d, "
+    fprintf(stderr, "mapping (%p): begin, end = %u, %u, dir_index = %u, "
         "first_mapping_index = %d, name = %s, mode = 0x%x, " ,
         mapping, mapping->begin, mapping->end, mapping->dir_index,
         mapping->first_mapping_index, mapping->path, mapping->mode);
@@ -1454,7 +1454,7 @@ static void print_mapping(const mapping_t* mapping)
     if (mapping->mode & MODE_DIRECTORY)
         fprintf(stderr, "parent_mapping_index = %d, first_dir_index = %d\n", mapping->info.dir.parent_mapping_index, mapping->info.dir.first_dir_index);
     else
-        fprintf(stderr, "offset = %d\n", mapping->info.file.offset);
+        fprintf(stderr, "offset = %u\n", mapping->info.file.offset);
 }
 #endif

@@ -1588,7 +1588,7 @@ typedef struct commit_t {
 static void clear_commits(BDRVVVFATState* s)
 {
     int i;
-DLOG(fprintf(stderr, "clear_commits (%d commits)\n", s->commits.next));
+DLOG(fprintf(stderr, "clear_commits (%u commits)\n", s->commits.next));
     for (i = 0; i < s->commits.next; i++) {
         commit_t* commit = array_get(&(s->commits), i);
         assert(commit->path || commit->action == ACTION_WRITEOUT);
@@ -2648,7 +2648,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
     fprintf(stderr, "handle_renames\n");
     for (i = 0; i < s->commits.next; i++) {
         commit_t* commit = array_get(&(s->commits), i);
-        fprintf(stderr, "%d, %s (%d, %d)\n", i, commit->path ? commit->path : "(null)", commit->param.rename.cluster, commit->action);
+        fprintf(stderr, "%d, %s (%u, %d)\n", i,
+                commit->path ? commit->path : "(null)",
+                commit->param.rename.cluster, commit->action);
     }
 #endif

-- 
2.19.1

