Received: from eggs.gnu.org ([2001:4830:134:3::10]:57562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsx-0006xf-D7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsw-0003bd-II
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:03 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:43578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsw-0003bT-Dz
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:02 -0400
Received: by mail-qk0-x229.google.com with SMTP id z74-v6so3045774qkb.10
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 08:40:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Jul 2018 12:39:14 -0300
Message-Id: <20180704153919.12432-4-f4bug@amsat.org>
In-Reply-To: <20180704153919.12432-1-f4bug@amsat.org>
References: <20180704153919.12432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] crypto: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/typecast.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 crypto/cipher-builtin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index d8c811fd33..7eff760f0a 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -133,7 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
 {
     const QCryptoCipherBuiltinAESContext *aesctx = ctx;
 
-    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
+    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc,
                                    src, dst, length);
 }
 
@@ -145,7 +145,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
 {
     const QCryptoCipherBuiltinAESContext *aesctx = ctx;
 
-    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
+    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec,
                                    src, dst, length);
 }
 
-- 
2.18.0
