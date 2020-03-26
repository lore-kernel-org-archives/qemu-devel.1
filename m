Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175AB2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="noevhA1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175AB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHb5b-0001vk-9X
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <5a33d980a7965aa008c72147d634d50a4ef5f842@lizzy.crudebyte.com>)
 id 1jHb47-0000qv-3t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <5a33d980a7965aa008c72147d634d50a4ef5f842@lizzy.crudebyte.com>)
 id 1jHb45-0001Px-CR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:33:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <5a33d980a7965aa008c72147d634d50a4ef5f842@lizzy.crudebyte.com>)
 id 1jHb45-0000aj-0X
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=YOsEy9iFF3iyS0l7bD6DplUEjZ6KwgpDGHxOkThI0cw=; b=noevh
 A1QCELRPyuzViZxcMWwGGGIv8C8WNAlwjqtUCxbDhhxSr+oBsrZRZV2MpbEVSMrqE12ytw8IlhL4v
 s8J6rdIYI66e27XDq6tJD3I4tSqhyyp1k1yfofgXEOP7bR5VmyuARcnS7c6dCL/XmFpS8HtQ+8JGi
 09EY+dQLxNVQhSurJr6+jusX2HlM5ZeEJ7/w9zGIKVqpg7nqIeCHPR7KJpDoyf65mlbl+e40Y7QMo
 eVqlYdC1gvoxkQiHF2MHZoY1rZ8hJgvl976xZRQDqcpm8Sv0UGglPbFG4mJSngLEyZ3GoXEUlKDVU
 ocaEsmO9iuyynr91oMosm7tHLkG7A==;
Message-Id: <5a33d980a7965aa008c72147d634d50a4ef5f842.1585258105.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1585258105.git.qemu_oss@crudebyte.com>
References: <cover.1585258105.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 26 Mar 2020 22:24:51 +0100
Subject: [PATCH v5 3/6] 9pfs: make v9fs_readdir_response_size() public
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename function v9fs_readdir_data_size() -> v9fs_readdir_response_size()
and make it callable from other units. So far this function is only
used by 9p.c, however subsequent patch requires the function to be
callable from another 9pfs unit. And as we're at it; also make it clear
for what this function is used for.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 10 ++++++++--
 hw/9pfs/9p.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 1aff4f1fa8..bd8a7cbfac 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2322,7 +2322,13 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
-static size_t v9fs_readdir_data_size(V9fsString *name)
+/**
+ * Returns size required in Rreaddir response for the passed dirent @p name.
+ *
+ * @param name - directory entry's name (i.e. file name, directory name)
+ * @returns required size in bytes
+ */
+size_t v9fs_readdir_response_size(V9fsString *name)
 {
     /*
      * Size of each dirent on the wire: size of qid (13) + size of offset (8)
@@ -2357,7 +2363,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         v9fs_string_init(&name);
         v9fs_string_sprintf(&name, "%s", dent->d_name);
-        if ((count + v9fs_readdir_data_size(&name)) > maxsize) {
+        if ((count + v9fs_readdir_response_size(&name)) > maxsize) {
             v9fs_readdir_unlock(&fidp->fs.dir);
 
             /* Ran out of buffer. Set dir back to old position and return */
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b8f72a3bd9..9553700dbb 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -419,6 +419,7 @@ void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
 void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
+size_t v9fs_readdir_response_size(V9fsString *name);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
                       const char *name, V9fsPath *path);
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
-- 
2.20.1


