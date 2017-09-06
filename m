Received: from eggs.gnu.org ([2001:4830:134:3::10]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpb0x-00020M-3x
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpb0s-0004fr-Do
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpb0s-0004fB-7R
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:09:06 -0400
References: <20170906135859.15831-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2437b92a-b9f3-91b5-0a76-7b1cc9a3d8de@redhat.com>
Date: Wed, 6 Sep 2017 09:09:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170906135859.15831-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kUX5uLsKJN8tsCb4KThd5rGtReGO9mcLt"
Subject: Re: [Qemu-devel] [PATCH] io: use case insensitive check for
 Connection & Upgrade websock headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Brian Rak <brak@vultr.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kUX5uLsKJN8tsCb4KThd5rGtReGO9mcLt
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Brian Rak <brak@vultr.com>
Message-ID: <2437b92a-b9f3-91b5-0a76-7b1cc9a3d8de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: use case insensitive check for
 Connection & Upgrade websock headers
References: <20170906135859.15831-1-berrange@redhat.com>
In-Reply-To: <20170906135859.15831-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 08:58 AM, Daniel P. Berrange wrote:
> When checking the value of the Connection and Upgrade HTTP headers
> the websock RFC (6455) requires the comparison to be case insensitive.
> The Connection value should be an exact match not a substring.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 4 ++--

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kUX5uLsKJN8tsCb4KThd5rGtReGO9mcLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwAX4ACgkQp6FrSiUn
Q2r8cgf7BT/phKkmMyQAAxwSjz1+DgK7KbrBlTxlw9wPhIW/H9x1baHXMNXYoZzI
gz6KecWz4UO13ZTn/PPvM/kKyg0+B8fNB+rVnC3wrE2DO4bIbo/p9f0LZfhN846S
HwCT752EQ9R1Ds5e0wuy9djxVoxqf0T4m//zqRLyWhbmjaJPJm8oc5/qyb1nhfWn
UNQShGenh/C6t8Ctfyh4ePIBkzaj1fN/pMRtvQv9OlqO0TUkNVR3p/ioTyhvseI2
M+jMWrToNclmT3Ks+3NjLrMf/VtEMDWyaSlVhErMv+WVJ3X0725EvZLyU+kHpmBE
VaMDc/qp+cCcmaMyainyKppK9CYewg==
=F6Zu
-----END PGP SIGNATURE-----

--kUX5uLsKJN8tsCb4KThd5rGtReGO9mcLt--
