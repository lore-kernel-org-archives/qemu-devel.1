Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjklV-0005N7-63
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjklS-0003v9-5f
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:48:49 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b2054e1-5867-979b-b476-b3aa8ecc5689@redhat.com>
Date: Fri, 3 Mar 2017 11:48:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu-system-ppc64 crashes during "info qtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

 Hi C=C3=A9dric, hi David,

running "info qtree" at the HMP monitor with the pseries machine
currently results in:

  [...]
      dev: spapr-vty, id "vty@71000000"
        reg =3D 1895825408 (0x71000000)
        chardev =3D "serial0"
        irq =3D 4098 (0x1002)
  dev: spapr-rtc, id ""
  dev: icp, id ""
hw/core/sysbus.c:277:sysbus_dev_print: Object 0x7f83127fc3f0 is not an
instance of type sys-bus-device
Aborted (core dumped)

Since the last device that is printed here is "icp" ... could that be
related to the recent ICP/XICS reworks that have been merged a couple of
days ago?

 Thomas
