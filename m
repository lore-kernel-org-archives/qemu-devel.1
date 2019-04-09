Received: from eggs.gnu.org ([209.51.188.92]:47644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDrkg-0002bz-8x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDrkf-0007dd-Bn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:29:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hDrkf-0007d0-0b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:29:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id y13so21207060wrd.3
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:29:28 -0700 (PDT)
Date: Tue, 9 Apr 2019 15:29:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190409142925.GG16944@stefanha-x1.localdomain>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20190321075545.14929-1-nir.weiner@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Weiner <nir.weiner@oracle.com>
Cc: qemu-devel@nongnu.org, liran.alon@oracle.com, bijan.mottahedeh@oracle.com


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
> Originally migration was not possible with vhost-scsi because
> as part of migration, the source host target SCSI device state
> needs to be saved and loaded into the destination host target SCSI
> device. This cannot be done by QEMU.
>=20
> As this can be handled either by external orchestrator or by having
> shared-storage (i.e. iSCSI), there is no reason to limit the
> orchestrator from being able to explictly specify it wish to enable
> migration even when VM have a vhost-scsi device.
>=20
> Liran Alon (1):
>   vhost-scsi: Allow user to enable migration
>=20
> Nir Weiner (2):
>   vhost-scsi: The vhost device should be stopped when the VM is not
>     running
>   vhost-scsi: Add vmstate descriptor
>=20
>  hw/scsi/vhost-scsi.c                  | 57 ++++++++++++++++++++++-----
>  include/hw/virtio/vhost-scsi-common.h |  1 +
>  2 files changed, 48 insertions(+), 10 deletions(-)

What happens when migration is attempted while there is in-flight I/O in
the vring?

Stefan

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrKxFAAoJEJykq7OBq3PIfHUH/2+Eu9fW9wKaN1G8nTxzDKSD
N2Et4j0oUJJ9fFLq07zKmhvWGA5+YSLdRoqbouIc6pVmCOz9jkNID+OctDugVXaA
l6IvKSm3uVQJ+MIk4MGBKK0s6NPJuOKeAgoaqr8VRoPuY/DctUeUhPG3b9XR7i9c
rMmEMsku5cPiYeRmxa57bJp+JghL4e6MU15F+qUJgsEs+WLuIlzwFBjkqcJH+CDP
gEdeHBTb7QCBYZuRSugC+6tcArJYLkoytYxDFzDw6OOMQMLeWEIgzFPaBrSwPZlj
w2R7XS9VLcWZ7crlXlEGPF2Ud4MqXDWt4ddz8zVlAIj3WfQVWqa/DMCsj3wq7Mc=
=UJSi
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
