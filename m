Received: from eggs.gnu.org ([2001:4830:134:3::10]:50719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN3z0-0003Ie-4s
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN3yx-0005G9-1b
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:45:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eN3yw-0005Ek-Mr
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:45:26 -0500
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4beb4062-64fa-9105-1b84-4b5f69554e94@redhat.com>
Date: Thu, 7 Dec 2017 15:45:24 -0600
MIME-Version: 1.0
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KJwPsFFCorlVCPWlqPwlSAAflVnImfekI"
Subject: Re: [Qemu-devel] [PATCH 0/7] Add PCI IPMI interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KJwPsFFCorlVCPWlqPwlSAAflVnImfekI
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, qemu-devel@nongnu.org
Message-ID: <4beb4062-64fa-9105-1b84-4b5f69554e94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] Add PCI IPMI interfaces
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 03:34 PM, minyard@acm.org wrote:
> I had to do some testing, so I went ahead and did this.  Most of the
> changes are re-arranging and splitting up code to separate out the
> KCS/BT code from the ISA-specific code.
>=20
> There are also some migration fixes here.
>=20
> This series requires the previous series: Small IPMI (and other)
> fixes

Let patchew know about the dependency:

Based-on: <1512682213-4354-1-git-send-email-minyard@acm.org>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KJwPsFFCorlVCPWlqPwlSAAflVnImfekI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloptnQACgkQp6FrSiUn
Q2rBVwf9FInP+XtYNV74Q7OfB7FaSV30MCLJw1ha34HQ39MxRtceujhUfdRDClO8
mTjn23QZwWMePCeX4e2IhET2hrY3WD/LyUPK7NXTEwvQC7CUEK1qfuvLrvGsiM2c
ndyu/mqoiliWMeBf7G+1QY/IPqrYT6uzBvAvsiwjZlmiQkmo5rgdG2oOaeWCOcke
c887EreXf8wKIbcliT+sTEbIJEjSolrDoLHoS0WKCKyWdduy3Nt+bCB60lpvhDOU
FqcTpa63pEQJuIn2kLdtQl2CafANEXEV01ZfI5+7kBpl4ojlKRZ/YmcURB8HisFO
wmltrw48CYQ02VUkwMeEXTiG17054A==
=Ahc8
-----END PGP SIGNATURE-----

--KJwPsFFCorlVCPWlqPwlSAAflVnImfekI--
