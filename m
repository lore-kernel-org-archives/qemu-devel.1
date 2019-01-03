Received: from eggs.gnu.org ([208.118.235.92]:60003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf9Fw-0002RI-Vp
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf9Fs-0001gS-Tw
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:06:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gf9Fs-0001bI-LT
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:06:12 -0500
References: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02d090d3-a486-7945-cc7d-43e24b281356@redhat.com>
Date: Thu, 3 Jan 2019 14:06:08 -0600
MIME-Version: 1.0
In-Reply-To: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MuccpPUBQDox5sm8syh92gUMBPUlck8kn"
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: Reorganize MIPS TCG directories
 and files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: noring@nocrew.org, smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, alex.bennee@linaro.org, aurelien@aurel32.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MuccpPUBQDox5sm8syh92gUMBPUlck8kn
From: Eric Blake <eblake@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: noring@nocrew.org, smarkovic@wavecomp.com, arikalo@wavecomp.com,
 amarkovic@wavecomp.com, alex.bennee@linaro.org, aurelien@aurel32.net
Message-ID: <02d090d3-a486-7945-cc7d-43e24b281356@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: Reorganize MIPS TCG directories
 and files
References: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/27/18 7:12 AM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Reorganize MIPS TCG directories and files. The file movement is done
> using "git mv" command, so "git blame" will still display the original
> information, regardles of the new names and locations of involved
> files.
>=20
> Aleksandar Markovic (2):
>   tests: tcg: mips: Move source files to new location
>   tests: tcg: mips: Remove old directories after reorganization
>=20
>  tests/tcg/mips/mips32-dsp/Makefile                 | 136 ---------

>  tests/tcg/mips/mipsr5900/multu.c                   |  68 -----
>  .../mips/system/ase/dsp/test_64_dsp_r1_absq_s_ob.c |  63 +++++

>  tests/tcg/mips/user/isa/r5900/test_r5900_multu.c   |  68 +++++
>  976 files changed, 19288 insertions(+), 20087 deletions(-)

You also need to turn on git rename detection before sending your v2, so
that your mail will be MUCH smaller (showing only lines that changed
between file renames, rather than a much larger patch of deleting the
old file and creating a new file).  More patch submission hints,
including the git config setup for rename detection, can be found at
https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MuccpPUBQDox5sm8syh92gUMBPUlck8kn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwuazAACgkQ3g5py3or
ov1gAQf/ZhgEJRt0SzVaiFuZjurny59mw4DB7iDQNlhE+R3MFZv5tYedy/yw3yh0
ulI7QNn/PUKCY6Zvzk5DypyPtWyIsDlSS6nT/ESSHvTTStZSld+NbF2gADPCw68+
N5XrHW9nZC4hQ9nV2JnqjCm1qhGbopwIs/9gjSDV/2SRHOWh7PG80HdvyfjGbvCM
5sLFxYQQ4YqYYevk2uiUDBFJy2uX6D98xIr3yhA7M+rXVP+E2AeVv5Lqu9izSts7
DMrN4gLyZr06G7s30cDWZj2F4juszKBEVvW99rGlgrYG1l2YPdz6EvhLzMJ9prlC
Q/knKBDEqJzn8Rs8l9vP7wfvYZtGVg==
=yia9
-----END PGP SIGNATURE-----

--MuccpPUBQDox5sm8syh92gUMBPUlck8kn--
