Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4003C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67279205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67279205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDF4Z-0003Zw-00
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDEwy-0006DW-3f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDEww-00063d-0f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:35:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDEwr-0005uY-F6; Wed, 25 Sep 2019 17:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A370DC057F31;
 Wed, 25 Sep 2019 21:35:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDA519C5B;
 Wed, 25 Sep 2019 21:35:41 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/13] qcrypto-luks: rename some fields in
 QCryptoBlockLUKSHeader
Date: Thu, 26 Sep 2019 00:35:16 +0300
Message-Id: <20190925213527.9117-3-mlevitsk@redhat.com>
In-Reply-To: <20190925213527.9117-1-mlevitsk@redhat.com>
References: <20190925213527.9117-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 25 Sep 2019 21:35:44 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* key_bytes -> master_key_len
* payload_offset =3D payload_offset_sector (to emphasise that this isn't =
byte offset)
* key_offset -> key_offset_sector - same as above for luks slots

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 91 +++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 743949adbf..f12fa2d270 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -143,7 +143,7 @@ struct QCryptoBlockLUKSKeySlot {
     /* salt for PBKDF2 */
     uint8_t salt[QCRYPTO_BLOCK_LUKS_SALT_LEN];
     /* start sector of key material */
-    uint32_t key_offset;
+    uint32_t key_offset_sector;
     /* number of anti-forensic stripes */
     uint32_t stripes;
 };
@@ -172,10 +172,10 @@ struct QCryptoBlockLUKSHeader {
     char hash_spec[QCRYPTO_BLOCK_LUKS_HASH_SPEC_LEN];
=20
     /* start offset of the volume data (in 512 byte sectors) */
-    uint32_t payload_offset;
+    uint32_t payload_offset_sector;
=20
     /* Number of key bytes */
-    uint32_t key_bytes;
+    uint32_t master_key_len;
=20
     /* master key checksum after PBKDF2 */
     uint8_t master_key_digest[QCRYPTO_BLOCK_LUKS_DIGEST_LEN];
@@ -466,7 +466,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * then encrypted.
      */
     rv =3D readfunc(block,
-                  slot->key_offset * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                  slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTOR_SI=
ZE,
                   splitkey, splitkeylen,
                   opaque,
                   errp);
@@ -584,8 +584,8 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
     size_t i;
     int rv;
=20
-    *masterkey =3D g_new0(uint8_t, luks->header.key_bytes);
-    *masterkeylen =3D luks->header.key_bytes;
+    *masterkey =3D g_new0(uint8_t, luks->header.master_key_len);
+    *masterkeylen =3D luks->header.master_key_len;
=20
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         rv =3D qcrypto_block_luks_load_key(block,
@@ -677,14 +677,14 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     /* The header is always stored in big-endian format, so
      * convert everything to native */
     be16_to_cpus(&luks->header.version);
-    be32_to_cpus(&luks->header.payload_offset);
-    be32_to_cpus(&luks->header.key_bytes);
+    be32_to_cpus(&luks->header.payload_offset_sector);
+    be32_to_cpus(&luks->header.master_key_len);
     be32_to_cpus(&luks->header.master_key_iterations);
=20
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         be32_to_cpus(&luks->header.key_slots[i].active);
         be32_to_cpus(&luks->header.key_slots[i].iterations);
-        be32_to_cpus(&luks->header.key_slots[i].key_offset);
+        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
         be32_to_cpus(&luks->header.key_slots[i].stripes);
     }
=20
@@ -743,10 +743,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
=20
-    cipheralg =3D qcrypto_block_luks_cipher_name_lookup(luks->header.cip=
her_name,
-                                                      ciphermode,
-                                                      luks->header.key_b=
ytes,
-                                                      &local_err);
+    cipheralg =3D
+        qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
+                                              ciphermode,
+                                              luks->header.master_key_le=
n,
+                                              &local_err);
     if (local_err) {
         ret =3D -ENOTSUP;
         error_propagate(errp, local_err);
@@ -838,7 +839,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     }
=20
     block->sector_size =3D QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
-    block->payload_offset =3D luks->header.payload_offset *
+    block->payload_offset =3D luks->header.payload_offset_sector *
         block->sector_size;
=20
     luks->cipher_alg =3D cipheralg;
@@ -993,9 +994,11 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     strcpy(luks->header.cipher_mode, cipher_mode_spec);
     strcpy(luks->header.hash_spec, hash_alg);
