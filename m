Received: from eggsout.gnu.org ([209.51.188.92]:33862 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfog8-0004gV-DY
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 11:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfog4-0007Ip-2Y
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 11:20:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfog3-0007HI-PR
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 11:19:59 -0500
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a786cc53-c01a-3fa0-7d7d-f0bef8944b38@redhat.com>
Date: Sat, 5 Jan 2019 10:19:57 -0600
MIME-Version: 1.0
In-Reply-To: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YjuIf8yBGF2XCMi10MiSMslyuRaKrH0ZE"
Subject: Re: [Qemu-devel] [Bug 1810603] [NEW] QEMU QCow Images crow
 dramatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1810603 <1810603@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YjuIf8yBGF2XCMi10MiSMslyuRaKrH0ZE
From: Eric Blake <eblake@redhat.com>
To: Bug 1810603 <1810603@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <a786cc53-c01a-3fa0-7d7d-f0bef8944b38@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1810603] [NEW] QEMU QCow Images crow
 dramatically
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
In-Reply-To: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/5/19 9:32 AM, Lenny Helpline wrote:

>=20
> You can reproduce this bug as follow:
> 1) create an initial disk image
> 2) create a linked clone
> 3) create a snapshot of the linked clone
> 4) revert the snapshot every X minutes / hours

Needs more details to reproduce.  What is the exact command you used for
each of these steps?  For example, without that command, I can't tell if
you are creating internal or external snapshots, and that drastically
changes the approach for how to deal with reverting snapshots.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YjuIf8yBGF2XCMi10MiSMslyuRaKrH0ZE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlww2S0ACgkQ3g5py3or
ov1HAgf+IK0rW/HIcZkU1YvEMrujRDNDr6Xqe4I1oLEb++8CtxwjbRgqv7yJo2Ig
0ePept+6Nyr7F2bs6XLz1N/GBa3wySJX7Bm3Su4Lbt1t1b7SkHJism7nK64ZBAAD
W4DDp/cC/z8hYnEd/MrCBaQpcp2X0lDLwMPvtagxmi3SmQRo+9kdRNZzXfzqQK1U
R0qUM65nWSMZYwAt4W1rYfXyjpg7d+gTx4XNTQidUxniY1aJ8jsSkF6ztg/p40Bq
ID4jKpqgVvMMclS4SRTMM4F1S9W/0vwT2U1wJy//AcMq5pjwf7bUfowUujW47h8z
3syFFCZAKRO6E5tcDnRsapNpbNGYTA==
=jUOW
-----END PGP SIGNATURE-----

--YjuIf8yBGF2XCMi10MiSMslyuRaKrH0ZE--
