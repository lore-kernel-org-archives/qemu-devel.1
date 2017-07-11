Received: from eggs.gnu.org ([2001:4830:134:3::10]:59818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUyOI-0004MH-0X
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUyOE-0000Bz-GB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:52:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dUyOE-0000AV-5h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:51:58 -0400
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<da274900f54d939500e281e4e209853980a4073b.1499774331.git.alistair.francis@xilinx.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <88030261-9b90-0cad-4ad4-b05b9380dfd6@redhat.com>
Date: Tue, 11 Jul 2017 18:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <da274900f54d939500e281e4e209853980a4073b.1499774331.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F0c70cbaIldv74U2eWJPg1mmpKpWGW6Li"
Subject: Re: [Qemu-devel] [PATCH v3 3/8] Convert error_report() to
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
--F0c70cbaIldv74U2eWJPg1mmpKpWGW6Li
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
Message-ID: <88030261-9b90-0cad-4ad4-b05b9380dfd6@redhat.com>
Subject: Re: [PATCH v3 3/8] Convert error_report() to warn_report()
References: <cover.1499774331.git.alistair.francis@xilinx.com>
 <da274900f54d939500e281e4e209853980a4073b.1499774331.git.alistair.francis@xilinx.com>
In-Reply-To: <da274900f54d939500e281e4e209853980a4073b.1499774331.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-11 14:07, Alistair Francis wrote:
> Convert all uses of error_report("warning:"... to use warn_report()
> instead. This helps standardise on a single method of printing warnings=

> to the user.
>=20
> All of the warnings where changed using these two commands:
>     find ./* -type f -exec sed -i \
>       's|error_report(".*warning[,:] |warn_report("|Ig' {} +
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
> Reviewed by: Peter Chubb <peter.chubb@data61.csiro.au>
> Acked-by: Max Reitz <mreitz@redhat.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
> V3:
>  - Regenerate patch to ensure no manual edits where made
>  - Tighten regex matches
> V2:
>  - Fix quotation issues
>  - Update commit message
>  - Include full command
>=20
> Just a note:
> We will need to do a similar thing for fprintf. There are patches on
> the list at the moment that conflict with this series (by adding
> error_report() calls that shsould be warning), so I think I'm giong to
> have to do a follow up series converting more cases. I'll cover the
> fprintf cases when I do that. There are some manual cases as
> well that don't say warning or info, but really should. They will have
> to be converted as well.
>=20
>=20
>  block/backup.c                 | 10 +++++-----
>  block/gluster.c                |  4 ++--
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
>  hw/i386/pc.c                   | 10 +++++-----
>  hw/i386/pc_piix.c              |  8 ++++----
>  hw/i386/pc_q35.c               |  6 +++---
>  hw/misc/aspeed_sdmc.c          |  8 ++++----
>  hw/nvram/fw_cfg.c              |  2 +-
>  hw/pci-host/piix.c             |  2 +-
>  hw/ppc/pnv.c                   |  6 +++---
>  hw/ppc/spapr.c                 |  4 ++--
>  hw/ppc/spapr_iommu.c           |  2 +-
>  hw/scsi/scsi-bus.c             |  6 +++---
>  hw/usb/dev-smartcard-reader.c  |  4 ++--
>  hw/usb/redirect.c              |  2 +-
>  net/tap-linux.c                |  2 +-
>  target/i386/cpu.c              |  8 ++++----
>  target/i386/kvm.c              |  4 ++--
>  target/s390x/cpu_models.c      |  2 +-
>  target/s390x/kvm.c             |  2 +-
>  tests/test-qdev-global-props.c |  6 +++---
>  trace/control.c                |  4 ++--
>  vl.c                           | 20 ++++++++++----------
>  36 files changed, 104 insertions(+), 104 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index b69184eac5..44cc2b22ab 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -639,11 +639,11 @@ BlockJob *backup_job_create(const char *job_id, B=
lockDriverState *bs,
>      ret =3D bdrv_get_info(target, &bdi);
>      if (ret =3D=3D -ENOTSUP && !target->backing) {
>          /* Cluster size is not defined */
> -        error_report("WARNING: The target block device doesn't provide=
 "
> -                     "information about the block size and it doesn't =
have a "
> -                     "backing file. The default block size of %u bytes=
 is "
> -                     "used. If the actual block size of the target exc=
eeds "
> -                     "this default, the backup may be unusable",
> +        warn_report("The target block device doesn't provide "
> +                    "information about the block size and it doesn't h=
ave a "
> +                    "backing file. The default block size of %u bytes =
is "
> +                    "used. If the actual block size of the target exce=
eds "
> +                    "this default, the backup may be unusable",
>                       BACKUP_CLUSTER_SIZE_DEFAULT);

Sorry I didn't see this before, but this line may need re-indentation as
well.

But I'm not too picky (even though maybe I should be O:-)), so my
Acked-by can stay either way.

Max


--F0c70cbaIldv74U2eWJPg1mmpKpWGW6Li
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZQIVEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQNIC
CACVk+W2iJ62Hkd/Er3ldTh4o9onsxIAn8kde7oBsUheKZu2HydVzmaXD8+URppX
2ISSlSvMd8b2NL0ZgP/T4mhxItHkcuOTtOXjK5SZCqUlIquQCqO6AZ8RIDiTyUzl
Vg4GSJeihwgUEKdYNqbEvP1xBMT4ecZ3sOIixpxw0WtgW97nsevtIJVGcmA+uS92
xLDj/27hTTl4ufKxfgRgfES9t4LasTKw+Jb9jcjip4sEOflN346wKFoVwri4l0E1
jopczjl/o9Ld9sMTqCEcwz8qYdTqP9L/DKLEN+VexF02gYsHhZVtqiutRXWmlwet
ptLo2QKFuFL9FvWSqHi+Heub
=659N
-----END PGP SIGNATURE-----

--F0c70cbaIldv74U2eWJPg1mmpKpWGW6Li--
