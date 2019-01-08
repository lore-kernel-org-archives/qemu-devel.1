Received: from eggs.gnu.org ([209.51.188.92]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1ggtMN-0000oM-BX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1ggtMM-0001Li-HC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1ggtMM-0001DU-BM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:32:06 -0500
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Tue,  8 Jan 2019 16:26:45 +0100
Message-Id: <20190108152648.32537-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH spice/qemu 0/3] QXL interface to set monitor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

Hello,

this is the final version of the new QXL interface to identify the
graphics device monitors in the guest. This interface adds a function
that allows to set the device path (e.g. a PCI path) and the IDs of the
device's displays from QEMU to SPICE server. The server will forward
this information to the guest agent, which can use it to identify the
displays in the guest context (a follow-up series on the spice-devel
mailing list).

--=20
2.20.1
