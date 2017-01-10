Received: from eggs.gnu.org ([2001:4830:134:3::10]:53045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cR0jT-0000nC-Q3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cR0jQ-0006Dq-PO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:01:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cR0jQ-0006Db-JK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:01:12 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 935AD4DD7C
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:01:12 +0000 (UTC)
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
	<20170110174810.17748-6-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df225d27-6b68-797d-8ba5-9efa2d4a8612@redhat.com>
Date: Tue, 10 Jan 2017 12:01:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170110174810.17748-6-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tkVuxmt3V2c5GkQtpW4uvpEdulmoQmswx"
Subject: Re: [Qemu-devel] [PATCH v2 05/20] char: use a const CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tkVuxmt3V2c5GkQtpW4uvpEdulmoQmswx
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <df225d27-6b68-797d-8ba5-9efa2d4a8612@redhat.com>
Subject: Re: [PATCH v2 05/20] char: use a const CharDriver
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
 <20170110174810.17748-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 11:47 AM, Marc-Andr=C3=A9 Lureau wrote:
> No need to allocate & copy fields, let's use static const struct
> instead.

Missing these sentences:

Add an alias field to the CharDriver structure to cover the cases where
we previously registered a driver twice under two names.  The name field
is no longer necessary, since we can now use a QAPI enum lookup.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

R-by stands, just the commit message needs improvement.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tkVuxmt3V2c5GkQtpW4uvpEdulmoQmswx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdSFgAAoJEKeha0olJ0NqMyAH/3BOafkCZzUFHyTySEYYUeUj
hRYX5SMp8hEQarCHyTdHp8wjjNRxturuNhb7ADZyK+LzeqyqIaXtQV914wQxPxbh
UA6g3r+TD2HGGC7H5+meRp85ygK/bJ3OUce21UyNlMO1x7OTRE3KLkS9RSBl75En
zz4/laR1ZzYXU7l+YLc5R0uYfLe5NcDCmA8fh0Rio9v0SeFj4O+zTrY4y46gCsr9
tLBCyZkGnQ4O9lb31TJAZvhwdvAko7nr4086M+sqvmyBraRiKo/Gt6Z0Gw88l2bb
/8LOQUsr8Agj9Jtv6LyBz8Jylq9DEoiWvjTbtftNeQQOR1BBAWwrwL9s4KLKQCs=
=bEWF
-----END PGP SIGNATURE-----

--tkVuxmt3V2c5GkQtpW4uvpEdulmoQmswx--
