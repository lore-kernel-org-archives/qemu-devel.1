Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjTCs-0002tp-Tj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjTCn-0004z3-7n
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:03:54 -0500
References: <20170302122429.7737-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61211fbf-c397-deb8-0726-848dc716fc96@redhat.com>
Date: Thu, 2 Mar 2017 10:03:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170302122429.7737-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="35AndKl3NFHxHkJQ10MF8rroTF6GaiW86"
Subject: Re: [Qemu-devel] [PATCH] qmp: allow setting properties to empty
 string in qmp-shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--35AndKl3NFHxHkJQ10MF8rroTF6GaiW86
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <61211fbf-c397-deb8-0726-848dc716fc96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: allow setting properties to empty
 string in qmp-shell
References: <20170302122429.7737-1-berrange@redhat.com>
In-Reply-To: <20170302122429.7737-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 06:24 AM, Daniel P. Berrange wrote:
> The qmp-shell property parser currently rejects attempts to
> set string properties to the empty string eg
>=20
>   (QEMU) migrate-set-parameters  tls-hostname=3D
>   Error while parsing command line: Expected a key=3Dvalue pair, got 't=
ls-hostname=3D'
> command format: <command-name>  [arg-name1=3Darg1] ... [arg-nameN=3Darg=
N]
>=20
> This is caused by checking the wrong condition after splitting
> the parameter on '=3D'. The "partition" method will return "" for
> the separator field, if the seperator was not present, so that
> is the correct thing to check for malformed syntax.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Probably worth having in 2.9, since we are having the parallel
discussion about permitting an empty string as a way to clear out TLS in
migration parameters.

>=20
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 0373b24..eccb88a 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -166,8 +166,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> =20
>      def __cli_expr(self, tokens, parent):
>          for arg in tokens:
> -            (key, _, val) =3D arg.partition('=3D')
> -            if not val:
> +            (key, sep, val) =3D arg.partition('=3D')
> +            if sep !=3D '=3D':
>                  raise QMPShellError("Expected a key=3Dvalue pair, got =
'%s'" % arg)
> =20
>              value =3D self.__parse_value(val)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--35AndKl3NFHxHkJQ10MF8rroTF6GaiW86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuEJhAAoJEKeha0olJ0NqBbcIAIpdcNrIk30ewBjWuFdJZQUM
KuryXrvaFi0BwY3zqoB5pwGI+ZVP4Es5OMx+tLjCSnGDgT060zDng8XzINOFDbmU
AKQYYQgUZYF2Lav1Y3oPYxrt0pRqxyz6MX/1UW4vIFPfXwL6dWqkaCf/6hN8kVaD
fTlXWiA6feQagEOFaE9ii2tJR5y8f9nIAmKVayLxpa5l+5CAUb51Ji6ZKInwcqo0
9OcueHBM6+otlUfVS0QvqGFu8rYpI+HXgawASdCiz5OWKDSxoFtgD8T7c83vdscB
s8+PG3jE61833KevTOvQEdXh4YG0Dr8pBL6mTEa47uC8t5iZZIhXdWUiJJBV3gA=
=PzNY
-----END PGP SIGNATURE-----

--35AndKl3NFHxHkJQ10MF8rroTF6GaiW86--
