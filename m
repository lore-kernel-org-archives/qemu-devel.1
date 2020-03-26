Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF8C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B412077D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lbTBwCWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B412077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHb2k-0007ox-Uw
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a8517fdd582e1b0be2a64f9a3504f18b3da0576a@lizzy.crudebyte.com>)
 id 1jHb15-0006ek-A2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a8517fdd582e1b0be2a64f9a3504f18b3da0576a@lizzy.crudebyte.com>)
 id 1jHb13-0007ZC-Vv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:30:23 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <a8517fdd582e1b0be2a64f9a3504f18b3da0576a@lizzy.crudebyte.com>)
 id 1jHb13-0006G6-Or
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=YBRAdZSum7slsAPGovqqlyFqpgUjqJhoi03R04g10bk=; b=lbTBw
 CWT0n02DHIYTX3FR5TnpEPETUKcriFZiMarMLKCuV2DWKxg0KUrd4tkkCjEcIGdLk+5EBux+ZpPZw
 llqCfefva1zj9yyHiWXC6/YgAKFlrpb7SOnucVcpiFy9wE5FVvauWJvuWd0mZUGqXopaBwzu/dTGn
 b9DfbdJI+2F83tPdAwZjv96dZMUrXBpqE61n+oQQW4J7TbyyVetb/GZw4rPAJWFhO6sMAI/l9e3Pm
 5hPdkIg/j3tmcaxPyhRTIbezUHEqi8lC70GMp75jeJ/iPinut07cTkLl/gCySnSH+Sjth9uEpbAIa
 pTRDkAzrzVo41PQo1fEJqEScN6UZQ==;
Message-Id: <a8517fdd582e1b0be2a64f9a3504f18b3da0576a.1585258105.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1585258105.git.qemu_oss@crudebyte.com>
References: <cover.1585258105.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 26 Mar 2020 22:24:37 +0100
Subject: [PATCH v5 2/6] 9pfs readdir: rename max_count -> maxsize
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

Although the 9p protocol specs use the term 'max_count' as argument
for Treaddir, let's rename our variables for that to 'maxsize'
instead, because 'max_count' is semantically completely wrong. This
variable does not count integral entries, it is rather a maximum
size (in bytes) of the destination (response) buffer being filled.

Since this is just refactoring, hence this patch does not introduce
any behaviour change at all.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9e046f7acb..1aff4f1fa8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2162,7 +2162,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
 
 static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
                                                   V9fsFidState *fidp,
-                                                  uint32_t max_count)
+                                                  uint32_t maxsize)
 {
     V9fsPath path;
     V9fsStat v9stat;
@@ -2199,7 +2199,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         if (err < 0) {
             break;
         }
-        if ((count + v9stat.size + 2) > max_count) {
+        if ((count + v9stat.size + 2) > maxsize) {
             v9fs_readdir_unlock(&fidp->fs.dir);
 
             /* Ran out of buffer. Set dir back to old position and return */
@@ -2332,7 +2332,7 @@ static size_t v9fs_readdir_data_size(V9fsString *name)
 }
 
 static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
-                                        int32_t max_count)
+                                        int32_t maxsize)
 {
     size_t size;
     V9fsQID qid;
@@ -2357,7 +2357,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         v9fs_string_init(&name);
         v9fs_string_sprintf(&name, "%s", dent->d_name);
-        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
+        if ((count + v9fs_readdir_data_size(&name)) > maxsize) {
             v9fs_readdir_unlock(&fidp->fs.dir);
 
             /* Ran out of buffer. Set dir back to old position and return */
@@ -2432,20 +2432,20 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     size_t offset = 7;
     uint64_t initial_offset;
     int32_t count;
-    uint32_t max_count;
+    uint32_t maxsize;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
-                           &initial_offset, &max_count);
+                           &initial_offset, &maxsize);
     if (retval < 0) {
         goto out_nofid;
     }
-    trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
+    trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, maxsize);
 
     /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */
-    if (max_count > s->msize - 11) {
-        max_count = s->msize - 11;
+    if (maxsize > s->msize - 11) {
+        maxsize = s->msize - 11;
         warn_report_once(
             "9p: bad client: T_readdir with count > msize - 11"
         );
@@ -2465,7 +2465,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     } else {
         v9fs_co_seekdir(pdu, fidp, initial_offset);
     }
-    count = v9fs_do_readdir(pdu, fidp, max_count);
+    count = v9fs_do_readdir(pdu, fidp, maxsize);
     if (count < 0) {
         retval = count;
         goto out;
-- 
2.20.1


