Received: from eggs.gnu.org ([2001:4830:134:3::10]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwq-0005Ki-FE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwi-00082t-6m
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:15 +1000
Message-Id: <20170426070034.10727-30-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/48] ppc: add IPMI support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

OpenPOWER systems use a BT device to communicate with the BMC.
Provide support for it.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc64-softmmu.mak | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index f6ccb1b..46c9599 100644
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
2.9.3
