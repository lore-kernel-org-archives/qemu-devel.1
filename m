Received: from eggs.gnu.org ([2001:4830:134:3::10]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cROuZ-0001eU-QG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cROuY-0000td-U6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:50:19 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170111181432.18868-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fadb246-953f-7173-d274-95e294784644@redhat.com>
Date: Wed, 11 Jan 2017 13:50:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170111181432.18868-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8TeVKiBuQf2TlGx9b01NdEm4ufbxM7XpH"
Subject: Re: [Qemu-devel] [PATCH v4 03/25] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8TeVKiBuQf2TlGx9b01NdEm4ufbxM7XpH
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <8fadb246-953f-7173-d274-95e294784644@redhat.com>
Subject: Re: [PATCH v4 03/25] block: Add BDS.backing_overridden
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170111181432.18868-4-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 12:14 PM, Max Reitz wrote:
> If the backing file is overridden, this most probably does change the
> guest-visible data of a BDS. Therefore, we will need to consider this i=
n
> bdrv_refresh_filename().
>=20
> Adding a new field to the BDS is not nice, but it is very simple and
> exactly keeps track of whether the backing file has been overridden.
>=20
> This commit adds a FIXME which will be remedied by a follow-up commit.
> Until then, the respective piece of code will not result in any behavio=
r
> that is worse than what we currently have.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h |  1 +
>  block.c                   | 13 +++++++++++++
>  block/mirror.c            |  4 ++++
>  blockdev.c                | 16 ++++++++++++++++
>  4 files changed, 34 insertions(+)

Looks like our mails crossed; I gave R-b on v3 before seeing this was
posted, and don't see any changes. To aid any automated tools:
Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8TeVKiBuQf2TlGx9b01NdEm4ufbxM7XpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdoxzAAoJEKeha0olJ0NqcGcH/Rizh0YtXQZbmdZCb8Nm8A0F
yYSsgmGKfOH60JMTg/y6i4p/ZZLJyrN29GfbmPQY6P0TKyM5he1+zfRaQF4wMjMP
qvDGZcaXxDAUAd9p7AV1eb02XftHhWSZRPwLTarOYRdjHlfqZlZswEr6CU44PZk+
XUT91U5bdCrX0yCVoOPll9oznr36YVj21wNiS0fkqGANUSyJgzHbdmDq3o01kzt/
FkgIZVyinwdr7s6tJCjTnfKha+w9KoyTmydByB7P4SvtoQGIo5wSS7iM1rCoTmZy
ymQ85ChtaEeHNL5h1Z90T/fhjLE7nu77pRqHack+AONGgXDLaFHEJXIhByEgNxw=
=/osl
-----END PGP SIGNATURE-----

--8TeVKiBuQf2TlGx9b01NdEm4ufbxM7XpH--
