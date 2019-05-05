Received: from eggs.gnu.org ([209.51.188.92]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPvN-0004lB-EC
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPvM-0002WE-4F
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:48:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNPvL-0002Vr-Uz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:48:00 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:47:37 +0200
Message-Id: <20190505224737.1028-2-philmd@redhat.com>
In-Reply-To: <20190505224737.1028-1-philmd@redhat.com>
References: <20190505224737.1028-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/1] MAINTAINERS: Add an entry for the Parallel
 NOR Flash devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michael Walle <michael@walle.cc>, Jordan Justen <jordan.l.justen@intel.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Roy Franz <roy.franz@linaro.org>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, David Engraf <david.engraf@sysgo.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnoij@jcrosoft.com>, Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Step in to maintain it, since I have some familiarity with
the technology.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66ddbda9c95..633f6315536 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1391,6 +1391,13 @@ F: include/hw/net/
 F: tests/virtio-net-test.c
 T: git https://github.com/jasowang/qemu.git net
=20
+Parallel NOR Flash devices
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+T: git https://gitlab.com/philmd/qemu.git pflash-next
+S: Maintained
+F: hw/block/pflash_cfi*.c
+F: include/hw/block/flash.h
+
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Fam Zheng <fam@euphon.net>
--=20
2.20.1
