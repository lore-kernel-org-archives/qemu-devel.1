Received: from eggs.gnu.org ([2001:4830:134:3::10]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckBQH-0002sz-Bl
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckBQD-0003qZ-CP
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:16:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckBQD-0003pj-5Q
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:16:37 -0500
References: <148862487677.5452.160308730808722965.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd56fb9b-2aa8-1787-cd44-ab8b80f0ccac@redhat.com>
Date: Sat, 4 Mar 2017 09:16:34 -0600
MIME-Version: 1.0
In-Reply-To: <148862487677.5452.160308730808722965.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="49xLq5BpKMcjmlq1hcsskQ1sGt622kF7s"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: don't use AT_EMPTY_PATH in
 local_set_cred_passthrough()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--49xLq5BpKMcjmlq1hcsskQ1sGt622kF7s
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <dd56fb9b-2aa8-1787-cd44-ab8b80f0ccac@redhat.com>
Subject: Re: [PATCH] 9pfs: don't use AT_EMPTY_PATH in
 local_set_cred_passthrough()
References: <148862487677.5452.160308730808722965.stgit@bahia.lan>
In-Reply-To: <148862487677.5452.160308730808722965.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2017 04:54 AM, Greg Kurz wrote:
> The name argument can never be an empty string, and dirfd always point =
to
> the containing directory of the file name. AT_EMPTY_PATH is hence usele=
ss
> here. Also it breaks build with glibc version 2.13 and older.
>=20
> It is actually an oversight of a previous tentative patch to implement =
this
> function. We can safely drop it.
>=20
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--49xLq5BpKMcjmlq1hcsskQ1sGt622kF7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYutpSAAoJEKeha0olJ0NqXjUH/jg+VqIuqpd8xE3+QrtXHdwN
aiXnl1RZLXOeXY+zP20pUfwOFCIpcW67Fzh+kYSheXVRlMMX96yPZQ4Duz/FjDue
x1jc+fw0195nfMGVGPsQfe4rdWw8WNzBoz4aDk2ZwR5NJVUjEUSyBhOYVMd+ClWh
hUREp6tiuaWASPHp5RdeZ8nPekCU8FBBQJ8n9Ede0PnIoCiFUN2KlUoO9tLNtZYa
OhyJYYZcKQhaW+f17HPHPvQ0hdHaz5yfQ/NDrY3337a6XVq/FRYlm3LvuotmjXlu
N9hGtAAiCYWjb+VO9tVr/5I2KrG9nBvZvqp+GvfOvdhPB+CeCYOwkQ2aVsjZ0LE=
=I1UE
-----END PGP SIGNATURE-----

--49xLq5BpKMcjmlq1hcsskQ1sGt622kF7s--
