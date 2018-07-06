Received: from eggs.gnu.org ([2001:4830:134:3::10]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fbGgw-00015d-Tm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 22:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fbGgw-00010y-18
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 22:41:50 -0400
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <6E19EBEF-B31C-473C-8279-49A28D571F61@gmail.com>
Date: Thu, 5 Jul 2018 22:41:43 -0400
Subject: [Qemu-devel] VGA cirrus patch prevents video output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mail@sebastianbauer.info
Cc: "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

I noticed that the video in QEMU stopped working. When I start =
qemu-system-ppc all I see is a black window. Not even OpenBIOS displays =
anything. After some bisecting I found out it was this patch that causes =
the problem:=20

Commit 29f9cef39eb1ae55e82c6763eb22d7a1bdff7276
Author: Sebastian Bauer <mail@sebastianbauer.info>
Date:   Mon Jul 2 21:13:45 2018 +0200

    ppc: Include vga cirrus card into the compiling process
   =20
    Drivers for this card exists on PPC-based AmigaOS guests so it is =
useful to
    allow users to emulate the graphics card for PPC machines.
   =20
    As cirrus vga is currently preferred over std(vga) in absence of any =
user
    choice, this change also sets the default display of spapr machines =
to
    std as otherwise qemu refuses to start these machines. Not =
specifying an
    explicit graphics mode is for instance done by 'make check'.
   =20
    Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


I think a solution to this problem might be to have the mac99 machine =
use "-vga std" as default. When I use -vga std, video works again.=
