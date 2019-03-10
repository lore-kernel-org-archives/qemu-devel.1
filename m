Received: from eggs.gnu.org ([209.51.188.92]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38H0-0004Uc-4A
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Gz-0002GC-EC
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38Gz-0002Fu-7n
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:29 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:45 +0100
Message-Id: <20190310235351.1863-3-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/8] hw/input: Add 8042 PS/2 Keyboard
 Controller to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The Intel 8042 chipset also includes some functions unrelated to
the keyboard, such the A20-Gate.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/input/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index e2e66f0858..83e4546a28 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -10,6 +10,10 @@ config PCKBD
     default y
     depends on ISA_BUS
=20
+config I8042
+    bool
+    select PCKBD
+
 config PL050
     bool
=20
--=20
2.20.1
