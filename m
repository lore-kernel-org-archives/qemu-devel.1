Received: from eggs.gnu.org ([2001:4830:134:3::10]:36226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSeW-0000RZ-Fb
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSeV-0006P0-LZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDSeV-0006Mt-4d
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:09:11 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 12:08:54 +0100
Message-Id: <20181019110856.18893-7-berrange@redhat.com>
In-Reply-To: <20181019110856.18893-1-berrange@redhat.com>
References: <20181019110856.18893-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/8] crypto: annotate xts_tweak_encdec as
 inlineable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Encouraging the compiler to inline xts_tweak_encdec increases the
performance for xts-aes-128 when built with gcrypt:

  Encrypt: 545 MB/s -> 580 MB/s
  Decrypt: 568 MB/s -> 602 MB/s

Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/xts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index 10ec83ff21..4277ad40de 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -81,11 +81,11 @@ static void xts_mult_x(xts_uint128 *I)
  *
  * Encrypt/decrypt data with a tweak
  */
-static void xts_tweak_encdec(const void *ctx,
-                             xts_cipher_func *func,
-                             const xts_uint128 *src,
-                             xts_uint128 *dst,
-                             xts_uint128 *iv)
+static inline void xts_tweak_encdec(const void *ctx,
+                                    xts_cipher_func *func,
+                                    const xts_uint128 *src,
+                                    xts_uint128 *dst,
+                                    xts_uint128 *iv)
 {
     /* tweak encrypt block i */
     xts_uint128_xor(dst, src, iv);
--=20
2.17.2
