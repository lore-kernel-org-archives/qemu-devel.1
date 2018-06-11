Received: from eggs.gnu.org ([2001:4830:134:3::10]:39990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSPfw-0006yZ-Aj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSPfv-0001Ns-8j
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:28:12 -0400
Date: Mon, 11 Jun 2018 19:27:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611192510-mutt-send-email-mst@kernel.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<54eb6ae9-d7e0-8a4d-6bd4-f8f1d0f00b92@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <54eb6ae9-d7e0-8a4d-6bd4-f8f1d0f00b92@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/40] Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Alistair Francis <alistair@alistair23.me>, Aurelien Jarno <aurelien@aurel32.net>, Anthony Perard <anthony.perard@citrix.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marek Vasut <marex@denx.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Gibson <david@gibson.dropbear.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Chris Wulff <crwulff@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alberto Garcia <berto@igalia.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Walle <michael@walle.cc>, Jan Kiszka <jan.kiszka@web.de>

On Mon, Jun 11, 2018 at 10:55:17AM -0500, Eric Blake wrote:
> On 06/10/2018 08:14 PM, Philippe Mathieu-Daud=E9 wrote:
> > Hi,
> >=20
> > This series:
> >=20
> > - split the byte-based definitions from "qemu/cutils.h" to "qemu/unit=
s.h"
> >    (this now triggers WARNING: 1 added file, does MAINTAINERS need up=
dating?)
> > - clean hw/ includes;
> > - replace different constants used for byte size with their correspon=
ding
> >    IEC binary prefix definitions.
> >=20
> > Since v3:
> > - use IEC binary prefix definitions (Stefan Weil)
> > - rebased
> > - added R-b tags
> >=20
>=20
> >   hw/net/ne2000.h                          |  5 ++--
> ...
> >   tests/test-qemu-opts.c                   |  7 +++---
> >   scripts/checkpatch.pl                    |  1 +
> >   135 files changed, 533 insertions(+), 431 deletions(-)
> >   create mode 100644 include/qemu/units.h
> >=20
>=20
> At least monitor.c and vl.c are missing from this list; a more general =
grep
> shows that the following are all potential candidates for this cleanup:
>=20
> $ git grep -n '[<>][<>]=3D [1-5]0'
> disas/m68k.c:787:      val >>=3D 10;
> hw/mips/mips_malta.c:194:    ram_size >>=3D 20;
> hw/ppc/sam460ex.c:129:    ram_size >>=3D 20;
> hw/timer/sh_timer.c:112:        case 4: freq >>=3D 10; break;

Most likely not 4 kilobyte.


> linux-user/mips/cpu_loop.c:641:                                code >>=3D=
 10;
> linux-user/mips/cpu_loop.c:664:                        code >>=3D 10;

Seems to do with decoding machine code. Also unlikely to be in bytes.

> monitor.c:3198:                    val <<=3D 20;
> target/m68k/helper.c:386:    size >>=3D 10;
> target/m68k/helper.c:390:        size >>=3D 10;
> target/m68k/helper.c:394:            size >>=3D 10;
> target/xtensa/helper.c:729:            sz >>=3D 20;
> target/xtensa/helper.c:732:            sz >>=3D 10;
> vl.c:2793:            sz <<=3D 20;




> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
