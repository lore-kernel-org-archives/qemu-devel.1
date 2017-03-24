Received: from eggs.gnu.org ([2001:4830:134:3::10]:56490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crSkm-0003pA-FT
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crSkh-0007FE-HF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:11:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crSkh-0007Et-8o
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:11:51 -0400
References: <20170324152607.6604-1-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa4d3712-859a-ced3-3883-8951ee9b6aa7@redhat.com>
Date: Fri, 24 Mar 2017 12:11:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170324152607.6604-1-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="krKQjmQErfAPEg2MEd3PDiCStELqwXFu6"
Subject: Re: [Qemu-devel] [PATCH-for-2.9] replay/replay.c: bump
 REPLAY_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pavel.dovgaluk@ispras.ru
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--krKQjmQErfAPEg2MEd3PDiCStELqwXFu6
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pavel.dovgaluk@ispras.ru
Cc: qemu-devel@nongnu.org
Message-ID: <fa4d3712-859a-ced3-3883-8951ee9b6aa7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH-for-2.9] replay/replay.c: bump REPLAY_VERSION
References: <20170324152607.6604-1-alex.bennee@linaro.org>
In-Reply-To: <20170324152607.6604-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 10:26 AM, Alex Benn=C3=A9e wrote:
> A previous commit (3d4d16f4) added support for audio record/playback.
> However this breaks the logfile ABI due to the re-ordering of the
> ReplayEvents enum. The REPLAY_VERSION check is meant to prevent you
> from using old log files in newer QEMUs but this is currently broken.

As we don't have a formal release with the reordered enum yet, would an
alternative approach be partially reverting 3d4d16f4 to instead stick
the new enum values at the end, so that all existing enums are in the
same order?  Or do you still need the version bump even then, because
you don't want a new stream (with the new enums) being played to an
older system that isn't expecting them?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--krKQjmQErfAPEg2MEd3PDiCStELqwXFu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1VNUAAoJEKeha0olJ0NqHQcH/AvuQ7OtZPEKM6lJhVv0HVzb
ortxU+OY3O4HQcWxqQi45wKaqDtnqVfvKo1uNnmXPHWheJn3vK5coeAx251HiTcq
hepD3+RjHpAhvPph0jt7HWoLT+dvHon5ntQkOTbijPrU/fFYNVOERFrQF5JFsWgu
jImI9HqgIEv9/HqcFSQ1Jc/2SXHWTVs2WUWhj6DExsYmWywvPA4o5tYMfUHw1SdY
kWpOmnAD6kZz3fLgEk4CBEvBC+T7P/mkPb+0tAJF2p5pPBPaXvNMPzkgMpxPId+B
9Pfrkz+SPu1Re2j6n1kvE9yeuyTXV1/EZO4awPxGVJxEcpHrvVpIsN67O7t/DAA=
=mpbL
-----END PGP SIGNATURE-----

--krKQjmQErfAPEg2MEd3PDiCStELqwXFu6--
