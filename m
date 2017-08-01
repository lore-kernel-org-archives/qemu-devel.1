Received: from eggs.gnu.org ([2001:4830:134:3::10]:39806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcTdo-0002YL-RQ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcTdl-0006lm-HG
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:39:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcTdl-0006kB-Ah
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:39:01 -0400
Received: by mail-wm0-x244.google.com with SMTP id t138so2145151wmt.4
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 02:39:01 -0700 (PDT)
Date: Tue, 1 Aug 2017 10:38:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801093857.GC13521@stefanha-x1.localdomain>
References: <20170731140718.22010-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <20170731140718.22010-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] trace: fix trace_event_get_state()
 for SystemTap and LTTng UST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 03:07:16PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Don't special-case QEMU dstate [Daniel Berrange]
>  * Use _backends() postfix to clarify function purpose [Llu=EDs]
>=20
> Trace events that compute their arguments can affect performance.  The
> following idom can be used to avoid computing arguments when the trace ev=
ent is
> disabled:
>=20
>   if (trace_event_get_state(TRACE_MY_EVENT)) {
>       char *str =3D g_strdup_printf("Expensive string ...", ...);
>       trace_my_event(str);
>       g_free(str);
>   }
>=20
> Unfortunately this breaks the trace event for SystemTap and LTTng UST sin=
ce
> those tracers manage their own enabled/disabled state.
>=20
> These patches add per-backend dstate to trace_event_get_state() so that t=
he
> trace event fires as expected when enabled via SystemTap or LTTng UST.
>=20
> Stefan Hajnoczi (2):
>   trace: add TRACE_<event>_BACKEND_DSTATE()
>   trace: add trace_event_get_state_backends()
>=20
>  docs/devel/tracing.txt                |  2 +-
>  trace/control.h                       | 18 +++++++++++++++++-
>  hw/usb/hcd-ohci.c                     | 13 +++++--------
>  net/colo-compare.c                    | 11 ++++++-----
>  net/filter-rewriter.c                 |  4 ++--
>  scripts/tracetool/__init__.py         |  1 +
>  scripts/tracetool/backend/__init__.py |  3 +++
>  scripts/tracetool/backend/dtrace.py   | 12 ++++++++++++
>  scripts/tracetool/backend/ftrace.py   |  5 +++++
>  scripts/tracetool/backend/log.py      |  5 +++++
>  scripts/tracetool/backend/simple.py   |  5 +++++
>  scripts/tracetool/backend/syslog.py   |  5 +++++
>  scripts/tracetool/backend/ust.py      |  5 +++++
>  scripts/tracetool/format/h.py         | 10 ++++++++++
>  14 files changed, 82 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.13.3
>=20
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgEwxAAoJEJykq7OBq3PITDsH/3jrw5phUwcq3jgLsJYY7n2Y
erOrntick08wt0Y0gMt1oa7yytB9YUm09oOgYMd7V3Rgfoi5ns7VsAxJme0EJSWW
OqALzXP1+tYorj5L9KBpN+jbR6zv+t+zkL9X+BQ8nui9MpsxLbH/Kg8IOmimbO6c
6Y5BsRHUqmg5cBxa8MVB2yHaC/PSt7q6HUakNwMtd+cUK2IbGDPaA9dyN089aijA
3/ZGOtvykhdWEPPVmZqYGOsbSnA2yrjesu8lJtEyTwlaXZ1KYUl39duHpCbXOecj
wGT6VjeBU+cSA4NEzQcEa4M6EkPEk4ZLE8qdFLOaD4LusM6qOJNi1+SV9zY+ztY=
=B5yC
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
