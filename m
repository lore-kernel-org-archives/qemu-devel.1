Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D0C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5929207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5929207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFBh-0002XI-Ew
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDExh-0006pP-G4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDExW-0006dN-Rw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDExF-0006S5-K9; Wed, 25 Sep 2019 17:36:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0294410C0951;
 Wed, 25 Sep 2019 21:36:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C07F219C5B;
 Wed, 25 Sep 2019 21:36:04 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/13] qcrypto-luks: purge unused error codes from open
 callback
Date: Thu, 26 Sep 2019 00:35:21 +0300
Message-Id: <20190925213527.9117-8-mlevitsk@redhat.com>
In-Reply-To: <20190925213527.9117-1-mlevitsk@redhat.com>
References: <20190925213527.9117-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 25 Sep 2019 21:36:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 crypto/block-luks.c | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index f3bfc921b2..b8f9b9c20a 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -622,9 +622,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 {
     QCryptoBlockLUKS *luks = NULL;
     Error *local_err = NULL;
-    int ret = 0;
     size_t i;
-    ssize_t rv;
     g_autofree uint8_t *masterkey = NULL;
     char *ivgen_name, *ivhash_name;
     g_autofree char *password = NULL;
@@ -648,13 +646,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
     /* Read the entire LUKS header, minus the key material from
      * the underlying device */
-    rv = readfunc(block, 0,
-                  (uint8_t *)&luks->header,
-                  sizeof(luks->header),
-                  opaque,
-                  errp);
-    if (rv < 0) {
-        ret = rv;
+    if (readfunc(block, 0,
+                 (uint8_t *)&luks->header,
+                 sizeof(luks->header),
+                 opaque,
+                 errp) < 0) {
         goto fail;
     }
 
@@ -675,13 +671,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
         error_setg(errp, "Volume is not in LUKS format");
-        ret = -EINVAL;
         goto fail;
     }
     if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
         error_setg(errp, "LUKS version %" PRIu32 " is not supported",
                    luks->header.version);
-        ret = -ENOTSUP;
         goto fail;
     }
 
@@ -697,7 +691,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
      */
     ivgen_name = strchr(cipher_mode, '-');
     if (!ivgen_name) {
-        ret = -EINVAL;
         error_setg(errp, "Unexpected cipher mode string format %s",
                    cipher_mode);
         goto fail;
@@ -715,7 +708,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
                                                                    &local_err);
         if (local_err) {
-            ret = -ENOTSUP;
             error_propagate(errp, local_err);
             goto fail;
         }
@@ -724,7 +716,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
                                                               &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -735,7 +726,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                               luks->header.master_key_len,
                                               &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -744,7 +734,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
                                                 &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -752,14 +741,12 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
                                                            &local_err);
     if (local_err) {
-        ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
 
     if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
         if (!ivhash_name) {
-            ret = -EINVAL;
             error_setg(errp, "Missing IV generator hash specification");
             goto fail;
         }
@@ -768,7 +755,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                                 luks->ivgen_hash_alg,
                                                 &local_err);
         if (local_err) {
-            ret = -ENOTSUP;
             error_propagate(errp, local_err);
             goto fail;
         }
@@ -795,7 +781,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                         masterkey,
                                         readfunc, opaque,
                                         errp) < 0) {
-            ret = -EACCES;
             goto fail;
         }
 
@@ -813,19 +798,16 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                          luks->header.master_key_len,
                                          errp);
         if (!block->ivgen) {
-            ret = -ENOTSUP;
             goto fail;
         }
 
-        ret = qcrypto_block_init_cipher(block,
-                                        luks->cipher_alg,
-                                        luks->cipher_mode,
-                                        masterkey,
-                                        luks->header.master_key_len,
-                                        n_threads,
-                                        errp);
-        if (ret < 0) {
-            ret = -ENOTSUP;
+        if (qcrypto_block_init_cipher(block,
+                                      luks->cipher_alg,
+                                      luks->cipher_mode,
+                                      masterkey,
+                                      luks->header.master_key_len,
+                                      n_threads,
+                                      errp) < 0) {
             goto fail;
         }
     }
@@ -834,14 +816,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->payload_offset = luks->header.payload_offset_sector *
         block->sector_size;
 
-
     return 0;
 
  fail:
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     g_free(luks);
-    return ret;
+    return -1;
 }
 
 
-- 
2.17.2


