Received: from eggs.gnu.org ([2001:4830:134:3::10]:59591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9Lym-0006I8-A5
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9Lyl-0003xK-D6
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:13:08 -0400
Date: Mon, 8 Oct 2018 13:05:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181008020559.GT7004@umbus.fritz.box>
References: <20181005092024.14344-1-david@redhat.com>
	<20181005092024.14344-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gSSGYPGSs0dvYOj7"
Content-Disposition: inline
In-Reply-To: <20181005092024.14344-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/16] memory-device: improve "range
 conflicts" error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>


--gSSGYPGSs0dvYOj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 11:20:11AM +0200, David Hildenbrand wrote:
> Handle id=3D=3DNULL better and indicate that we are dealing with memory
> devices.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/memory-device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 7c706fadfc..0624184c40 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -175,7 +175,8 @@ uint64_t memory_device_get_free_addr(MachineState *ms=
, const uint64_t *hint,
>          if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>              if (hint) {
>                  const DeviceState *d =3D DEVICE(md);
> -                error_setg(errp, "address range conflicts with '%s'", d-=
>id);
> +                error_setg(errp, "address range conflicts with memory de=
vice"
> +                           " id=3D'%s'", d->id ? d->id : "(unnamed)");
>                  goto out;
>              }
>              new_addr =3D QEMU_ALIGN_UP(md_addr + md_size, align);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gSSGYPGSs0dvYOj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu6u4cACgkQbDjKyiDZ
s5L+kRAAvoPeQQiKn0OPw6fmGoub2Y5S3SiP7y96pESDlVxC/37lYYMgwv5DWhxj
BLHWCVPlyHs5rXDmXqRfdz5UBKULJrZomyZwMMk8JdHK9DBBpuBNto3vxJPKreF7
UAhR8YkKfy8ycR0lF3mpD1vG8pDJ3gfC9nvf+nV8iZmLRivU/bt47e7q2FLPgweW
FqnebUiaDocRcxOhHc+kVEChptPeBwKpatO1MuCeWZYrt2jC6ZHXFv0BFRKp24hh
nDUDLRQafqMfl7GXqzs2ZGXgX60+U93eP0aZclp/ZOq4P6Lwk0iyJ0wJNsreh9CD
8iiyMe+m9Yn+UXg+/kjWl48Dznq3HWXA8hh6yHwhkM5eZWqIYj9lyUKEyQ2bXLGO
BkdYnyGbLgA0FggR8GswnUiDO5JdZR6lcBVKeuFp7ROcO8cxFEdziirPs0IwcSFx
Yu/MNiaDk9rjqsAdkaLABEv9yHGHx5oNv1HnkoqJF+MP7e3wkgJIO6SY/5mpCXI8
3svs+A55Js7R7+Gd5Wv8yZFRcQukIPHMlZOw949U1vzXb62ZogAp2Z+tyKbm0SzE
TEn0SBRzcZsF+bbiV28S8KEo2DMXaBl9NC0YhLzN7fSBFY31X8YbdVw3pQ02byR6
5l1pcvgmJFlHWlkkyFA2qw0/xtuJrtnMKXBnVQfy9vgGHXHoByQ=
=Je5Z
-----END PGP SIGNATURE-----

--gSSGYPGSs0dvYOj7--
