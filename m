Received: from eggs.gnu.org ([2001:4830:134:3::10]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntAp-00008l-Qq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntAp-0007sK-2q
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntAo-0007r2-Jf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:36:02 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-31-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f076574a-0845-7636-ed10-84327364cfce@redhat.com>
Date: Tue, 14 Mar 2017 15:36:00 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-31-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GneWLnGMbwVlROTvltp2FaWLXiUduXOJQ"
Subject: Re: [Qemu-devel] [PATCH for-2.9 30/47] tests/qapi-schema: Improve
 doc / expression mismatch coverage
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
--GneWLnGMbwVlROTvltp2FaWLXiUduXOJQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <f076574a-0845-7636-ed10-84327364cfce@redhat.com>
Subject: Re: [PATCH for-2.9 30/47] tests/qapi-schema: Improve doc / expression
 mismatch coverage
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-31-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-31-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> New test doc-bad-expr.json shows we fail to reject a misplaced
> expression comment.
>=20
> New test doc-no-symbol.json shows a bad error message.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/tests/qapi-schema/doc-bad-expr.json
> @@ -0,0 +1,8 @@
> +# Doc comment separated from defining expression by non-defining expre=
ssion
> +# BUG: not rejected
> +
> +##
> +# @foo:
> +##
> +{ 'include': 'empty.json' }
> +{ 'struct': 'foo', 'data': {} }

See my comments on 31/47 for an enhancement to this test that also
sticks a { 'pragma': {} } there.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GneWLnGMbwVlROTvltp2FaWLXiUduXOJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFQwAAoJEKeha0olJ0NqPecIAJHFraM4NZcAgzPGkf65quit
a/cTDlboa71RzE+FalHLqx88bxUmBwUH9YceyI/FPbN5XrNZVSfUoggjFsBlgkTh
0ri1eQwAHoP/qPA5v22fksl2a/i+48OlMNe5QoNuyaGpbJccdc5xOQhzvcLq4NKJ
+zQjSe8INYB+OgTJCmuGpCenqBcrhXt8m/i0RkD1NAlYe8afFxpguaTxvH7wWCbE
HucEACTY56bKU7MJFk77zITpXtS1Ewa759irXYWziMIQk84HGP45Ty2qgbj0EEx5
zbVdelVdI5bnxQ5Z/PwToS1SrbLRqkf2qO+37+qWcyr1ROJfJMhQeEsAvzgFe/I=
=WORp
-----END PGP SIGNATURE-----

--GneWLnGMbwVlROTvltp2FaWLXiUduXOJQ--
