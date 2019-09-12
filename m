Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089B6C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCE120830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCE120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LTp-0001Ht-HA
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEW-00021C-3a
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LEU-0005ql-Su
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8LES-0005my-09; Thu, 12 Sep 2019 05:17:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57E4C3082128;
 Thu, 12 Sep 2019 09:17:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E162B194B9;
 Thu, 12 Sep 2019 09:17:35 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 12:17:05 +0300
Message-Id: <20190912091710.21449-8-mlevitsk@redhat.com>
In-Reply-To: <20190912091710.21449-1-mlevitsk@redhat.com>
References: <20190912091710.21449-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 12 Sep 2019 09:17:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/12] qcrypto-luks: purge unused error codes
 from open callback
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These values are not used by generic crypto code anyway

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index f3bfc921b2..ba63e9b442 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -675,13 +675,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
         error_setg(errp, "Volume is not in LUKS format");
-        ret = -EINVAL;
+        ret = -1;
         goto fail;
     }
     if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
         error_setg(errp, "LUKS version %" PRIu32 " is not supported",
                    luks->header.version);
-        ret = -ENOTSUP;
+        ret = -1;
         goto fail;
     }
 
@@ -697,7 +697,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
      */
     ivgen_name = strchr(cipher_mode, '-');
     if (!ivgen_name) {
-        ret = -EINVAL;
+        ret = -1;
         error_setg(errp, "Unexpected cipher mode string format %s",
                    cipher_mode);
         goto fail;
@@ -715,7 +715,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
                                                                    &local_err);
         if (local_err) {
-            ret = -ENOTSUP;
+            ret = -1;
             error_propagate(errp, local_err);
             goto fail;
         }
@@ -724,7 +724,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
                                                               &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
+        ret = -1;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -735,7 +735,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                               luks->header.master_key_len,
                                               &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
+        ret = -1;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -744,7 +744,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
                                                 &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
+        ret = -1;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -752,14 +752,14 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
                                                            &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
+        ret = -1;
         error_propagate(errp, local_err);
         goto fail;
     }
 
     if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
         if (!ivhash_name) {
-            ret = -EINVAL;
+            ret = -1;
             error_setg(errp, "Missing IV generator hash specification");
             goto fail;
         }
@@ -768,7 +768,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                                 luks->ivgen_hash_alg,
                                                 &local_err);
         if (local_err) {
-            ret = -ENOTSUP;
+            ret = -1;
             error_propagate(errp, local_err);
             goto fail;
         }
@@ -795,7 +795,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                         masterkey,
                                         readfunc, opaque,
                                         errp) < 0) {
-            ret = -EACCES;
+            ret = -1;
             goto fail;
         }
 
@@ -813,7 +813,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                          luks->header.master_key_len,
                                          errp);
         if (!block->ivgen) {
-            ret = -ENOTSUP;
+            ret = -1;
             goto fail;
         }
 
@@ -825,7 +825,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                         n_threads,
                                         errp);
         if (ret < 0) {
-            ret = -ENOTSUP;
+            ret = -1;
             goto fail;
         }
     }
-- 
2.17.2


