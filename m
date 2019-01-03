Received: from eggs.gnu.org ([208.118.235.92]:34373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gezbK-00015M-Dn
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gezbI-000577-GZ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:47:42 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  3 Jan 2019 09:47:27 +0000
Message-Id: <20190103094728.31747-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0)
 before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06237.html
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00133.html

v2:

 - Simplify so we just set optind =3D 1.

 - Retest it on Linux and FreeBSD.=20

Rich.
