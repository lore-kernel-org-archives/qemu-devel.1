Received: from eggs.gnu.org ([2001:4830:134:3::10]:39218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWavH-0001b1-49
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 00:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWavD-0003Xh-V2
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 00:49:35 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 11 Dec 2018 16:49:23 +1100
Message-Id: <20181211054926.56717-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH qemu 0/3] ppc/spapr: Receive and store device
 tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Here is my FDT queue for sPAPR.

This is based on sha1
41bcd77 C=C3=A9dric Le Goater "spapr: Add a pseries-4.0 machine type".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  configure/fdt: Use more strict test for libfdt version
  ppc/spapr: Receive and store device tree blob from SLOF
  spapr: Fix fdt warnings

 configure              |  2 +-
 include/hw/ppc/spapr.h |  7 ++++++-
 hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++--
 hw/ppc/spapr_hcall.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events    |  3 +++
 5 files changed, 83 insertions(+), 4 deletions(-)

--=20
2.17.1
