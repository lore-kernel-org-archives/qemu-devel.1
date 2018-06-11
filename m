Received: from eggs.gnu.org ([2001:4830:134:3::10]:36501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSPXc-0001P3-EQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSPXb-0004wf-JC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:19:36 -0400
Date: Mon, 11 Jun 2018 18:18:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180611181856.71bf285a.cohuck@redhat.com>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Alistair Francis <alistair@alistair23.me>, Aurelien Jarno <aurelien@aurel32.net>, Anthony Perard <anthony.perard@citrix.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marek Vasut <marex@denx.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Gibson <david@gibson.dropbear.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Chris Wulff <crwulff@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alberto Garcia <berto@igalia.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Walle <michael@walle.cc>, Jan Kiszka <jan.kiszka@web.de>

On Sun, 10 Jun 2018 22:14:21 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi,
>=20
> This series:
>=20
> - split the byte-based definitions from "qemu/cutils.h" to "qemu/units.h"
>   (this now triggers WARNING: 1 added file, does MAINTAINERS need updatin=
g?)
> - clean hw/ includes;
> - replace different constants used for byte size with their corresponding
>   IEC binary prefix definitions.

Do we document preference for this somewhere? Can we automatically
check for this?
