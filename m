Received: from eggs.gnu.org ([2001:4830:134:3::10]:37248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUGyW-0008Na-K9
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUGyT-0007Li-Dw
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 14:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dUGyT-0007Kz-4R
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 14:30:29 -0400
References: <cover.1499453787.git.alistair.francis@xilinx.com>
	<125868e788f5705e31c0326bed02bc75f9fb173e.1499453788.git.alistair.francis@xilinx.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c8e9829e-1ab6-1fe5-4d93-cbb6093d47d0@redhat.com>
Date: Sun, 9 Jul 2017 20:30:04 +0200
MIME-Version: 1.0
In-Reply-To: <125868e788f5705e31c0326bed02bc75f9fb173e.1499453788.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F3VEBi1nok1kUcL66wM4Eu9ehw9MviUMA"
Subject: Re: [Qemu-devel] [PATCH v2 3/8] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F3VEBi1nok1kUcL66wM4Eu9ehw9MviUMA
From: Max Reitz <mreitz@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com,
 armbru@redhat.com, Jeff Cody <jcody@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Eduardo Habkost
 <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c8e9829e-1ab6-1fe5-4d93-cbb6093d47d0@redhat.com>
Subject: Re: [PATCH v2 3/8] Convert error_report() to warn_report()
References: <cover.1499453787.git.alistair.francis@xilinx.com>
 <125868e788f5705e31c0326bed02bc75f9fb173e.1499453788.git.alistair.francis@xilinx.com>
In-Reply-To: <125868e788f5705e31c0326bed02bc75f9fb173e.1499453788.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-08 01:21, Alistair Francis wrote:
> Convert all uses of error_report("[Ww]arning:"... to use warn_report()
> instead. This helps standardise on a single method of printing warnings=

> to the user.
>=20
> All of the warnings were changed using this command:
>     find ./* -type f -exec sed -i \
>     's|error_report.*[Ww]arning: |warn_report("|g' {} +
>=20
> Then the white space changes where manually fixed afterwards.
>=20
> The test-qdev-global-props test case was manually updated to ensure tha=
t
> this patch passes make check (as the test cases are case sensitive).
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Josh Durgin <jdurgin@redhat.com>
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Greg Kurz <groug@kaod.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> V2:
>  - Fix quotation issues
>  - Update commit message
>  - Include full command
>=20
>  block/backup.c                 | 10 +++++-----
>  block/gluster.c                |  2 +-
>  block/iscsi.c                  |  6 +++---
>  block/nfs.c                    | 12 ++++++------
>  block/rbd.c                    |  6 +++---
>  block/ssh.c                    |  4 ++--
>  blockdev.c                     |  2 +-
>  cpus.c                         |  2 +-
>  hw/9pfs/9p.c                   |  2 +-
>  hw/arm/highbank.c              |  6 +++---
>  hw/arm/imx25_pdk.c             |  6 +++---
>  hw/arm/kzm.c                   |  6 +++---
>  hw/core/machine.c              | 10 +++++-----
>  hw/core/qdev-properties.c      |  8 ++++----
>  hw/i386/acpi-build.c           | 10 +++++-----
>  hw/i386/kvm/pci-assign.c       |  6 +++---
>  hw/i386/pc.c                   | 12 ++++++------
>  hw/i386/pc_piix.c              |  8 ++++----
>  hw/i386/pc_q35.c               |  6 +++---
>  hw/misc/aspeed_sdmc.c          |  8 ++++----
>  hw/nvram/fw_cfg.c              |  2 +-
>  hw/pci-host/piix.c             |  2 +-
>  hw/ppc/pnv.c                   |  6 +++---
>  hw/ppc/spapr.c                 |  4 ++--
>  hw/ppc/spapr_iommu.c           |  2 +-
>  hw/scsi/scsi-bus.c             |  6 +++---
>  hw/usb/dev-smartcard-reader.c  |  6 +++---
>  hw/usb/redirect.c              |  2 +-
>  net/tap-linux.c                |  2 +-
>  target/i386/cpu.c              | 22 +++++++++++-----------
>  target/i386/kvm.c              | 12 ++++++------
>  target/s390x/cpu_models.c      |  6 +++---
>  target/s390x/kvm.c             |  4 ++--
>  tests/test-qdev-global-props.c |  6 +++---
>  trace/control.c                |  8 ++++----
>  vl.c                           | 20 ++++++++++----------
>  36 files changed, 121 insertions(+), 121 deletions(-)

[...]

> diff --git a/block/gluster.c b/block/gluster.c
> index addceed6eb..531e72df56 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -345,7 +345,7 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGl=
uster *gconf,
>          is_unix =3D true;
>      } else if (!strcmp(uri->scheme, "gluster+rdma")) {
>          gsconf->type =3D SOCKET_ADDRESS_TYPE_INET;
> -        error_report("Warning: rdma feature is not supported, falling =
"
> +        warn_report("rdma feature is not supported, falling "
>                       "back to tcp");

You reindented consecutive lines everywhere else, so you may want to do
that here, too.

With that fixed (or even without, as evidently the alignment for
error_report() wasn't quite right all the time either), for block*:

Acked-by: Max Reitz <mreitz@redhat.com>

>      } else {
>          ret =3D -EINVAL;


--F3VEBi1nok1kUcL66wM4Eu9ehw9MviUMA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYnYsEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCm8
B/9rABrXUoiEq2UcAf1/zjHO11NvovbJPGGfMJpdQO56+cXJq+WHlLO5czx7TgW1
hSJt0tA/QjYgDkVoAGuXE50l2YR0qvzEryQRWOWOOJnq6VRjEgFARAxyHfnkBWgz
s6+Bv+EyGOUiiS3kV1Wsbqm/MiUUFh8dmcJvwjMFXWxeZisekwA5F6H3xiITirjG
geY5mK/hzQmS1MaKNpo0bf/rJ+DLJhrB1u2VTQ4eqk1k+++/wX8w5uOcsswImr1Q
j19jeHZSm5e4PZd8HfbXsLZRW8ZsnlMAPbyTypfEYDxUbsLE/TRw1X75wVvfS2Qn
vIPGK9rtuZyBOM3pNFPbKSwR
=TeJR
-----END PGP SIGNATURE-----

--F3VEBi1nok1kUcL66wM4Eu9ehw9MviUMA--
