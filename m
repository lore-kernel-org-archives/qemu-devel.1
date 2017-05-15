Received: from eggs.gnu.org ([2001:4830:134:3::10]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGV2-0000X1-0L
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGUx-0000QG-Hj
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAGUx-0000Pu-Aa
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:57:19 -0400
References: <20170513015449.24061-1-n54@gmx.com>
	<91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4245846f-2977-6f1b-a5a0-80d92bfe42d4@redhat.com>
Date: Mon, 15 May 2017 08:57:16 -0500
MIME-Version: 1.0
In-Reply-To: <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s4w0ceNMVdappJJCuuGALqwlr0TBWqBcr"
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s4w0ceNMVdappJJCuuGALqwlr0TBWqBcr
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com
Message-ID: <4245846f-2977-6f1b-a5a0-80d92bfe42d4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
References: <20170513015449.24061-1-n54@gmx.com>
 <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
In-Reply-To: <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/13/2017 05:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Kamil,
>=20
> I think it is safer to add it in disas/libvixl/Makefile.objs where
> QEMU_CFLAGS are tuned for libvixl.
> This way you don't need to modify upstream libvixl.
>=20

Ah, right. disas/libvixl is one of the directories exempt from our
normal rules of including osdep.h first (otherwise I would have said
that including stdint.h first should be the job of osdep.h).

But indeed, that's because we are trying to leave libvixl as untouched
as possible, so if there IS a solution that can be done through
makefiles rather than direct file editing, it is worth considering.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s4w0ceNMVdappJJCuuGALqwlr0TBWqBcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGbO8AAoJEKeha0olJ0Nq8k4H/i72EKzS4SDak0U8OSN72r0o
riP03l02tTbXg54k7sIHo62EF2Yhnl28+57k/KJptO8afnhK/h3R9ve+lGT3/rtu
F5+fOSEfRcq185Rp1Wq/8JwcU0jWlHK/Aq9PgvfgQrfd0TD3RQo/MIupMcEuSnUn
Yl22D5lbogCErpNKKCwp8QPneCQH9giW9ESgmzaNwjx33neQ0Akvh39GU/qcVqKW
Gcro8oMUipjEp30ZRNWyUXHAq4zzZCKepJzeLw9nDIGDiSKNO7LENFtHQSZIPlp5
mr0wckUG5FnJAgQetbXyQx3AWf3A/mGMKuOZePsANZi3KPq7Ww3j/wNEFf6kBpc=
=tlru
-----END PGP SIGNATURE-----

--s4w0ceNMVdappJJCuuGALqwlr0TBWqBcr--
