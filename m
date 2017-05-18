Received: from eggs.gnu.org ([2001:4830:134:3::10]:34311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBHwz-0004g4-AC
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBHwv-0004mF-9g
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dBHwv-0004lh-3O
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:42:25 -0400
Date: Thu, 18 May 2017 10:42:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170518094222.GA15681@stefanha-x1.localdomain>
References: <20170517145259.28979-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20170517145259.28979-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] gdb updates and cputlb traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, cota@braap.org, qemu-devel@nongnu.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 03:52:53PM +0100, Alex Benn=E9e wrote:
> Hi,
>=20
> Here is an update to the cputlb tracing and also a number of gdbstub
> updates. The main changes to the cputlb tracing are making each flush
> an explicit event instead of just dumping counts. This means you can
> so analysis on the delay from queuing work to scheduling at the cost
> of losing the raw count in the MMI interface.
>=20
> Alex Benn=E9e (6):
>   scripts/replay-dump.py: replay log dumper
>   scripts/qemu-gdb/timers.py: new helper to dump timer state
>   scripts/qemu-gdb/tcg: new helper to dump tcg state
>   cputlb: remove tlb_flush_count
>   cputlb: add trace events
>   new script/analyse-tlb-flushes-simpletrace.py
>=20
>  cputlb.c                                   |  38 +++-
>  include/exec/cputlb.h                      |   1 -
>  scripts/analyse-tlb-flushes-simpletrace.py | 144 +++++++++++++++
>  scripts/qemu-gdb.py                        |   4 +-
>  scripts/qemugdb/tcg.py                     |  46 +++++
>  scripts/qemugdb/timers.py                  |  54 ++++++
>  scripts/replay-dump.py                     | 272 +++++++++++++++++++++++=
++++++
>  trace-events                               |   7 +
>  translate-all.c                            |   1 -
>  9 files changed, 559 insertions(+), 8 deletions(-)
>  create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py
>  create mode 100644 scripts/qemugdb/tcg.py
>  create mode 100644 scripts/qemugdb/timers.py
>  create mode 100755 scripts/replay-dump.py
>=20
> --=20
> 2.11.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWx9AAoJEJykq7OBq3PIyxcH/jIIYtZbDeh2A5o+tuAyH/cT
7shb2w+qaPXPgSeVECMTh8AfAK453ilC3RGsgHarmHEborptaz04IeKrNgh8Xs8q
Amk+9cQwDiq5tK0nVCk0vzCMmsFmuu0gQtSCLeNMyCIj5Zx3Cz4KhztPR4NDOyDn
3ZaVll5HEtIPfWgbDnH8FDtratNaXOubUwO5cOArsxcOS18ZIvNlYV6fW0Ry6n4x
q4sRFalcg99X7gaWvTzuesZ8DMY0Qc2E3NNwQ5AFtElP5gdHFnW/V8LOHUYA8OCH
9qVVTVUPCFdS7iLyy+aupuxQQ+aLsgAU+oSB5AJ6KeF2MrJVoraeYJ0tmuFm4zU=
=wM9d
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
