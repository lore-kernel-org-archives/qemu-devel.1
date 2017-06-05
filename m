Received: from eggs.gnu.org ([2001:4830:134:3::10]:48117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHusN-00047O-Jp
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHusJ-00009Q-DK
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHusJ-000095-4g
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:29:03 -0400
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-18-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
Date: Mon, 5 Jun 2017 11:28:59 -0500
MIME-Version: 1.0
In-Reply-To: <1496320911-51305-18-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pe6Rfiw6figXT69OmGMNcTiO81Scgqn3I"
Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pe6Rfiw6figXT69OmGMNcTiO81Scgqn3I
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>
Message-ID: <c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
 <1496320911-51305-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-18-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 07:41 AM, Paolo Bonzini wrote:
> From: Felipe Franciosi <felipe@nutanix.com>
>=20
> This commit introduces a vhost-user device for SCSI. This is based
> on the existing vhost-scsi implementation, but done over vhost-user
> instead. It also uses a chardev to connect to the backend. Unlike
> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>=20
> To use it, start Qemu with a command line equivalent to:
>=20
> qemu-system-x86_64 \
>        -chardev socket,id=3Dvus0,path=3D/tmp/vus.sock \
>        -device vhost-user-scsi-pci,chardev=3Dvus0,bus=3Dpci.0,addr=3D..=
=2E
>=20
> A separate commit presents a sample application linked with libiscsi to=

> provide a backend for vhost-user-scsi.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
> ---

This pull request still hasn't landed, and now it needs a rebase:

> +++ b/hw/scsi/vhost-user-scsi.c

> +#include "hw/virtio/virtio-access.h"
> +#include "sysemu/char.h"

Now that commit 6b10e573 is on mainline, sysemu/char.h has been renamed
to chardev/char.h (there may be other changes needed, too).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pe6Rfiw6figXT69OmGMNcTiO81Scgqn3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNYbLAAoJEKeha0olJ0NqJakH/iOKpIziy3Rg0z45lT/yrvkt
Qhx3mrPSmDkJyJ1B3jORISlr2NFBXxF5zcupRDtCqZ6C0ksv9kY7vvc33cuLFm6D
xad7sYUpn5DgSX9/xqSYcLPPvPKstl866naWzvM9TFhtiJmtNll4L0+Lmubonq3K
ORo395CZYuVS3jNUYzKkznlb+NGrM5GC5JKNCX1pSAV2rXHqx2RoXoGtRad+4q74
DZHGSRAm+Hp7invPNGRCoYavUcITfjBlpzI1VvJH0Y6w43CId1n3pibL/lMIi7Hi
jP03tCQLRW7vWjW1yh7nhmh/YMsKBSAMagnEN3Xmf4EyFBoyvgQqo9xCoH5RTl4=
=dNk0
-----END PGP SIGNATURE-----

--pe6Rfiw6figXT69OmGMNcTiO81Scgqn3I--
