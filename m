Received: from eggs.gnu.org ([2001:4830:134:3::10]:34392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGIy-0005bX-7A
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGIv-0007Ul-5S
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:25:04 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:56:05 +0100
Message-Id: <20181218115615.1499-3-philmd@redhat.com>
In-Reply-To: <20181218115615.1499-1-philmd@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/12] MAINTAINERS: Add missing entries for
 the sun4u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Added simba
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 771b1c7b94..dac394d125 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1056,9 +1056,13 @@ Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc64/sun4u.c
-F: pc-bios/openbios-sparc64
+F: hw/sparc64/sun4u_iommu.c
+F: include/hw/sparc/sun4u_iommu.h
 F: hw/pci-host/sabre.c
 F: include/hw/pci-host/sabre.h
+F: hw/pci-bridge/simba.c
+F: include/hw/pci-bridge/simba.h
+F: pc-bios/openbios-sparc64
=20
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
--=20
2.17.2
