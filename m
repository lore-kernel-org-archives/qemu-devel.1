Received: from eggs.gnu.org ([2001:4830:134:3::10]:52553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WZl-0008VJ-Js
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WZk-0003bJ-IX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:47:37 -0400
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-2-nirsof@gmail.com>
	<20180416103118.GH17600@redhat.com>
	<20180416105341.GF2209@redhat.com> <20180416110023.GJ17600@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef17e494-294a-86e7-e77d-b0ce3b0c0908@redhat.com>
Date: Tue, 17 Apr 2018 14:47:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180416110023.GJ17600@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NIvnaTVq7bexSzLBf7O9ePThpltFoWpay"
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd: Add option to disallow listing
 exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NIvnaTVq7bexSzLBf7O9ePThpltFoWpay
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com
Message-ID: <ef17e494-294a-86e7-e77d-b0ce3b0c0908@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd: Add option to disallow listing
 exports
References: <20180413192605.2145-1-nirsof@gmail.com>
 <20180413192605.2145-2-nirsof@gmail.com> <20180416103118.GH17600@redhat.com>
 <20180416105341.GF2209@redhat.com> <20180416110023.GJ17600@redhat.com>
In-Reply-To: <20180416110023.GJ17600@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/16/2018 06:00 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Apr 16, 2018 at 11:53:41AM +0100, Richard W.M. Jones wrote:
>> On Mon, Apr 16, 2018 at 11:31:18AM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>>> Essentially this is abusing the export name as a crude authentication=

>>> token. There are NBD servers that expect NBD_OPT_LIST to always succe=
eed
>>
>> I guess you mean "NBD clients" ...
>=20
> Sigh, yes, of course.

qemu 2.10 and older tries to use NBD_OPT_LIST, but gracefully still
tries to connect even if the LIST fails (that is, it's use of
NBD_OPT_LIST was for better error handling than what NBD_OPT_EXPORT_NAME
gives, and not because it actually needed the list).  The recent
introduction in qemu 2.11 for support of NBD_OPT_GO means that modern
qemu is no longer even attempting NBD_OPT_LIST when talking to a new
server.  But cross-implementation compatibility is still a concern, and
there may indeed be non-qemu clients that choke if LIST fails, even
though...

>=20
>>> when they detect that the new style protocol is available. I really h=
ate
>>> the idea of making it possible to break the NBD_OPT_LIST functionalit=
y
>>> via a command line arg like this.

=2E..the NBD spec suggests that a client that requires LIST to work is no=
t
fully compliant, since NBD_OPT_LIST is an optional feature.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NIvnaTVq7bexSzLBf7O9ePThpltFoWpay
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWT0gACgkQp6FrSiUn
Q2pfBAf9Fl+551rkl45NedvshXAPsP5FfxZF3yKIHBL+lWTjpFD22MdabebAHb/W
BunHMLMqQo5uWGaUVE6gOW+VQgyb8jucUXpW0VuY74cWgAHSqYoDyPMlY2y3ii8Z
HAr0N0OqxbnGie4f0qG14rk3BQAG2pDnqT0V1lBKsNCssLgP3f0hA6OX/6Gfvasz
fMW/waTomi3Wy5gyja3basEyQJd+dy8jSXEi1eHDFKeLEKLXopTFMvJvQtPh6mga
GZIepLNXhcbNGoRGjrBcYTDc53q3imYwj80isYZBssfun+DWBg/T55rV96NR0cKY
idq/zBeNKzhsNzIdQtA9VVbqU5NE3Q==
=mHKc
-----END PGP SIGNATURE-----

--NIvnaTVq7bexSzLBf7O9ePThpltFoWpay--
