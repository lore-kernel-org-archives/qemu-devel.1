Received: from eggs.gnu.org ([2001:4830:134:3::10]:37764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dswe1-0002Jl-ON
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dswdy-0005qs-Jg
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dswdy-0005qc-A9
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:51:18 -0400
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<20170915193313.86362-1-jrtc27@jrtc27.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a15b52d0-7ef4-b870-37b1-a2873d783d3b@redhat.com>
Date: Fri, 15 Sep 2017 14:51:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170915193313.86362-1-jrtc27@jrtc27.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NO46QQ3K4RfVLJQd2HpDdtlb5UOmLmnP8"
Subject: Re: [Qemu-devel] [PATCH v3] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NO46QQ3K4RfVLJQd2HpDdtlb5UOmLmnP8
From: Eric Blake <eblake@redhat.com>
To: James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <a15b52d0-7ef4-b870-37b1-a2873d783d3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
 <20170915193313.86362-1-jrtc27@jrtc27.com>
In-Reply-To: <20170915193313.86362-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 02:33 PM, James Clarke wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
>=20
> Changes since v2:
>  * Fixed opening curly brace formatting, both for my new SH4-specific
>    regpairs_aligned function, as well as the Arm one I touched, to appe=
ase
>    checkpatch.pl

It's better to post your v3 as a top-level post rather than in-reply-to
v1 and v2; our automated tooling doesn't always find buried patches as
easily as new threads.  No need to resend for now, but food for thought
if you have to do a v4.

Other patch submission hints at http://wiki.qemu.org/Contribute/SubmitAPa=
tch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NO46QQ3K4RfVLJQd2HpDdtlb5UOmLmnP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8LzEACgkQp6FrSiUn
Q2pDGggAlFA/x6TDW9nbgrIgL+wfbRUmZ8+IsCyqZ/OozuXOpnTJU0YmtfgaylrQ
Io8tttaJHyVZuT1x84KsIfKj22gyMD5tz/WW2xo5uHdEMZPXqywoLfakAFwjO3Qy
Rq0Zopyj/oNZB7hht0bg6su6uR1ugKoWxoIJxirzXAWYVwoGoPrZ7Rz3jglNEx/7
+OiguInPQA9ATYTCbIBckusLliMvsQLDzTlg3C5UfSf/Ynz9fc+B907AvsZFkCw4
21MADz901FimtGdhyOAmfBFEYbtzlGPPOy7bsWHZkwEMB0Gt7c23QgxwMVPRJ4lO
OIVgVH3Fhsnu4f15WZDU4Am6D0CI1w==
=DK8e
-----END PGP SIGNATURE-----

--NO46QQ3K4RfVLJQd2HpDdtlb5UOmLmnP8--
