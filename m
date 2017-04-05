Received: from eggs.gnu.org ([2001:4830:134:3::10]:41766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGg-000873-AY
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGf-00015I-KM
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:34 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkGf-00015C-E9
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:33 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5622F49D4C
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:42:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:30 +0200
Message-Id: <1491396106-26376-6-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/21] ppc: add IPMI support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

OpenPOWER systems use a BT device to communicate with the BMC.
Provide support for it.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index 05c83356e12a..7f5b56cbbe9e 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -6,6 +6,10 @@ include usb.mak
 CONFIG_VIRTIO_VGA=3Dy
 CONFIG_ESCC=3Dy
 CONFIG_M48T59=3Dy
+CONFIG_IPMI=3Dy
+CONFIG_IPMI_LOCAL=3Dy
+CONFIG_IPMI_EXTERN=3Dy
+CONFIG_ISA_IPMI_BT=3Dy
 CONFIG_SERIAL=3Dy
 CONFIG_PARALLEL=3Dy
 CONFIG_I8254=3Dy
--=20
2.7.4
