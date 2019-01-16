Received: from eggs.gnu.org ([209.51.188.92]:57961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjrAN-0007SJ-UP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjrAN-0004fH-0N
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 14:47:59 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-15-eblake@redhat.com>
	<cca07ea7-4778-1469-fd36-b6f4f7691476@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be13579b-6007-a6f4-3e04-f54d01033cb5@redhat.com>
Date: Wed, 16 Jan 2019 13:47:50 -0600
MIME-Version: 1.0
In-Reply-To: <cca07ea7-4778-1469-fd36-b6f4f7691476@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nKXerQjgDMu08sddckQNXvgPJFkWL3v6T"
Subject: Re: [Qemu-devel] [PATCH v3 14/19] nbd/client: Pull out oldstyle
 size determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nKXerQjgDMu08sddckQNXvgPJFkWL3v6T
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <be13579b-6007-a6f4-3e04-f54d01033cb5@redhat.com>
Subject: Re: [PATCH v3 14/19] nbd/client: Pull out oldstyle size determination
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-15-eblake@redhat.com>
 <cca07ea7-4778-1469-fd36-b6f4f7691476@virtuozzo.com>
In-Reply-To: <cca07ea7-4778-1469-fd36-b6f4f7691476@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 9:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:58, Eric Blake wrote:
>> Another refactoring creating nbd_negotiate_finish_oldstyle()
>> for further reuse during 'qemu-nbd --list'.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20181215135324.152629-18-eblake@redhat.com>
>> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Hmm, looking at this, I found that nbd_start_negotiate() has very unusu=
al semantics
> for @zeroes field, without any comment about it:
>=20
> It must be set to true before calling, and nbd_start_negotiate may set =
it to true.
>=20
> I think better is not to rely on caller initialization and set zeroes t=
o true at the
> beginning of nbd_start_negotiate().

Makes sense; done in my local tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nKXerQjgDMu08sddckQNXvgPJFkWL3v6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/imYACgkQp6FrSiUn
Q2owPAgAlGYvlehTy2hoYVWR27VL8bDkxaBdY6j9OUmUNxyoG+svIA+WCuh/3QeZ
rdOLJqv82boIkb6RwPgaOsX6LKpcUHjtjujC87uOU776/FMXIBzvxoTFTch2QrPg
Evh7fVlA4uSfi8MW7qCDtdephuutFQ05tU96rNHcXwhWjCES+dhi6Z+9rTHJShB5
+UNyU8+jn5WwFj2XQaB6BsitFhpKXuwyogAsZQ5KJLQ41hE3SzmtCrmc8Tn4X7Dy
bHgD4yccMIhxkAfOIQSMmgrroHx6SHeR9DFE/d7b+E4sbHANKjhHOsQL5As9j3wL
2trVVCDMYUXFmlWtTLEZLy6i3w14LQ==
=+AqV
-----END PGP SIGNATURE-----

--nKXerQjgDMu08sddckQNXvgPJFkWL3v6T--
