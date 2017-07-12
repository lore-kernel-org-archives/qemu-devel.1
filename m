Received: from eggs.gnu.org ([2001:4830:134:3::10]:58202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVF60-0007s5-GJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVF5z-000377-OP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:42:16 -0400
Date: Wed, 12 Jul 2017 11:42:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712104202.GI6923@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-12-pbonzini@redhat.com>
	<20170710162419.GS14195@stefanha-x1.localdomain>
	<c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
	<20170711094356.GI17792@stefanha-x1.localdomain>
	<16c674cf-0474-61e6-6f0d-cfb059d30532@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <16c674cf-0474-61e6-6f0d-cfb059d30532@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 11/11] block/snapshot: do not
 take AioContext lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 11:48:02AM +0200, Paolo Bonzini wrote:
> On 11/07/2017 11:43, Stefan Hajnoczi wrote:
> >>>
> >>> 1. Must be called under BQL?
> >>> 2. Can I/O requests be in flight?
> >>> 3. Is it thread-safe?
> >>>
> >>> Otherwise it will be a nightmare to modify the code since these
> >>> constraints are not enforced by the compiler and undocumented.
> >> Good point.  Are (1) and (3) different ways to say the same thing or do
> >> you have other differences in mind?
> > There is a difference between (1) and (3).  If a function is thread-safe
> > then callers can invoke it without any constraints.  If a function
> > requires a specific lock to be held then that it puts a constraint on
> > the caller.
> >=20
> > We do have thread-safe functions in the block layer: simple functions
> > that fetch a BDS field atomically.  There is no need to hold the BQL for
> > them.
>=20
> Ok, so we are in (somewhat violent) agreement.  "It's not thread-safe"
> pretty much means "must be called under BQL".
>=20
> I look forward to extending Marc-Andr=E9's -Wthread-safety experiments to
> cover bdrv_drained_begin/end!

Sounds good :).

Stefan

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZfz6AAoJEJykq7OBq3PIMYkIAKzF5oHMz/y3003z+ygbWKkS
PCnxifwNWXqwDmqvvm0dlIS7uHL2q9zFIoPeufjE7qM3x1G+P2DLHWrwXglxSJe5
JHM3SzQ0WDbnH/qFLOVT7lT9Hm7WGUrfIPVx/ovxRy+GV1wMOTtDXsfnFCRDsj1b
W/FrsuvQ0CZcjIa29N6MQkm/eKTcaPToaIH/HSs8okB3rqSv/zYXAg1ClsogKNlV
cRsop3BjEmPv++IO3eTVoxj6a3eLbe28XkQjmIMohEfsqZ4Q72IKuta4k/YRkUmi
lVC5FxndJH0Vi1dx2MCzzWFAuneZempVVtl5UF3TydXsi9/18aocKJzzcQsBT6k=
=9nBP
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