=20
-    luks->header.key_bytes =3D qcrypto_cipher_get_key_len(luks_opts.ciph=
er_alg);
+    luks->header.master_key_len =3D
+        qcrypto_cipher_get_key_len(luks_opts.cipher_alg);
+
     if (luks_opts.cipher_mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
-        luks->header.key_bytes *=3D 2;
+        luks->header.master_key_len *=3D 2;
     }
=20
     /* Generate the salt used for hashing the master key
@@ -1008,9 +1011,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     }
=20
     /* Generate random master key */
-    masterkey =3D g_new0(uint8_t, luks->header.key_bytes);
+    masterkey =3D g_new0(uint8_t, luks->header.master_key_len);
     if (qcrypto_random_bytes(masterkey,
-                             luks->header.key_bytes, errp) < 0) {
+                             luks->header.master_key_len, errp) < 0) {
         goto error;
     }
=20
@@ -1018,7 +1021,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     /* Setup the block device payload encryption objects */
     if (qcrypto_block_init_cipher(block, luks_opts.cipher_alg,
                                   luks_opts.cipher_mode, masterkey,
-                                  luks->header.key_bytes, 1, errp) < 0) =
{
+                                  luks->header.master_key_len, 1, errp) =
< 0) {
         goto error;
     }
=20
@@ -1028,7 +1031,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     block->ivgen =3D qcrypto_ivgen_new(luks_opts.ivgen_alg,
                                      ivcipheralg,
                                      luks_opts.ivgen_hash_alg,
-                                     masterkey, luks->header.key_bytes,
+                                     masterkey, luks->header.master_key_=
len,
                                      errp);
