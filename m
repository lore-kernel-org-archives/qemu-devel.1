Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSjin-0001ph-KN
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSjij-0007vh-NY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:47:57 -0400
Date: Wed, 5 Jul 2017 13:47:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170705124748.GA1280@stefanha-x1.localdomain>
References: <CAJSP0QUD58kjc=8WAxwocK_HGJGqG-YeR5LqU3cCZCgdemZe4g@mail.gmail.com>
	<71215f3b-4b44-accc-d84a-87d4749bf391@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <71215f3b-4b44-accc-d84a-87d4749bf391@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Fuzzing event loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 04:53:45PM -0400, John Snow wrote:
> On 06/11/2017 06:47 AM, Stefan Hajnoczi wrote:
> > I wanted to share this idea about fuzzing event loops:
> >=20
> > https://blog.acolyer.org/2017/06/09/node-fz-fuzzing-the-server-side-eve=
nt-driven-architecture/
> >=20
> > The idea is to expose ordering dependencies and atomicity bugs in
> > event loop callbacks/coroutines by randomly shuffling the order in
> > which fd handlers, timers, etc execute.
> >=20
> > I'm not sure we'd find many bugs since QEMU tends to use big locks or
> > request serialization when concurrency gets tricky in the block layer.
> > Still, it's an interesting concept that we could apply in the future.
> >=20
> > Stefan
> >=20
>=20
> Sounds fun, probably too detailed for a GSoC/Outreachy project, right?
> Do we have a page on the wiki for random "Hey, this might be nice..." ide=
as?
>=20
> (Or is that a bad idea itself so we don't have a graveyard of 'not my
> problem' projects?)

This idea is difficult as an internship because it's an investigation
project.  It may produce no results or may require deep knowledge of
QEMU internals to resolve issues that are identified.

I just wanted to share the idea.

Stefan

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXN/0AAoJEJykq7OBq3PIYDsH/iJkWjBCNSM5EWFavINZFsuv
5HZ2yiY4EvCvjE40ZtHPsl7k4UATc2R21IyLu3jt0hJ2E5A5ZJeWX+XU/KLQ2Hp/
9BFi0jlWsV6W4fFG0/YEMyPtkyWWrOFcLU2emhBVxBz3wFZCZIu5DxurDuKTCt7F
jC9yfaCFxJAoKv5pR+K4PclFtEYONNgkf3XwgZze31bd7jajVcKcg3w/XmuSLdUq
FoslXBYzJdxQedMQe2NZm75nnew85fdMj8P9mBRlYv7Cf3M1v/umfyr5k5O5N1jy
cDRP02wE8CEwGdvvZeWWqUWZReOcSM1LoKkrMg6Xu5ejmR5z0NZ9RU7eIs/UXBU=
=6r2I
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
