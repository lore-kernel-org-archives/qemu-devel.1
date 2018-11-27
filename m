Received: from eggs.gnu.org ([2001:4830:134:3::10]:46882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfv-0002oE-OU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfv-0004Ya-3F
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfu-0004Y8-Tj
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:40 +0400
Message-Id: <20181127092801.21777-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 07/28] MAINTAINERS: Add an ARM SMMU
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Eric Auger <eric.auger@redhat.com>

Add a new ARM SMMU section and set Eric Auger as the maintainer
for ARM SMMU emulation sources.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20181122180143.14237-1-eric.auger@redhat.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43d0d9d578..9410bbb7cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -151,6 +151,13 @@ F: disas/arm.c
 F: disas/arm-a64.cc
 F: disas/libvixl/
=20
+ARM SMMU
+M: Eric Auger <eric.auger@redhat.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/smmu*
+F: include/hw/arm/smmu*
+
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
--=20
2.20.0.rc1