=20
     if (!block->ivgen) {
@@ -1040,7 +1043,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      * key, in order to have 1 second of compute time used
      */
     iters =3D qcrypto_pbkdf2_count_iters(luks_opts.hash_alg,
-                                       masterkey, luks->header.key_bytes=
,
+                                       masterkey, luks->header.master_ke=
y_len,
                                        luks->header.master_key_salt,
                                        QCRYPTO_BLOCK_LUKS_SALT_LEN,
                                        QCRYPTO_BLOCK_LUKS_DIGEST_LEN,
@@ -1080,7 +1083,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      * valid master key
      */
     if (qcrypto_pbkdf2(luks_opts.hash_alg,
-                       masterkey, luks->header.key_bytes,
+                       masterkey, luks->header.master_key_len,
                        luks->header.master_key_salt,
                        QCRYPTO_BLOCK_LUKS_SALT_LEN,
                        luks->header.master_key_iterations,
@@ -1093,7 +1096,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
=20
     /* Although LUKS has multiple key slots, we're just going
      * to use the first key slot */
-    splitkeylen =3D luks->header.key_bytes * QCRYPTO_BLOCK_LUKS_STRIPES;
+    splitkeylen =3D luks->header.master_key_len * QCRYPTO_BLOCK_LUKS_STR=
IPES;
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         luks->header.key_slots[i].active =3D i =3D=3D 0 ?
             QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED :
@@ -1103,7 +1106,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         /* This calculation doesn't match that shown in the spec,
          * but instead follows the cryptsetup implementation.
          */
-        luks->header.key_slots[i].key_offset =3D
+        luks->header.key_slots[i].key_offset_sector =3D
             (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
              QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
             (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTO=
R_SIZE),
@@ -1124,7 +1127,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                                        (uint8_t *)password, strlen(passw=
ord),
                                        luks->header.key_slots[0].salt,
                                        QCRYPTO_BLOCK_LUKS_SALT_LEN,
-                                       luks->header.key_bytes,
+                                       luks->header.master_key_len,
                                        &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1155,13 +1158,13 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     /* Generate a key that we'll use to encrypt the master
      * key, from the user's password
      */
-    slotkey =3D g_new0(uint8_t, luks->header.key_bytes);
+    slotkey =3D g_new0(uint8_t, luks->header.master_key_len);
     if (qcrypto_pbkdf2(luks_opts.hash_alg,
                        (uint8_t *)password, strlen(password),
                        luks->header.key_slots[0].salt,
                        QCRYPTO_BLOCK_LUKS_SALT_LEN,
                        luks->header.key_slots[0].iterations,
-                       slotkey, luks->header.key_bytes,
+                       slotkey, luks->header.master_key_len,
                        errp) < 0) {
         goto error;
     }
@@ -1172,7 +1175,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      */
     cipher =3D qcrypto_cipher_new(luks_opts.cipher_alg,
                                 luks_opts.cipher_mode,
-                                slotkey, luks->header.key_bytes,
+                                slotkey, luks->header.master_key_len,
                                 errp);
     if (!cipher) {
         goto error;
@@ -1181,7 +1184,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     ivgen =3D qcrypto_ivgen_new(luks_opts.ivgen_alg,
                               ivcipheralg,
                               luks_opts.ivgen_hash_alg,
-                              slotkey, luks->header.key_bytes,
+                              slotkey, luks->header.master_key_len,
                               errp);
     if (!ivgen) {
         goto error;
@@ -1193,7 +1196,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     splitkey =3D g_new0(uint8_t, splitkeylen);
=20
     if (qcrypto_afsplit_encode(luks_opts.hash_alg,
-                               luks->header.key_bytes,
+                               luks->header.master_key_len,
                                luks->header.key_slots[0].stripes,
                                masterkey,
                                splitkey,
@@ -1217,7 +1220,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      * slot headers, rounded up to the nearest sector, combined with
      * the size of each master key material region, also rounded up
      * to the nearest sector */
-    luks->header.payload_offset =3D
+    luks->header.payload_offset_sector =3D
         (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
          QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
         (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SI=
ZE),
@@ -1226,7 +1229,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
          QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
=20
     block->sector_size =3D QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
-    block->payload_offset =3D luks->header.payload_offset *
+    block->payload_offset =3D luks->header.payload_offset_sector *
         block->sector_size;
=20
     /* Reserve header space to match payload offset */
@@ -1239,14 +1242,14 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     /* Everything on disk uses Big Endian, so flip header fields
      * before writing them */
     cpu_to_be16s(&luks->header.version);
-    cpu_to_be32s(&luks->header.payload_offset);
-    cpu_to_be32s(&luks->header.key_bytes);
+    cpu_to_be32s(&luks->header.payload_offset_sector);
+    cpu_to_be32s(&luks->header.master_key_len);
     cpu_to_be32s(&luks->header.master_key_iterations);
=20
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         cpu_to_be32s(&luks->header.key_slots[i].active);
         cpu_to_be32s(&luks->header.key_slots[i].iterations);
-        cpu_to_be32s(&luks->header.key_slots[i].key_offset);
+        cpu_to_be32s(&luks->header.key_slots[i].key_offset_sector);
         cpu_to_be32s(&luks->header.key_slots[i].stripes);
     }
=20
@@ -1263,14 +1266,14 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     /* Byte swap the header back to native, in case we need
      * to read it again later */
     be16_to_cpus(&luks->header.version);
-    be32_to_cpus(&luks->header.payload_offset);
-    be32_to_cpus(&luks->header.key_bytes);
+    be32_to_cpus(&luks->header.payload_offset_sector);
+    be32_to_cpus(&luks->header.master_key_len);
     be32_to_cpus(&luks->header.master_key_iterations);
=20
     for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         be32_to_cpus(&luks->header.key_slots[i].active);
         be32_to_cpus(&luks->header.key_slots[i].iterations);
-        be32_to_cpus(&luks->header.key_slots[i].key_offset);
+        be32_to_cpus(&luks->header.key_slots[i].key_offset_sector);
         be32_to_cpus(&luks->header.key_slots[i].stripes);
     }
=20
@@ -1282,7 +1285,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     /* Write out the master key material, starting at the
      * sector immediately following the partition header. */
     if (writefunc(block,
-                  luks->header.key_slots[0].key_offset *
+                  luks->header.key_slots[0].key_offset_sector *
                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
                   splitkey, splitkeylen,
                   opaque,
@@ -1296,17 +1299,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
     luks->hash_alg =3D luks_opts.hash_alg;
=20
-    memset(masterkey, 0, luks->header.key_bytes);
-    memset(slotkey, 0, luks->header.key_bytes);
+    memset(masterkey, 0, luks->header.master_key_len);
+    memset(slotkey, 0, luks->header.master_key_len);
=20
     return 0;
=20
  error:
     if (masterkey) {
-        memset(masterkey, 0, luks->header.key_bytes);
+        memset(masterkey, 0, luks->header.master_key_len);
     }
     if (slotkey) {
-        memset(slotkey, 0, luks->header.key_bytes);
+        memset(slotkey, 0, luks->header.master_key_len);
     }
=20
     qcrypto_block_free_cipher(block);
@@ -1346,7 +1349,7 @@ static int qcrypto_block_luks_get_info(QCryptoBlock=
 *block,
         slots->value =3D slot =3D g_new0(QCryptoBlockInfoLUKSSlot, 1);
         slot->active =3D luks->header.key_slots[i].active =3D=3D
             QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
-        slot->key_offset =3D luks->header.key_slots[i].key_offset
+        slot->key_offset =3D luks->header.key_slots[i].key_offset_sector
              * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
         if (slot->active) {
             slot->has_iters =3D true;
--=20
2.17.2


