Received: from eggs.gnu.org ([2001:4830:134:3::10]:39648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1z7F-000149-Jp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1z7B-0003By-DP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1z7B-0003Be-4E
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:18:49 -0400
References: <20171010174403.24660-1-martin@schrodt.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
Date: Tue, 10 Oct 2017 13:18:46 -0500
MIME-Version: 1.0
In-Reply-To: <20171010174403.24660-1-martin@schrodt.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H5O3B9n0DngjKfUxa118kbCOIaakK9fal"
Subject: Re: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H5O3B9n0DngjKfUxa118kbCOIaakK9fal
From: Eric Blake <eblake@redhat.com>
To: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org
Message-ID: <d4647fac-4dbe-7f31-d03c-d8c4e8fcfbad@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
References: <20171010174403.24660-1-martin@schrodt.org>
In-Reply-To: <20171010174403.24660-1-martin@schrodt.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 12:44 PM, Martin Schrodt wrote:
> Please see
>=20
> https://www.reddit.com/r/VFIO/comments/74vokw/improved_pulse_audio_driv=
er_for_qemu/
>=20
> for motivation, and more coverage.
>=20
> Changes:
>=20
> - Remove PA reader/writer threads from paaudio.c, and do IO from the au=
dio timer directly.
> - Add 1 millisecond timers which interface with the HDA device, pulling=
 and pushing data
>   to and from it, to enable the guest driver to measure DMA timing by j=
ust looking the
>   LPIB registers.
> - Expose new configurable settings, such as TLENGTH and FRAGSIZE, plus =
settings to
>   enable PA_STREAM_ADJUST_LATENCY for input and output device separatel=
y.
> - Fix the input delay when first using the input device.

That's a lot of changes to be slamming in one patch.  Any chance you can
split it into a series of smaller patches that are easier to review
individually?  Perhaps one patch per item in your bulleted list is a
good start for subdividing this into something that is not so massive.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--H5O3B9n0DngjKfUxa118kbCOIaakK9fal
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndDwYACgkQp6FrSiUn
Q2o4Xgf/WYJdERAs/Olr1f2wTT/JI0+H9WUnPoHeMIuBYfOTMXG05tAug17ivGMy
oT2zeVytjr8kQzjjUiiQ7tBsNnKSK0LhbzwcLrXYsqV9R4o8VsrdDiQ7svkeSKNX
5Mm+4x50gvtU1u4mXmbHc1eVXrXFVQnWY/APSRymPnckGFSLC3chbdsRhLnwMBBE
FTYRjFLYDxk9wTYBGzE8yAK5f0c8ljKVmisIsFYSIjhHK70I7ZOrT65ZUlwARZBV
EsLPQOvFhPAX1F5w1eCrbu1k1gXlRAMK4YDEPfayjDLTdATOt9aVFhc5cT7tR6uN
c+gOAkNMJHnSalonJR7Cd4IlADjryg==
=8M1A
-----END PGP SIGNATURE-----

--H5O3B9n0DngjKfUxa118kbCOIaakK9fal--
