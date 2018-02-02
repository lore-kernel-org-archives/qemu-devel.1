Received: from eggs.gnu.org ([2001:4830:134:3::10]:39098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd61-0004pK-8b
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd5y-0003TN-Tr
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:17:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehd5y-0003TC-Jn
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:17:42 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b39ec0c6-b2b4-6719-c7ca-0815b6fc76b8@redhat.com>
Date: Fri, 2 Feb 2018 09:08:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-2-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cai4oo15jzsxAHGHS4bobLG3FwaIaoFVp"
Subject: Re: [Qemu-devel] [PATCH RFC 01/21] qapi: Streamline boilerplate
 comment generation
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
--cai4oo15jzsxAHGHS4bobLG3FwaIaoFVp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <b39ec0c6-b2b4-6719-c7ca-0815b6fc76b8@redhat.com>
Subject: Re: [PATCH RFC 01/21] qapi: Streamline boilerplate comment generation
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-2-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Every generator has separate boilerplate for .h and .c, and their
> differences are boring.  All of them repeat the license note.
>=20
> Reduce the repetition as follows.  Move common text like the license
> note to common open_output(), next to the existintg common text there.

s/existintg/existing/

> For each generator, replace the two separate descriptions by a single
> one.
>=20
> While there, emit an "automatically generated" note into generated
> documentation, too.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/scripts/qapi2texi.py
> @@ -282,7 +282,8 @@ def main(argv):
>          print >>sys.stderr, ("%s: need pragma 'doc-required' "
>                               "to generate documentation" % argv[0])
>          sys.exit(1)
> -    print texi_schema(schema)
> +    print '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n'
> +    print texi_schema(schema),

Spurious addition of trailing comma. Otherwise,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cai4oo15jzsxAHGHS4bobLG3FwaIaoFVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0fvgACgkQp6FrSiUn
Q2pZ6Qf/V4hPOuGctytNWOBO8HBczwp7WIo9iG0+5gEdTdxHHbX7djjjx0JlMhME
wvHj38SSqdUSpjg1/PAxmpsjFoKeuyootoldW1fXZSa9DnpiBaM/R19GEGHQjVJp
9S49hS6jiNFrkeeje39lJBP4/DTc1O46uYAbhn3gZHZr7ZiQDgeCi0vKOZ1AY6EN
yyj173m9qFqkvj3Zq1uFKgFY9FsBoYB20R1TnFBqS8vyTJiOg1wYeoQhofJkRrHP
1cqM1MXlY7juwfKUYFz4FoQ0CMnYlbx15uMiJkBzbaN7gU7KiiNlKUaYy8NnD1dT
xvSO6ktriL/d5hRs1w1WbJ7HTA1IMQ==
=W3pA
-----END PGP SIGNATURE-----

--cai4oo15jzsxAHGHS4bobLG3FwaIaoFVp--
