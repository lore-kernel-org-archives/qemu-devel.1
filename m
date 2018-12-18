Received: from eggs.gnu.org ([2001:4830:134:3::10]:34171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGIf-0005Nx-Ii
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGIc-0007LT-F8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:24:45 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:56:07 +0100
Message-Id: <20181218115615.1499-5-philmd@redhat.com>
In-Reply-To: <20181218115615.1499-1-philmd@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/12] MAINTAINERS: Add missing entries to
 VFIO and NVMe
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

The VFIO helpers are used by the NVMe block driver, add the
entries to both sections.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: add util/vfio-helpers.c, add entries to NVMe section
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3305a65b6..7a94b0dab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1365,7 +1365,10 @@ VFIO
 M: Alex Williamson <alex.williamson@redhat.com>
 S: Supported
 F: hw/vfio/*
+F: util/vfio-helpers.c
 F: include/hw/vfio/
+F: include/qemu/vfio-helpers.h
+F: docs/igd-assign.txt
=20
 vfio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
@@ -2290,6 +2293,8 @@ M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
+F: util/vfio-helpers.c
+F: include/qemu/vfio-helpers.h
=20
 Bootdevice
 M: Gonglei <arei.gonglei@huawei.com>
--=20
2.17.2
