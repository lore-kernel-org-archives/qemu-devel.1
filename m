Received: from eggs.gnu.org ([2001:4830:134:3::10]:33186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehF0g-0001e0-1A
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehF0f-00043d-0L
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ehF0e-00043T-Ps
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:36 -0500
Date: Thu, 1 Feb 2018 13:34:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201133434.GE5783@stefanha-x1.localdomain>
References: <20180129041648.30884-1-jonemilj@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <20180129041648.30884-1-jonemilj@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] tracetool: Fix ust tracepoint issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jon Emil Jahren <jonemilj@gmail.com>
Cc: qemu-devel@nongnu.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 05:16:46AM +0100, Jon Emil Jahren wrote:
> There are some issues with the argument parsing for ust.
> The first issue is that the regex pattern matching arguments with PRI
> types matched too much. This was fixed by using a non-greedy star,
> instead of a greedy.
> The second issue is that bool type is not recognized. This was fixed by
> adding the bool type to be traced as an integer.
> Both issues causes missing information in the trace.
>=20
> The following patches fix the issues mentioned.
>=20
> Jon Emil Jahren (2):
>   tracetool: Update argument format regex to non-greedy star
>   tracetool: For ust trace bool type as ctf_integer
>=20
>  scripts/tracetool/__init__.py            | 5 +++--
>  scripts/tracetool/format/ust_events_h.py | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Excellent work, thanks for the patches!

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacxdqAAoJEJykq7OBq3PIBMwIAMMgkjOtPqfJkR8qm87D06eo
/KHmocaf4iodYVuMMqXY5AKgsNf9Sd8ANcjv00qlq/YX39gZuMWxdkYk5UaVDtPe
0yutaRi+mCXt5VG8CIlLMOUxirzS0EuP/218qdGf/0IWdBVfJxndToThl4EJb4fg
0PBsVDDpcAy3tUOIPj87gHNKT6hIXnXYR9XmK8UsG/pmzXpbyM3mgeewmGVZc2q2
f++ejqacJ+W/hGYgR2bf4/4QI0IsXtdIGdMxu4h8dKVkB174LM86sulDTH1M2HhU
GL2eKyBl3uVHkL7pJVsxPsfhxpEpG5klZUA3MIK3po9PciZslfEoyzTCmYa5v3I=
=XBat
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
