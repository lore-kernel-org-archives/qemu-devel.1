Received: from eggs.gnu.org ([2001:4830:134:3::10]:33849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF5-0008Sh-Nf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF4-0000d1-W8
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:47 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF4-0000ce-RO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:46 -0500
Received: by mail-qk0-x241.google.com with SMTP id a8so15091898qkb.8
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:29:03 -0300
Message-Id: <20180108172904.8772-12-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/12] configure: add
 HOST_SUPPORTS_UNALIGNED_ACCESS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 28cd073941..669e5a041a 100755
--- a/configure
+++ b/configure
@@ -5005,6 +5005,7 @@ fi
 # check if host supports unaligned access
 
 if test "$host_supports_unaligned_access" != "no"; then
+  QEMU_CFLAGS="-DHOST_SUPPORTS_UNALIGNED_ACCESS $QEMU_CFLAGS"
   if compile_prog "-Werror -Wno-address-of-packed-member" "" ; then
     QEMU_CFLAGS="-Wno-address-of-packed-member $QEMU_CFLAGS"
   fi
-- 
2.15.1
