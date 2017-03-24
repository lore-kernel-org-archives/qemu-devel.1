Received: from eggs.gnu.org ([2001:4830:134:3::10]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUNX-0003M5-Cv
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUNS-00025G-FY
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:56:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crUNS-00024y-0N
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E69A183F47
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 18:55:57 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0187ac2-7eaf-e199-6d59-337ffc1a3ab1@redhat.com>
Date: Fri, 24 Mar 2017 13:55:55 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EbPmpsCN7J1TO4u6I5bJGAxr62axEQbGQ"
Subject: Re: [Qemu-devel] [PATCH RFC v2 6/9] rbd: Clean up runtime_opts,
 fix -drive to reject filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EbPmpsCN7J1TO4u6I5bJGAxr62axEQbGQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <a0187ac2-7eaf-e199-6d59-337ffc1a3ab1@redhat.com>
Subject: Re: [PATCH RFC v2 6/9] rbd: Clean up runtime_opts, fix -drive to
 reject filename
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> runtime_opts is used for three different purposes:

> This is a confusing mess.  Dates back to commit 0f9d252.  First step
> to clean it up is documenting runtime_opts.desc[]:
>=20
> * Reorder entries to match the QAPI schema, like we do in other block
>   drivers.
>=20
> * Document why the schema's "server" and "auth-supported" aren't in
>   .desc[].
>=20
> * Document why "keyvalue-pairs", "host", "port" and "auth" are in
>   .desc[], but not the schema.
>=20
> * Delete "filename", because none of the three users actually uses it.
>   This fixes -drive to reject parameter filename instead of silently
>   ignoring it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--EbPmpsCN7J1TO4u6I5bJGAxr62axEQbGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1Wu7AAoJEKeha0olJ0Nq2HAIALCGzAQAcOjs6tuEJwU6wg5f
pIZZUUs+MLaA6zBxEmfSpNA1iw5vPfAsUfULOKtV0d6cZAx5WQc67yMIsN/TSgEg
jk5JcTxWJ0O8CP/FYMHXR4LQEG8r9Lly7c2V6Lmh0tb1BdYZOjPhdk5fRyk05lmw
G2tzx+36/LqAOkH9lXHs0wFLkUerDGt1ClKmiERn2kYT7AimK1cAeRIDgJUiu8us
hGuVa81PhKsrvfnJcvLIKuNnuJ3xeYtdNjXNx4NGDGdsRee9PhY2gvGGlqfHFJ9K
eIEQweQPspeukVUYXfVkGIqzV/COmLtRvzt5jh4XpJ6fMPapj5He4P4IRDQFR5U=
=Sehd
-----END PGP SIGNATURE-----

--EbPmpsCN7J1TO4u6I5bJGAxr62axEQbGQ--
