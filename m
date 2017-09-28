Received: from eggs.gnu.org ([2001:4830:134:3::10]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxdVX-0004iD-90
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxdVU-0005HC-3X
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxdVT-0005GS-Qm
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:25:56 -0400
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d611c0b-7920-2e3a-39c7-a3dff1b2b586@redhat.com>
Date: Thu, 28 Sep 2017 13:25:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170928120621.30288-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ceHx62Nn5PV4DXmA2PgVK995nRJWdCsW9"
Subject: Re: [Qemu-devel] [PATCH v7 4/6] ui: convert common input code to
 keycodemapdb
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ceHx62Nn5PV4DXmA2PgVK995nRJWdCsW9
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d611c0b-7920-2e3a-39c7-a3dff1b2b586@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/6] ui: convert common input code to
 keycodemapdb
References: <20170928120621.30288-1-berrange@redhat.com>
 <20170928120621.30288-5-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> Replace the number_to_qcode, qcode_to_number and linux_to_qcode
> tables with automatically generated tables.
>=20
> Missing entries in linux_to_qcode now fixed:
>=20
>   KEY_LINEFEED -> Q_KEY_CODE_LF
>   KEY_KPEQUAL -> Q_KEY_CODE_KP_EQUALS
>   KEY_COMPOSE -> Q_KEY_CODE_COMPOSE
>   KEY_AGAIN -> Q_KEY_CODE_AGAIN
>   KEY_PROPS -> Q_KEY_CODE_PROPS
>   KEY_UNDO -> Q_KEY_CODE_UNDO
>   KEY_FRONT -> Q_KEY_CODE_FRONT
>   KEY_COPY -> Q_KEY_CODE_COPY
>   KEY_OPEN -> Q_KEY_CODE_OPEN
>   KEY_PASTE -> Q_KEY_CODE_PASTE
>   KEY_CUT -> Q_KEY_CODE_CUT
>   KEY_HELP -> Q_KEY_CODE_HELP
>   KEY_MEDIA -> Q_KEY_CODE_MEDIASELECT
>=20
> In additionsome fixes:

s/additionsome/addition, some/

>=20
>  - KEY_PLAYPAUSE now maps to Q_KEY_CODE_AUDIOPLAY, instead of
>    KEY_PLAYCD. KEY_PLAYPAUSE is defined across almost all scancodes
>    sets, while KEY_PLAYCD only appears in AT set1, so the former is
>    a more useful mapping.
>=20
> Missing entries in qcode_to_number now fixed:
>=20
>   Q_KEY_CODE_AGAIN -> 0x85
>   Q_KEY_CODE_PROPS -> 0x86
>   Q_KEY_CODE_UNDO -> 0x87
>   Q_KEY_CODE_FRONT -> 0x8c
>   Q_KEY_CODE_COPY -> 0xf8
>   Q_KEY_CODE_OPEN -> 0x64
>   Q_KEY_CODE_PASTE -> 0x65
>   Q_KEY_CODE_CUT -> 0xbc
>   Q_KEY_CODE_LF -> 0x5b
>   Q_KEY_CODE_HELP -> 0xf5
>   Q_KEY_CODE_COMPOSE -> 0xdd
>   Q_KEY_CODE_KP_EQUALS -> 0x59
>   Q_KEY_CODE_MEDIASELECT -> 0xed
>=20
> In addition some fixes:

Hmm - inconsistent with my suggestion above with regards to comma usage;
I think this is one scenario in English where you can get away without
the comma, even though I would use it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ceHx62Nn5PV4DXmA2PgVK995nRJWdCsW9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNPqsACgkQp6FrSiUn
Q2oNggf9HG0oixZUOOfOPQAK++vAUj0JGJttJ6e/QiJjdHhrBBgKXo3dfIlc+h+V
143g09iP4BsveqUHjBLxc/XTte+0P1kJan4OmdUjhqK/8205RQWealgsA/7QkkF7
xC3Qrec7B/4mCtfZK5MwngvoFBm9bQNibVaCt2C+lidDFLDeB5irHdUfjjUmGaH+
m0Gp1C99/6nBFWq7ZDXDNmducatFVeZqS3Wygavom1vxX1D782f6dJ75SmTOEeaG
M2tfRfQFCs2/X5IdxzhQtoEHnnh2tmHncsrI5zCeM03mENd30+H42L6Q9uVhQImN
VOv2DQUbg+8rswS786HjvONoKSvhrQ==
=/6fJ
-----END PGP SIGNATURE-----

--ceHx62Nn5PV4DXmA2PgVK995nRJWdCsW9--
