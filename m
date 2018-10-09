Received: from eggs.gnu.org ([2001:4830:134:3::10]:49251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1g9rmy-00046J-QW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1g9rmu-0000TM-SB
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1g9rmu-0000SW-MD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:00 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Tue,  9 Oct 2018 15:10:50 +0200
Message-Id: <20181009131052.18500-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH spice/qemu 0/2] QXL interface to set
 monitor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hello,

this is a preliminary RFC on the new QXL interface to identify the
graphics device monitors in the guest. This interface adds two functions
that allow to set the device path (e.g. a PCI path) and the IDs of the
device's displays from QEMU to SPICE server. The server will forward
this information to the guest agent, which can use it to identify the
displays in the guest context.

The mechanism, as well as the actual format of the pci path is in
accordance to what Gerd described in an earlier email [1].

Cheers,
Lukas

[1] https://lists.freedesktop.org/archives/spice-devel/2018-August/045465=
.html


--=20
2.19.1
