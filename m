Received: from eggs.gnu.org ([2001:4830:134:3::10]:37519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e49lS-000251-Ua
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e49lR-00072x-GL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:05:22 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <554765af-beca-0c77-5a73-e03dea123e52@redhat.com>
Date: Mon, 16 Oct 2017 13:05:11 -0500
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6dN3mdgjpl0Ui4uSs4QGeuoPWgjuPBNO1"
Subject: Re: [Qemu-devel] [PATCH v4 1/8] nbd: Include error names in trace
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6dN3mdgjpl0Ui4uSs4QGeuoPWgjuPBNO1
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <554765af-beca-0c77-5a73-e03dea123e52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/8] nbd: Include error names in trace
 messages
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-2-eblake@redhat.com>
In-Reply-To: <20171015010131.12172-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2017 08:01 PM, Eric Blake wrote:
> NBD errors were originally sent over the wire based on Linux errno
> values; but not all the world is Linux, and not all platforms share
> the same values.  Since a number isn't very easy to decipher on all
> platforms, update the trace messages to include the name of NBD
> errors being sent/received over the wire.  Tweak the trace messages
> to be at the point where we are using the NBD error, not the
> translation to the host errno values.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

> +++ b/nbd/trace-events
> @@ -29,7 +29,7 @@ nbd_client_loop_ret(int ret, const char *error) "NBD =
loop returned %d: %s"
>  nbd_client_clear_queue(void) "Clearing NBD queue"
>  nbd_client_clear_socket(void) "Clearing NBD socket"
>  nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_=
t flags, uint16_t type, const char *name) "Sending request to server: { .=
from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" PRIu64 ", .flag=
s =3D 0x%" PRIx16 ", .type =3D %" PRIu16 " (%s) }"
> -nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got=
 reply: { magic =3D 0x%" PRIx32 ", .error =3D % " PRId32 ", handle =3D %"=
 PRIu64" }"

Pre-existing unusual spacing in '.error =3D % " PRId32',

> +nbd_receive_reply(uint32_t magic, int32_t error, const char *errname, =
uint64_t handle) "Got reply: { magic =3D 0x%" PRIx32 ", .error =3D % " PR=
Id32 " (%s), handle =3D %" PRIu64" }"

so I'll clean that up in the next revision.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6dN3mdgjpl0Ui4uSs4QGeuoPWgjuPBNO1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnk9NcACgkQp6FrSiUn
Q2o7Vgf+PCtZk1MFNn6bXPjQ6LxL9B4e5Veg8q0dTbxWcR9H3hxzUuI8UrUBB8v1
OGTW/9GYwWmDtIIzwLEuCXFQfdbWDaLPjEfB0Y19DUea/v4Dkos05uqahnKqoXeY
uou/Mb71jxm2hRXBErwdU6FwLNs8YUOaIisM8OJt23nuYwxUxc+eUlbhVJrZdoC6
8rcQFumunYfV28VPWY08Eg9C0s9mIC3l425YtW4nTEhkWrH79ItDV9pxK0SIFL0/
Uxq9aPa4Atfez0zBxjm1TlCQq97PVB1Fq8XVGk7oHSagt0OnGKDLOADHJIGT2p1r
4Qc9fHtdiAhoT5R1Y/ij9Y6iENgYiQ==
=L4Xc
-----END PGP SIGNATURE-----

--6dN3mdgjpl0Ui4uSs4QGeuoPWgjuPBNO1--
