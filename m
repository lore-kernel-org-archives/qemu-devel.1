Received: from eggs.gnu.org ([2001:4830:134:3::10]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0lf0-0001vJ-1I
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0lez-0007kL-5Y
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:12:26 -0400
Date: Wed, 19 Apr 2017 10:12:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170419091216.GB3343@stefanha-x1.localdomain>
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-3-eblake@redhat.com>
	<50d265a3-dec8-59f9-6840-c5720e406fa6@redhat.com>
	<1412228f-01c5-da47-31db-4ed34c7dc055@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <1412228f-01c5-da47-31db-4ed34c7dc055@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/17] trace: Show blockjob
 actions via bytes, not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 02:55:53PM -0500, Eric Blake wrote:
> On 04/17/2017 02:18 PM, John Snow wrote:
> >> @@ -346,13 +349,15 @@ static uint64_t coroutine_fn mirror_iteration(Mi=
rrorBlockJob *s)
> >>  backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
> >>  backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
> >>  backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p st=
art %"PRId64" ret %d"
> >=20
> > I guess these three were "cluster" based, but you didn't need to change
> > anything to assert them as byte-based.
> >=20
> >>
> >=20
> > Under the assumption that it's okay to change tracing output without
> > being able to differentiate between new and old output:
>=20
> I'll leave that to Stefan's discretion as trace maintainer, but my
> thoughts are that tracing is for debugging purposes, and as long as you
> know what binary you are debugging, you can figure out what the trace
> message meant by referring back to the source that generated that binary.

That's okay.  Trace events are not a stable interface.  Most trace
events are low-level and require access to the corresponding source tree
anyway.

The only exception is that tools in scripts/ may need to be updated when
trace events change (e.g. scripts to graph or analyze specific trace
events).

Stefan

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9ynwAAoJEJykq7OBq3PIIzgIAL0JRh2MOKrq/u90F8XQltCl
X7Mo5oORUugdlmXbNxTez7XSPyUq9QCSf4jnoThstSG6HbIjHJEwDcVAlJy6p0ri
Y5VSDzkatGgkMhNQc6WNg9kBlNpuupmFXB89TjAtcnFbHBMbHW80E7dbuGNGZCLA
73f1yWnmKj0No3Z9xGpzz9vZUpK5wT5V/xPTGz88q+BFxu2jztiMHHV67V0z3pYW
1jQrwM0fPSSY8OE0KU6ScrNQs7xfoMeI/dCObQQhqZd/6L6E2euuS+dWdqwMLTSH
Zz6dF/dz6CrYlFvxPfAMJ2rE1p1uXm0WDAD2LFbJ7deD/J0xaO6BmgleEGQECuc=
=bjQd
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
