Received: from eggs.gnu.org ([2001:4830:134:3::10]:51261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb4bP-0004rc-OJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb4bO-00042J-SM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:47:19 -0400
Date: Thu, 5 Jul 2018 16:47:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180705164656-mutt-send-email-mst@kernel.org>
References: <20180704153919.12432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180704153919.12432-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] Coccinelle cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 04, 2018 at 12:39:11PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Nothing exciting here, patches created mechanically
> (common after soft freeze).

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Philippe Mathieu-Daud=E9 (8):
>   qobject: Catch another straggler for use of qdict_put_str()
>   error: Remove NULL checks on error_propagate() calls
>   crypto: Remove useless casts
>   xen: Remove useless casts
>   tests/bios-tables-test: Remove useless casts
>   ui/vnc: Remove useless parenthesis around DIV_ROUND_UP macro
>   hw/pci-host: Remove useless parenthesis around DIV_ROUND_UP macro
>   hw/intc/gicv3: Remove useless parenthesis around DIV_ROUND_UP macro
>=20
>  include/hw/intc/arm_gicv3_common.h | 2 +-
>  crypto/cipher-builtin.c            | 4 ++--
>  hw/pci-host/piix.c                 | 2 +-
>  hw/pci-host/q35.c                  | 2 +-
>  hw/s390x/virtio-ccw.c              | 4 +---
>  hw/xen/xen_pt_config_init.c        | 2 +-
>  qobject/block-qdict.c              | 2 +-
>  tests/bios-tables-test.c           | 2 +-
>  ui/vnc-enc-tight.c                 | 2 +-
>  ui/vnc.c                           | 3 ++-
>  10 files changed, 12 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.18.0
