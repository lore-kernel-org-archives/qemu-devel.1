Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctJo4-0002oo-Mp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctJo3-0001oE-PQ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:03:00 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7caffda9-7cbb-4044-7b6a-e398ffa125a6@redhat.com>
Date: Wed, 29 Mar 2017 15:02:51 -0500
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="amuEHc5jFeOipUXuXdQvcd2O2FqsCk0b8"
Subject: Re: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat
 variants 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--amuEHc5jFeOipUXuXdQvcd2O2FqsCk0b8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <7caffda9-7cbb-4044-7b6a-e398ffa125a6@redhat.com>
Subject: Re: [for-2.9 6/8] qapi-schema: SocketAddressFlat variants 'vsock' and
 'fd'
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2017 11:45 AM, Markus Armbruster wrote:
> Note that the new variants are impossible in qemu_gluster_glfs_init(),
> because the gconf->server can only come from qemu_gluster_parse_uri()
> or qemu_gluster_parse_json(), and neither can create anything but
> 'tcp' or 'unix'.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c  |  2 ++
>  qapi-schema.json | 19 ++++++++-----------
>  2 files changed, 10 insertions(+), 11 deletions(-)

> +# This is just like SocketAddress, except it's a flat union rather
> +# than a simple union.  Nicer because it avoids nesting (i.e. more {})=

> +# on the wire.
>  #
>  # Since: 2.9
>  ##
>  { 'union': 'SocketAddressFlat',
>    'base': { 'type': 'SocketAddressFlatType' },
>    'discriminator': 'type',
> -  'data': { 'unix': 'UnixSocketAddress',
> -            'inet': 'InetSocketAddress' } }
> +  'data': { 'inet': 'InetSocketAddress',
> +            'unix': 'UnixSocketAddress',
> +            'vsock': 'VsockSocketAddress',
> +            'fd': 'String' } }

Can we make 'fd':'str'?  That would be even less pointless nesting on
the wire.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--amuEHc5jFeOipUXuXdQvcd2O2FqsCk0b8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3BLrAAoJEKeha0olJ0NqJvsH/iSwHGg9lvtad8jrH+rmG/VF
JwJIoGDYdZPeDkC+aS3J/BVfPV+PnNtmOh9GRL/cwCSxT6LCrxJJT3R/XJN8jRDD
FnCJDxDNQ8cLiiEmS8hhuOBwWzkQlz/P3bjLDfTapmXGUvpEWEcYX9ia8HM08uP8
W5ecq2VGMDUycLsQAbFh3fF+3NOOU8lma2Y26S0mb3uP+mGYOOnP4ki4iw1g+VX5
wAR8xSIuEa+Hl9U1R1w7fkEWBp0qb49hMI1tUSN5lQA60P3G3LvI6uKoGMD32ZWS
cLdlb/z3mbOHKFt3/X71YIAFo+mXoiqQNIzo5eGx8gzbn7GuasOIm4YdUcqW5qc=
=TFxa
-----END PGP SIGNATURE-----

--amuEHc5jFeOipUXuXdQvcd2O2FqsCk0b8--
