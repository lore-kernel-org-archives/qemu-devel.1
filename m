Received: from eggs.gnu.org ([2001:4830:134:3::10]:38960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPiJ-0008LK-HD
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPiG-0007iP-Ji
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:49:03 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKPiG-0007hH-Dc
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:49:00 -0400
Received: by mail-wr0-x241.google.com with SMTP id v104so22101625wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 06:49:00 -0700 (PDT)
Date: Mon, 12 Jun 2017 14:48:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612134849.GB17075@stefanha-x1.localdomain>
References: <20170605104216.22429-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20170605104216.22429-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] monitor: add trace events for HMP and
 QMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 11:42:14AM +0100, Stefan Hajnoczi wrote:
> It's nice to have HMP and QMP commands as part of a trace log.  This make=
s it
> possible to correlate QEMU-internal events with the monitor commands that
> caused them.
>=20
> Stefan Hajnoczi (2):
>   monitor: add handle_hmp_command trace event
>   monitor: resurrect handle_qmp_command trace event
>=20
>  monitor.c    | 7 +++++++
>  trace-events | 2 ++
>  2 files changed, 9 insertions(+)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPpvBAAoJEJykq7OBq3PIoRwH/i1JO0wOt2hqN1nFFrExsNEZ
yNRdPjQQtJ9V35vDpDu+W0INfXnz8udR7RVJGd5KHpqd0KBRoeAUpLbmyNF5lO90
AALDScKLDjVIuaVoofaDqimhpHIZZfmFIRgX4qRlyRfknS/Y6NZ+9gBFSLdmAbbh
NByvemmINYEj67nN2FTdLn4s1vP0R+NBaoED1EiTUIV3cWhEW/RvhP7lvDR5qaIB
x3lFpLNvc4J9hzrZuJ6Ln1ZbdewF0xACKriz11couXfhQdGYUA4PqW4uTE67YFWg
YuRnSNQLORF7SV0iSBg09RqvZEBP7o8esZfh4CXYGKdDE7zpkEk/l+d9uw50QmA=
=NPPT
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
