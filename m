Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVbz5-0007CJ-4s
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVbz4-0007z1-Cm
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:36:23 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVbz4-0007yw-6T
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:36:22 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so25420429wmd.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 02:36:22 -0800 (PST)
Date: Mon, 23 Jan 2017 10:36:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170123103618.GF29186@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170118160315.GS30347@stefanha-x1.localdomain>
	<08705645-17e8-1ffa-4199-c962f7198ab3@redhat.com>
	<20170119170128.GD27032@stefanha-x1.localdomain>
	<0969c169-772e-d213-675a-30aee616f8a8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <0969c169-772e-d213-675a-30aee616f8a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/16] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, famz@redhat.com, qemu-devel@nongnu.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:39:40PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 19/01/2017 18:01, Stefan Hajnoczi wrote:
> >>> This is a big and somewhat risky change.  Have you run any performance
> >>> benchmarks?
> >>
> >> Not recently; I ran them a year ago and there was no measurable differ=
ence.
> >=20
> > Good, please re-run for the final version.
>=20
> Done, went better than expected. :)
>=20
> base
> 4k-1 null   READ: io=3D6646.8MB, aggrb=3D226852KB/s, minb=3D226852KB/s, m=
axb=3D226852KB/s, mint=3D30000msec, maxt=3D30000msec
> 4k-1 nvme   READ: io=3D3086.4MB, aggrb=3D105342KB/s, minb=3D105342KB/s, m=
axb=3D105342KB/s, mint=3D30001msec, maxt=3D30001msec
> 4k-32 nvme  READ: io=3D14246MB, aggrb=3D486241KB/s, minb=3D486241KB/s, ma=
xb=3D486241KB/s, mint=3D30001msec, maxt=3D30001msec
>=20
> patched:
> 4k-1 null   READ: io=3D7044.5MB, aggrb=3D240436KB/s, minb=3D240436KB/s, m=
axb=3D240436KB/s, mint=3D30000msec, maxt=3D30000msec
> 4k-1 nvme   READ: io=3D3463.3MB, aggrb=3D118208KB/s, minb=3D118208KB/s, m=
axb=3D118208KB/s, mint=3D30001msec, maxt=3D30001msec
> 4k-32 nvme  READ: io=3D15217MB, aggrb=3D519378KB/s, minb=3D519378KB/s, ma=
xb=3D519378KB/s, mint=3D30001msec, maxt=3D30001msec
>=20
> null is null-co://, nvme is a fast (180kIOPS on bare-metal) NVMe SSD.
>=20
> So it seems to be some 5-10% faster.  No idea why so I would not give too
> much importance on the numbers, but at least it's not worse.

Nice, thank you!

Stefan

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhdyiAAoJEJykq7OBq3PIEMMIAL7c/kwIftq3eY5XcHi3mXFu
v4cGuWDO9rpSr66mUpBTJxaYq83Q4ygJghElMtmedZ5LQc4paY5sMP/D64wHomjC
YlKgW6QPRgRlr/Vd+Nmjf9Z+cBRYxblFwDnAS19c63f4VAbOaXdGrEbeFQWpInhl
pGcBUp5xeXe0JSNeabJP1YqtjsGTQK9hj0AdaEXv/Lk7ywvsMV/Y2QOxSbEbaGjC
qEI6a/am/MzzITgVXafO0bkhNEINmGsutTUe5i8bokoMWO70173AdL1YB2BGfA2/
PmDN3qvkT4NZYsUeDvdFbAlp6UB/dA4n5uKkKJPLXGid7V5oN1DmN6lShUR/S5Y=
=+3bt
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
