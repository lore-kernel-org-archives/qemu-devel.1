Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjq6u-0004Sr-WE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjq6u-0002Yl-03
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:31:17 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-14-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90d9033f-49b2-6f00-d984-dbfd4f21f1da@redhat.com>
Date: Fri, 3 Mar 2017 10:31:08 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-14-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WVjcxvVdrhG4qj2keJWv2ecK03KunR71L"
Subject: Re: [Qemu-devel] [PATCH 13/15] qapi-schema: Rename GlusterServer to
 SocketAddressFlat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WVjcxvVdrhG4qj2keJWv2ecK03KunR71L
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <90d9033f-49b2-6f00-d984-dbfd4f21f1da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/15] qapi-schema: Rename GlusterServer to
 SocketAddressFlat
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:44 PM, Markus Armbruster wrote:
> As its documentation says, it's not specific to Gluster.  Rename it,
> as I'm going to use it for something else.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c      | 38 +++++++++++++++++++-------------------
>  qapi-schema.json     | 38 ++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json | 46 +-------------------------------------------=
--
>  3 files changed, 58 insertions(+), 64 deletions(-)

Mostly mechanical once you deal with the cross-file motion.  Changing
the type name has no impact on the wire representation, so it's safe.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/qapi-schema.json
> @@ -4101,6 +4101,44 @@
>      'fd': 'String' } }
> =20
>  ##
> +# @SocketAddressFlatType:
> +#
> +# Available SocketAddressFlat types
> +#
> +# @tcp:   Internet address
> +#
> +# @unix:  Unix domain socket
> +#
> +# Since: 2.9

I probably would have listed 'since: 2.7', since the type is unchanged
from its pre-move location...

> +#
> +# Since: 2.9
> +##
> +{ 'union': 'SocketAddressFlat',

and again


> +++ b/qapi/block-core.json
> @@ -2533,50 +2533,6 @@
>              '*read-pattern': 'QuorumReadPattern' } }
> =20
>  ##
> -# @GlusterTransport:
> -#
> -# An enumeration of Gluster transport types
> -#
> -# @tcp:   TCP   - Transmission Control Protocol
> -#
> -# @unix:  UNIX  - Unix domain socket
> -#
> -# Since: 2.7

=2E..here.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WVjcxvVdrhG4qj2keJWv2ecK03KunR71L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZpMAAoJEKeha0olJ0Nqax0H/049cVzYcNpoICb5RBEGCkU0
DJwHt0laE1O570/47BbOn45ANN5rVPda+rHvy0xzQ6dPVdF0nGdahVtJAdRJi1ij
mx4StByK4aTy27rON+yOC2HkODm4O1BPf3+6F1tLYKnKxsCdqxibi9G9gPDHbAb5
X/bSPtN8JFwnc8SWujk2FShcjWfDVE0zhpPVZuVPXlG3NoHSsNBrZ2FbEKf2E1JJ
JZ1+3bJZ7pLGj2OC/kT33Cew09KHrwo4jbScxHyYPwmexak4MhirrXuaeV1ec8L3
jlBk9O9r2GS2kx34Dd48xAS6phChUmdwv4zeLl5ZQ5C9t4c0RUIv8BRsHsCfqFw=
=vAZr
-----END PGP SIGNATURE-----

--WVjcxvVdrhG4qj2keJWv2ecK03KunR71L--
