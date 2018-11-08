Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiJg-0006DA-I8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiJc-0000hE-Lq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKiJc-00006x-BK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Nov 2018 11:15:30 +0000
Message-Id: <20181108111531.30671-8-stefanha@redhat.com>
In-Reply-To: <20181108111531.30671-1-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 7/8] target-alpha: use HTTPS git URL for
 palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Cc: Richard Henderson <rth@twiddle.net>
Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 pc-bios/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/README b/pc-bios/README
index 8f98c07a74..20f7c33c24 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -36,7 +36,7 @@
 	1af4:1000 -> pxe-virtio.rom
=20
 - The sources for the Alpha palcode image is available from:
-  git://github.com/rth7680/qemu-palcode.git
+  https://github.com/rth7680/qemu-palcode.git
=20
 - The u-boot binary for e500 comes from the upstream denx u-boot project=
 where
   it was compiled using the qemu-ppce500 target.
--=20
2.19.1
