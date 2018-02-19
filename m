Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1enoMF-0004VN-0s
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1enoMC-0005so-De
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:32:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1enoMC-0005sW-9X
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:32:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA4B4402314E
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:31:49 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Mon, 19 Feb 2018 17:31:31 +0100
Message-Id: <20180219163131.31153-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] docs: pcie: Spell out machine type needs
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
Cc: mst@redhat.com, berrange@redhat.com, marcel@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

PCIe features are available only via the 'q35' machine type for x86 and
the 'virt' machine type for AArch64 architecture.

Mention that explicitly.

Thanks: Daniel Berrang=C3=A9

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 docs/pcie.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/docs/pcie.txt b/docs/pcie.txt
index 8d3694970e..89e3502075 100644
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
2.13.6
