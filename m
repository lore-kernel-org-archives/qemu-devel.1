Received: from eggs.gnu.org ([2001:4830:134:3::10]:39994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNcQM-0004GP-Nv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNcQI-0005CF-55
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:04:18 -0400
Date: Tue, 29 May 2018 13:03:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180529130357.405f501b.cohuck@redhat.com>
In-Reply-To: <20180528232719.4721-15-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-15-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 14/21] hw: Do not include
 "sysemu/blockdev.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block
	layer core" <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

On Mon, 28 May 2018 20:27:12 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Remove those unneeded includes to speed up the compilation
> process a little bit.
>=20
> Code change produced with:
>=20
>     $ git grep '#include "sysemu/blockdev.h"' | \
>       cut -d: -f-1 | \
>       xargs egrep -L "(BlockInterfaceType|DriveInfo|drive_get|blk_legacy_=
dinfo|blockdev_mark_auto_del)" | \
>       xargs sed -i.bak '/#include "sysemu\/blockdev.h"/d'
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/block/m25p80.c          | 1 -
>  hw/block/onenand.c         | 1 -
>  hw/i386/xen/xen-mapcache.c | 1 -
>  hw/s390x/virtio-ccw.c      | 1 -
>  hw/scsi/scsi-generic.c     | 1 -
>  hw/sd/sdhci.c              | 1 -
>  hw/usb/dev-storage.c       | 1 -
>  monitor.c                  | 1 -
>  8 files changed, 8 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
