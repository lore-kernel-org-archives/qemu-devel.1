Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86ADC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA8A217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA8A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrXv-0006qu-GT
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDqRD-00015w-GQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDqRC-0002yc-2D
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDqRB-0002yH-Q3
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:37:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4029069084
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:59:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A29E60606;
 Fri, 27 Sep 2019 09:59:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] qcrypto-luks: purge unused error codes from open callback
Date: Fri, 27 Sep 2019 10:59:21 +0100
Message-Id: <20190927095926.22230-7-berrange@redhat.com>
In-Reply-To: <20190927095926.22230-1-berrange@redhat.com>
References: <20190927095926.22230-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 27 Sep 2019 09:59:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

These values are not used by generic crypto code anyway

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index f3bfc921b2..b8f9b9c20a 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -622,9 +622,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 {
     QCryptoBlockLUKS *luks =3D NULL;
     Error *local_err =3D NULL;
-    int ret =3D 0;
     size_t i;
-    ssize_t rv;
     g_autofree uint8_t *masterkey =3D NULL;
     char *ivgen_name, *ivhash_name;
     g_autofree char *password =3D NULL;
@@ -648,13 +646,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
=20
     /* Read the entire LUKS header, minus the key material from
      * the underlying device */
-    rv =3D readfunc(block, 0,
-                  (uint8_t *)&luks->header,
-                  sizeof(luks->header),
-                  opaque,
-                  errp);
-    if (rv < 0) {
-        ret =3D rv;
+    if (readfunc(block, 0,
+                 (uint8_t *)&luks->header,
+                 sizeof(luks->header),
+                 opaque,
+                 errp) < 0) {
         goto fail;
     }
=20
@@ -675,13 +671,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
         error_setg(errp, "Volume is not in LUKS format");
-        ret =3D -EINVAL;
         goto fail;
     }
     if (luks->header.version !=3D QCRYPTO_BLOCK_LUKS_VERSION) {
         error_setg(errp, "LUKS version %" PRIu32 " is not supported",
                    luks->header.version);
-        ret =3D -ENOTSUP;
         goto fail;
     }
=20
@@ -697,7 +691,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
      */
     ivgen_name =3D strchr(cipher_mode, '-');
     if (!ivgen_name) {
-        ret =3D -EINVAL;
         error_setg(errp, "Unexpected cipher mode string format %s",
                    cipher_mode);
         goto fail;
@@ -715,7 +708,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup(ivh=
ash_name,
                                                                    &loca=
l_err);
         if (local_err) {
-            ret =3D -ENOTSUP;
             error_propagate(errp, local_err);
             goto fail;
         }
@@ -724,7 +716,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->cipher_mode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_m=
ode,
                                                               &local_err=
);
     if (local_err) {
-        ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -735,7 +726,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                               luks->header.master_key_le=
n,
                                               &local_err);
     if (local_err) {
-        ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -744,7 +734,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
                                                 &local_err);
     if (local_err) {
-        ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
@@ -752,14 +741,12 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->ivgen_alg =3D qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
                                                            &local_err);
     if (local_err) {
-        ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
=20
     if (luks->ivgen_alg =3D=3D QCRYPTO_IVGEN_ALG_ESSIV) {
         if (!ivhash_name) {
-            ret =3D -EINVAL;
             error_setg(errp, "Missing IV generator hash specification");
             goto fail;
         }
@@ -768,7 +755,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                                 luks->ivgen_hash_alg,
                                                 &local_err);
         if (local_err) {
-            ret =3D -ENOTSUP;
             error_propagate(errp, local_err);
             goto fail;
         }
@@ -795,7 +781,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                         masterkey,
                                         readfunc, opaque,
                                         errp) < 0) {
-            ret =3D -EACCES;
             goto fail;
         }
=20
@@ -813,19 +798,16 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                                          luks->header.master_key_len,
                                          errp);
         if (!block->ivgen) {
-            ret =3D -ENOTSUP;
             goto fail;
         }
=20
-        ret =3D qcrypto_block_init_cipher(block,
-                                        luks->cipher_alg,
-                                        luks->cipher_mode,
-                                        masterkey,
-                                        luks->header.master_key_len,
-                                        n_threads,
-                                        errp);
-        if (ret < 0) {
-            ret =3D -ENOTSUP;
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
     block->payload_offset =3D luks->header.payload_offset_sector *
         block->sector_size;
=20
-
     return 0;
=20
  fail:
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     g_free(luks);
-    return ret;
+    return -1;
 }
=20
=20
--=20
2.21.0


