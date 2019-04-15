Received: from eggs.gnu.org ([209.51.188.92]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG57N-0005R3-GT
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG57L-0000bb-LW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hG57I-0000a1-Om
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:10:01 -0400
References: <20190415154503.6758-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83042152-1af4-a237-92a1-f56841623e89@redhat.com>
Date: Mon, 15 Apr 2019 12:09:53 -0500
MIME-Version: 1.0
In-Reply-To: <20190415154503.6758-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ymvTUbF3rQUKbeYrVBWgwO5OqalrLIFOE"
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/3] usb-mtp: fix ObjectInfo
 request handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ymvTUbF3rQUKbeYrVBWgwO5OqalrLIFOE
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <83042152-1af4-a237-92a1-f56841623e89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/3] usb-mtp: fix ObjectInfo request
 handling
References: <20190415154503.6758-1-berrange@redhat.com>
In-Reply-To: <20190415154503.6758-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:45 AM, Daniel P. Berrang=C3=A9 wrote:
> Two previous attempts to fix this due to GCC 9 highlighting
> unaligned data access. My attempt:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html
>=20
> And a previous one:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html
>=20
> There are a number of bugs in the USB MTP usb_mtp_write_metadata
> method handling the filename character set conversion.
>=20
> The 2nd patch in this series is a security flaw fix since the
> code was not correctly validating guest provided data length.

Given that this is a security flaw, I've added this series to
https://wiki.qemu.org/Planning/4.0 in case you're hoping to get it in -rc=
4.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ymvTUbF3rQUKbeYrVBWgwO5OqalrLIFOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0uuEACgkQp6FrSiUn
Q2qtrAf9FBnDMipEPR1LxroU6iUSRcgJAAC8V2LFFCBNABhfNRY9zycrjQicUSuP
Jg3G9aqLqsmHEi3vIFSnVJCb4zoNZacpH+2L705AhWfzryLXujbEA7FVfjPBIRZ8
mXfL7UEnj7IuaSoh9xUdCRJra9twzztrJL4WwGWCkF6OaKg3gTxIlEipbLzZ67HV
Cq0VTurx+riwGnXOyQbvbrsnG15PZ8X8I2FcaXcHBR9c3R83vMdxb7hIh14ywPY1
AgX3amSNAfcE+xP9YybgmYCwUb4tGnwOJvfcl2jawUO6JlLSMM7/qMdYO87bNB75
SobAKQGALjiMQ8/Z/gGWQImptAJi5A==
=cnl7
-----END PGP SIGNATURE-----

--ymvTUbF3rQUKbeYrVBWgwO5OqalrLIFOE--
