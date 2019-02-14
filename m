Received: from eggs.gnu.org ([209.51.188.92]:57305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guOVb-00038Z-EO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guOOp-0006Ux-Ny
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:18:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1guOOm-0006QM-2f
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:18:25 -0500
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-2-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29ca5026-ea03-b0fe-5a59-336de614ead3@redhat.com>
Date: Thu, 14 Feb 2019 15:18:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190214201939.494-2-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QwCd3NDIMetxChyD5RSuaZy2CztykuvXp"
Subject: Re: [Qemu-devel] [PATCH v2 1/9] ccid-card-passthru: Move assertion
 in read() to can_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QwCd3NDIMetxChyD5RSuaZy2CztykuvXp
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <29ca5026-ea03-b0fe-5a59-336de614ead3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/9] ccid-card-passthru: Move assertion in
 read() to can_read()
References: <20190214201939.494-1-philmd@redhat.com>
 <20190214201939.494-2-philmd@redhat.com>
In-Reply-To: <20190214201939.494-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/14/19 2:19 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> chardev::read() depends of what chardev::can_read() returns, move the

s/of/on/

> assertion to can_read().
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/usb/ccid-card-passthru.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--QwCd3NDIMetxChyD5RSuaZy2CztykuvXp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxl2xIACgkQp6FrSiUn
Q2oWBgf+PI41lgMTFzUKSn7TNDQHnjKU/FMTMBqoK2At/9vRt/nAbj9TmwKHAs/9
wUBSRUKNCcWCvR1GBFHQX7zxZzoZ3OTxvl24MV1E2aw+I/ybOpps8zsAxrGo2YH1
lpiAgi1EKfotR/o3Gebjxq/x+qAO/Q9/aqAz1n+al1rYpsdwY84pG09tQA230mzV
JeCA83k2vN/MVh6QLxIa9fVB2AxWSPbbY82u8ErsGDeegD+kU1BMG0YzXywuQihT
A5iNeyL73b2zAwDDtF8Plel7fsGaoCuC0X3tBEfJXEMj8VZ58p4x1//MA4PfMg5f
2S2MVbK9m9dtOt1hamJhwPZGhXBtFA==
=zpcN
-----END PGP SIGNATURE-----

--QwCd3NDIMetxChyD5RSuaZy2CztykuvXp--
