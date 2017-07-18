Received: from eggs.gnu.org ([2001:4830:134:3::10]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXU5k-00055Y-Ku
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXU5j-00080l-Gy
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXU5j-00080A-7y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:07:15 -0400
References: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
	<1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <edae6aa7-34ef-a3a8-94e0-175f05728345@redhat.com>
Date: Tue, 18 Jul 2017 10:07:05 -0500
MIME-Version: 1.0
In-Reply-To: <1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="43HqkCJOpWFkDbTb4IGkp3LdUjd3oHb1l"
Subject: Re: [Qemu-devel] Disable image locking for snapshot drive?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--43HqkCJOpWFkDbTb4IGkp3LdUjd3oHb1l
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>
Message-ID: <edae6aa7-34ef-a3a8-94e0-175f05728345@redhat.com>
Subject: Re: [Qemu-devel] Disable image locking for snapshot drive?
References: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
 <1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
In-Reply-To: <1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 07:33 PM, John Snow wrote:
>=20
>=20
> On 07/17/2017 07:30 PM, Andrew Baumann via Qemu-devel wrote:
>> Hi all,
>>
>> I'm running a recent Linux build of qemu on Windows Subsystem for Linu=
x (WSL) which doesn't appear to implement file locking:
>>
>> $ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0 -=
device virtio-blk-pci,drive=3Dhd0
>> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Faile=
d to unlock byte 100

Does WSL implement fcntl(F_SETLK) but not fcntl(F_OFD_SETLK)?  We
already have code in place for compiling when F_OFD_SETLK is not
supported (which makes lock=3Dauto do nothing, and issues a warning that
F_SETLK locks may be ineffective when locks are explicitly requested),
do we need to just expand that code into a runtime test of whether
F_OFD_SETLK appears to be unsupported?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--43HqkCJOpWFkDbTb4IGkp3LdUjd3oHb1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluJBkACgkQp6FrSiUn
Q2oRCwf/SaGYF1Xg+HWmhEUcSeSrzT5B31IYPc3SZEPAHbIRh5YyKdqqQJ8JbZQE
mSGR7+oB1aamaFin7qr/qeDtim7zWTPs0qEIv85O/bUuoVWhtnNdpL/xGXJfQNZb
HgiPl0q3ff+SgqZKOYDrGk9+dYC/sV6JE2GR4t9ho1u5TkkJ/DTBQFoTYYFx2+gI
A0NTdoZMK9ftfelqB9e6gEoyOZWEKu91cgwgFedyryuTPuOFV8RjdOcRNFnOO3YM
e9rKGe51qjCDsQ6f0YFe+UFyx87k7KRcy3V+aZiL5ezxcQVjce+D/eCnjdWmLl76
QQxYMv9pZYQ6ul/wYJ+SexY3bKbmbg==
=SKxR
-----END PGP SIGNATURE-----

--43HqkCJOpWFkDbTb4IGkp3LdUjd3oHb1l--
