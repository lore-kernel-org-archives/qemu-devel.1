Received: from eggs.gnu.org ([2001:4830:134:3::10]:42133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgVEq-00042O-NF
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 08:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgVEm-0006JT-1w
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 08:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dgVEl-0006Ia-Pn
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 08:09:52 -0400
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
	<CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
	<20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
	<60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
	<20170812114728.cnikfuyke5dbrake@var.youpi.perso.aquilenet.fr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ec95b76-3904-2781-a5b1-702734dfabfe@redhat.com>
Date: Sat, 12 Aug 2017 07:09:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170812114728.cnikfuyke5dbrake@var.youpi.perso.aquilenet.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WwocKBwLVOLWFs43QOHFg2Uaqd4mgT6lR"
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwocKBwLVOLWFs43QOHFg2Uaqd4mgT6lR
From: Eric Blake <eblake@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2ec95b76-3904-2781-a5b1-702734dfabfe@redhat.com>
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
 <20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
 <CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
 <20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
 <CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
 <20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
 <60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
 <20170812114728.cnikfuyke5dbrake@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170812114728.cnikfuyke5dbrake@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2017 06:47 AM, Samuel Thibault wrote:
> Eric Blake, on sam. 12 ao=C3=BBt 2017 06:41:30 -0500, wrote:
>> Here's an idea:  Instead of using struct ip6 { ... } QEMU_PACKED, use
>>
>> struct ip6 {
>> ...
>> };
>> QEMU_BUG_ON(sizeof(struct ip6) !=3D 32);
>=20
> That's an interesting way indeed.  I however wonder whether there may b=
e
> not-so-uncommon systems where the compiler aligns some fields just for
> performance or such.

If it does, the BUG_ON will flag it, and we'll deal with it as needed
for that platform, perhaps by adding:

=2E..
}
#ifdef WEIRD_PLATFORM
  QEMU_PACKED
#endif
 ;
QEMU_BUG_ON(...);

But as long as the BUG_ON doesn't flag anything, we can use the struct
as-is.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WwocKBwLVOLWFs43QOHFg2Uaqd4mgT6lR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmO8AwACgkQp6FrSiUn
Q2p+zggAoNc36urLylX3qkxwMTAl3ekX9KZeNHTsOkXZlTZH3JX3Wso7mzUEnIoN
2kU0/e5BSP0w7IJn7aqfznBXqUSL5IxwIxXioUi3te4BsxnCVoceVm20bWiGqS8D
xF8h8RxEO1e9QAAhbOsye8gS6/tOCJDIqPEjwkyVVmZMiPCxVWSNmeSIGzKGVT6z
L1Wn3IGztzvUoJZMfckShTe5VTJDRBjAIuHtqUJkGPC15shlAU22+PwhQknIhgyC
9BkD1C84KgbGNVN8p0a9zRgmJ0igT9ensjlyQl3OkHu/qIDAzKkWB5Ke97Us/0dw
biHx5SEeNmfYTEdkGyIlbkHnyC4kGQ==
=28rv
-----END PGP SIGNATURE-----

--WwocKBwLVOLWFs43QOHFg2Uaqd4mgT6lR--
