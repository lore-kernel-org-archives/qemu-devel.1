Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB233C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF11C2084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF11C2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlseH-0003JU-1e
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlsdp-0001S0-75
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlsdo-0001Sr-4O
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hlsdn-0001Ry-T3
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:19:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3737A83F40;
 Fri, 12 Jul 2019 10:18:59 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0851860BFB;
 Fri, 12 Jul 2019 10:18:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 11:18:49 +0100
Message-Id: <20190712101849.8993-3-berrange@redhat.com>
In-Reply-To: <20190712101849.8993-1-berrange@redhat.com>
References: <20190712101849.8993-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 12 Jul 2019 10:18:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 2/2] crypto: fix function signatures
 for nettle 2.7 vs 3
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Amol Surati <suratiamol@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nettle version 2.7.x used 'unsigned int' instead of 'size_t' for length
parameters in functions. Use a local typedef so that we can build with
the correct signature depending on nettle version, as we already do in
the cipher code.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/hash-nettle.c | 12 +++++++++---
 crypto/hmac-nettle.c | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 96f186f442..6ffb9c3db7 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -26,12 +26,18 @@
 #include <nettle/sha.h>
 #include <nettle/ripemd160.h>
=20
+#if CONFIG_NETTLE_VERSION_MAJOR < 3
+typedef unsigned int     hash_length_t;
+#else
+typedef size_t       hash_length_t;
+#endif
+
 typedef void (*qcrypto_nettle_init)(void *ctx);
 typedef void (*qcrypto_nettle_write)(void *ctx,
-                                     unsigned int len,
+                                     hash_length_t len,
                                      const uint8_t *buf);
 typedef void (*qcrypto_nettle_result)(void *ctx,
-                                      unsigned int len,
+                                      hash_length_t len,
                                       uint8_t *buf);
=20
 union qcrypto_hash_ctx {
@@ -112,7 +118,7 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
                            size_t *resultlen,
                            Error **errp)
 {
-    int i;
+    size_t i;
     union qcrypto_hash_ctx ctx;
=20
     if (!qcrypto_hash_supports(alg)) {
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index ec2d61bdde..1152b741fd 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -18,14 +18,23 @@
 #include "hmacpriv.h"
 #include <nettle/hmac.h>
=20
+#if CONFIG_NETTLE_VERSION_MAJOR < 3
+typedef unsigned int hmac_length_t;
+#else
+typedef size_t hmac_length_t;
+#endif
+
 typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
-              size_t key_length, const uint8_t *key);
+                                           hmac_length_t key_length,
+                                           const uint8_t *key);
=20
 typedef void (*qcrypto_nettle_hmac_update)(void *ctx,
-              size_t length, const uint8_t *data);
+                                           hmac_length_t length,
+                                           const uint8_t *data);
=20
 typedef void (*qcrypto_nettle_hmac_digest)(void *ctx,
-              size_t length, uint8_t *digest);
+                                           hmac_length_t length,
+                                           uint8_t *digest);
=20
 typedef struct QCryptoHmacNettle QCryptoHmacNettle;
 struct QCryptoHmacNettle {
@@ -135,7 +144,7 @@ qcrypto_nettle_hmac_bytesv(QCryptoHmac *hmac,
                            Error **errp)
 {
     QCryptoHmacNettle *ctx;
-    int i;
+    size_t i;
=20
     ctx =3D (QCryptoHmacNettle *)hmac->opaque;
=20
--=20
2.21.0


