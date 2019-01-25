Received: from eggs.gnu.org ([209.51.188.92]:52056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gn9LG-0001LP-5j
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gn9LF-0002U2-Di
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:48:50 -0500
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Date: Fri, 25 Jan 2019 23:48:35 +0200
Message-ID: <1648289.tQCHxfjYn9@basile.remlab.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH 0/3] target/arm: fix PAuth in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel <qemu-devel@nongnu.org>

	Hello,

As things stand, ARMv8.3-PAuth does not work in user mode. These tiny patch=
es=20
attempt to fix that.

Br,

=2D---------------------------------------------------------------
Remi Denis-Courmont (3):
      target/arm: fix AArch64 virtual address space size
      target/arm: actually enable PAuth in user mode
      target/arm: fix decoding of B{,L}RA{A,B}

 target/arm/cpu.h           | 2 +-
 target/arm/cpu64.c         | 4 ++--
 target/arm/translate-a64.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/
