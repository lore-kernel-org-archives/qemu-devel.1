Received: from eggs.gnu.org ([2001:4830:134:3::10]:46720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cba26-0005XC-MK
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cba22-0002kI-29
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:44:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cba21-0002kB-Rs
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:44:05 -0500
References: <1486571506-16242-1-git-send-email-yongbok.kim@imgtec.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8eca7e34-da8c-f44a-1d97-b2b7299a8a92@redhat.com>
Date: Wed, 8 Feb 2017 15:44:03 -0600
MIME-Version: 1.0
In-Reply-To: <1486571506-16242-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xuLdJwMPWxe3TXX3sfXvn5THQQKhftIVe"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] hw/mips_cmgcr: allow GCR base to be
 moved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, paul.burton@imgtec.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xuLdJwMPWxe3TXX3sfXvn5THQQKhftIVe
From: Eric Blake <eblake@redhat.com>
To: Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, paul.burton@imgtec.com
Message-ID: <8eca7e34-da8c-f44a-1d97-b2b7299a8a92@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] hw/mips_cmgcr: allow GCR base to be
 moved
References: <1486571506-16242-1-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1486571506-16242-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2017 10:31 AM, Yongbok Kim wrote:
> From: Paul Burton <paul.burton@imgtec.com>

The 0/8 cover letter was sent with this header:
Message-ID: <1486571463-16183-1-git-send-email-yongbok.kim@imgtec.com>

but your individual patches were sent with no In-Reply-To: or
References: headers; therefore, each message appears as its own
top-level thread. When reposting, please make sure your series is
properly threaded.

>=20
> Support moving the GCR base address & updating the CPU's CP0 CMGCRBase
> register appropriately. This is required if a platform needs to move it=
s
> GCRs away from other memory, as the MIPS Boston development board does
> to avoid its flash memory.
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xuLdJwMPWxe3TXX3sfXvn5THQQKhftIVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm5EjAAoJEKeha0olJ0NqkVwH/iATSvpiYqXXwafAady9wSe0
Ii0gkK5ILTLMSZIeU67yebe9J53VOFoiG7I+ptVCNem6ZGODLIxwn+8d+2BRkRsC
UwwnGWjibE4wtXHQ/SHWg5JuNDCDKtUNR2HDtRPWoXXnMiQkeDXao3r0BucT8YWE
rJ9GvI9g82KIn5j4yh1SL74Dt6zuI6+x5YwlmfoB0clDvqPFrfJvoDtP3mdEkSzs
vH2Idh/RQ0x8gY0F+gWP2SevNZiJsk+TOgzsBx/uZc6F9QURpZ2CEdVQTSQlrYZb
fVJGcmXh//IOuZyNyu1t28ZmCW2bu7ukvSRGLZIeUONeA4VF2y+GnvHuXPByuQ8=
=SSnc
-----END PGP SIGNATURE-----

--xuLdJwMPWxe3TXX3sfXvn5THQQKhftIVe--
