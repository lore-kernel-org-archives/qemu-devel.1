Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdjV-0003W0-Rz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdjR-0003GR-CC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:46:33 -0400
Date: Tue, 30 May 2017 10:46:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530094626.GO11362@stefanha-x1.localdomain>
References: <1496075404-8845-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8N0TQpGUCeEQshoq"
Content-Disposition: inline
In-Reply-To: <1496075404-8845-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] simpletrace: Improve the error message if
 event is not declared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--8N0TQpGUCeEQshoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 01:30:04PM -0300, Jose Ricardo Ziviani wrote:
> Today, if we use a trace-event file which does not declare an event
> existing in the log file we'll get the following error:
>=20
> $ scripts/simpletrace.py trace-events trace-68508
> Traceback (most recent call last):
>   File "scripts/simpletrace.py", line 242, in <module>
>     run(Formatter())
>   File "scripts/simpletrace.py", line 217, in run
>     process(events, sys.argv[2], analyzer, read_header=3Dread_header)
>   File "scripts/simpletrace.py", line 192, in process
>     for rec in read_trace_records(edict, log):
>   File "scripts/simpletrace.py", line 107, in read_trace_records
>     rec =3D read_record(edict, idtoname, fobj)
>   File "scripts/simpletrace.py", line 71, in read_record
>     return get_record(edict, idtoname, rechdr, fobj)
>   File "scripts/simpletrace.py", line 45, in get_record
>     event =3D edict[name]
> KeyError: 'qemu_mutex_locked'
>=20
> This patch improves this error by adding a hint instead of just that
> KeyError log:
>=20
> $ scripts/simpletrace.py trace-events trace-68508
> 'qemu_mutex_locked' event is logged but is not declared in the trace
> events file, try using trace-events-all instead.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  scripts/simpletrace.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--8N0TQpGUCeEQshoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLT9yAAoJEJykq7OBq3PIgjkIAMjM0vtxyMQDhhIJXFiN7C16
zBssTs4vvWqXPOSqmedlc53sR9xycUDXA2s2pohjaGDLfWWPDRJ4Atf/qacg0xqq
nRHxDxQ5Vtlpf6ypmUEXaD/LmUa7AqMY4OwhMCF0e9QEEMCITNu7yqZPvejkZSXs
VXTgMsWMA5JzDBKY+d/vB21YTobR7r0vVZRpnLjvUwNegiwvPq5ij41jMCvVxJXP
pHCE2Gm84eCqanGh35h6jOikHar85y0OaPaeRPR24dndOatcn2snG0AaN0RdlNhl
ZpO6Ke3DGz6Qvqn8is1L2fzZ/+Yj4AxD3E40AW1dci8w2OeJK5ZXqKgJ1RhuOJk=
=r1bS
-----END PGP SIGNATURE-----

--8N0TQpGUCeEQshoq--
