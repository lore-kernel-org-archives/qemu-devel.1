Received: from eggs.gnu.org ([2001:4830:134:3::10]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUXzM-0006zP-7N
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUXzI-0001vn-AJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUXzI-0001vQ-3e
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:40:28 -0400
Date: Mon, 10 Jul 2017 13:40:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710124025.GE14195@stefanha-x1.localdomain>
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
	<f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
Subject: Re: [Qemu-devel] About the trace framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xie Changlong <xiechanglong.d@gmail.com>
Cc: Wang Dong <dongdwdw@linux.vnet.ibm.com>, qemu-devel@nongnu.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 01:24:23PM +0800, Xie Changlong wrote:
> =E5=9C=A8 7/9/2017 5:57 PM, Wang Dong =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > I am new to QEMU. But I got some problem so that  I want to figure it o=
ut.
> >=20
> > So I try to debug qemu to see what happened.
> >=20
> > And I found trace framework. I think this will help me understand the
> > point.
> >=20
> > So I compiled qemu with option:
> >=20
> > ## *--enable-trace-backends=3Dsimple*
> >=20
> > And did as the docs/tracing.txt tell. But when I execute the example
> > command in it, nothing just happens.
> >=20
> > *./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace file
> > produced by qemu)
> > I am not sure what happened. Just ask this.
> > Any clue will be appreciated. Thanks in advance.
> > *
> >=20
>=20
> Did you set *trace-event*? I've encountered this issue in the past :)
> (qemu) help trace-event
> trace-event name on|off -- changes status of a specific trace event
> (qemu) info trace-events

Yes, you need to enable specific trace events that you are interested
in.  'trace-event' does that from the QEMU monitor at runtime.  If you'd
rather keep a file with a list of events to enable:

  $ echo bdrv_aio_readv   > /tmp/events
  $ echo bdrv_aio_writev >> /tmp/events
  $ qemu -trace events=3D/tmp/events ... # your normal QEMU invocation

It's hard to know what is missing without seeing your QEMU command-line
and monitor commands you used.

Stefan

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY3W4AAoJEJykq7OBq3PICG8H/3SBajfeJAo2gMjPRn7OLRXo
3jaWDsnlPmGRlUBsDtaXSf22YtYYMeIkO6f1/6Pa2r1JIvUWdYFr1JTrrrFIEoJF
yWTOs9kGxVYnl6ajBGp/mcZwgdoECIsCNJsq/ucyN3VPAOSGUikC0wHWRSx0ZsSE
xvEU+4zZp7ZHaDLXBF+YaxPXE/Cl3jV8i0FLyGlvQtwz4ooojcCdMlgpxjHATm94
D56toAk0wzC3x9zTpMY1IVTgfFyfpzWR+4SraefMbEzv1oFx1xGBNWnFsbn3zobG
fwcdfmi5W2rZ5II6YB7lBumQhF6EevdK2gnhnt2KXWv1g4KcTLautdxIY3RG8iQ=
=0VrU
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
