Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGJB-0005qD-GX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGJ8-0007ez-Tm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:25:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:56:04 +0100
Message-Id: <20181218115615.1499-2-philmd@redhat.com>
In-Reply-To: <20181218115615.1499-1-philmd@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/12] MAINTAINERS: Add missing entries to
 the X86 section (AMD SEV)
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Moved from TCG to KVM section
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83c127f0d6..771b1c7b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -392,7 +392,9 @@ M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
 F: target/i386/kvm.c
+F: include/sysemu/sev.h
 F: scripts/kvm/vmxcap
+F: docs/amd-memory-encryption.txt
=20
 Guest CPU Cores (Xen):
 ----------------------
--=20
2.17.2
