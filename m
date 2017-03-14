Received: from eggs.gnu.org ([2001:4830:134:3::10]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsF3-0007ue-Fb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsF0-00075W-BK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnsF0-00073R-3N
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:36:18 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-28-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <370b0db7-c576-265e-c4ab-aad5c0146d3d@redhat.com>
Date: Tue, 14 Mar 2017 14:36:15 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-28-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CNbJjvv1TTDNjRgm2UfphIqDwb6AD13Cf"
Subject: Re: [Qemu-devel] [PATCH for-2.9 27/47] qapi2texi: Generate
 documentation for variant members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CNbJjvv1TTDNjRgm2UfphIqDwb6AD13Cf
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <370b0db7-c576-265e-c4ab-aad5c0146d3d@redhat.com>
Subject: Re: [PATCH for-2.9 27/47] qapi2texi: Generate documentation for
 variant members
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-28-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-28-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> A flat union's branch brings in the members of another type.  Generate
> a suitable reference to that type.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Flat Union: QCryptoBlockOpenOptions
>=20
>       The options that are available for all encryption formats when
>       opening an existing volume
>=20
>       Members:
>       The members of 'QCryptoBlockOptionsBase'
> +     The members of 'QCryptoBlockOptionsQCow' when 'format' is "qcow"

Relies on the implied knowledge that 'format' is a member of
'QCryptoBlockOptionsBase'. Does that mean references to another type
might usefully want to do a list of member names, to avoid having to
follow the hyperlink, while still leaving the hyperlink when searching
for full details on that member?  As in:

Members:
The members of 'QCryptoBlockOptionsBase' ('format')
The members of 'QCryptoBlockOptionsQCow' when 'format' is "qcow"
('key-secret')

But it could get noisy (the example here only adds one member; other
unions add lots of members), and I'm also okay if you don't like the
idea or would rather do it as a followup.

> +     The members of 'QCryptoBlockOptionsLUKS' when 'format' is "luks"
>=20
>       Since: 2.6
>=20
> A simple union's branch adds a member 'data' of some other type.
> Generate documentation for that member.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Simple Union: SocketAddress
>=20
>       Captures the address of a socket, which could also be a named fil=
e
>       descriptor
>=20
>       Members:
>       'type'
> 	   Not documented
> +     'data: InetSocketAddress' when 'type' is "inet"
> +     'data: UnixSocketAddress' when 'type' is "unix"
> +     'data: VsockSocketAddress' when 'type' is "vsock"
> +     'data: String' when 'type' is "fd"

Looks reasonable.

>=20
>       Since: 1.3
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CNbJjvv1TTDNjRgm2UfphIqDwb6AD13Cf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyEYvAAoJEKeha0olJ0Nq1JAIAKp2QG+P1eeC2V52vPXEEQ+6
uxnmXYpIV4g0BXhRtqXR1JRd3a5jIFbKcWiZqvHxRmNoY2GmMEWn9ro+o6xnin1u
VZJiIpsDT2+THSozKRkGENJLJ4yPPcp0MfH6N8HYat8+VnuTSA56YHTIr7Kdvt7I
/6bTrtuKI3XDDNiB7YfEBKpZAND+XU3mAstZcsuBhf3j6N/WVKIfD1bkrz2dHOeI
+XUVnqMoe7FiK1aAoswvwultx37Ji6dTUqfL3W7o4IsoX8KdSfxq2CE/o7AsP8/I
F3jJVyffgcPPc5JXM6MZykaCMKodbdx1OIl57tzRUQwEAJ8yrKxagylyWJpD6jw=
=rBpc
-----END PGP SIGNATURE-----

--CNbJjvv1TTDNjRgm2UfphIqDwb6AD13Cf--
