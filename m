Received: from eggs.gnu.org ([2001:4830:134:3::10]:49229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLL-0006Hg-1m
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLG-0000xO-Uq
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRLG-0000ww-PI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:02 -0500
Date: Thu, 1 Mar 2018 18:45:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-6-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/13] docs: pcie: Spell out machine type needs
 for PCIe features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kashyap Chamarthy <kchamart@redhat.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Kashyap Chamarthy <kchamart@redhat.com>

PCIe features are available only via the 'q35' machine type for x86 and
the 'virt' machine type for AArch64 architecture.

Mention that explicitly.

Thanks: Daniel Berrang=C3=A9

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/pcie.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/docs/pcie.txt b/docs/pcie.txt
index 8d36949..89e3502 100644
--- a/docs/pcie.txt
+++ b/docs/pcie.txt
@@ -3,8 +3,13 @@ PCI EXPRESS GUIDELINES
=20
 1. Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-The doc proposes best practices on how to use PCI Express/PCI device
-in PCI Express based machines and explains the reasoning behind them.
+The doc proposes best practices on how to use PCI Express (PCIe) / PCI
+devices in PCI Express based machines and explains the reasoning behind
+them.
+
+Note that the PCIe features are available only when using the 'q35'
+machine type on x86 architecture and the 'virt' machine type on AArch64.
+Other machine types do not use PCIe at this time.
=20
 The following presentations accompany this document:
  (1) Q35 overview.
--=20
MST
