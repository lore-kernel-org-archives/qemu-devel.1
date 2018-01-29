Received: from eggs.gnu.org ([2001:4830:134:3::10]:56067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDow-0000cn-HY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDov-0000qt-NJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:06:18 -0500
Date: Mon, 29 Jan 2018 19:06:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129180608.GP6141@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
	<ce7c11c5-bb34-fc54-308e-9f4ade6237fb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <ce7c11c5-bb34-fc54-308e-9f4ade6237fb@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.01.2018 um 17:57 hat Max Reitz geschrieben:
> On 2018-01-11 20:52, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1749376c61..9341f6708d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3320,6 +3320,37 @@
> >  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> > =20
> >  ##
> > +# @BlockdevQcow2CompatLevel:
> > +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (vers=
ion 2)
> > +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (versi=
on 3)
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'enum': 'BlockdevQcow2CompatLevel',
> > +  'data': [ '0_10', '1_1' ] }
>=20
> Just my two cents: I'd prefer 2 and 3 because I've never quite liked
> that people are supposed to remember some pretty random qemu version
> numbers anyway.

Yeah. An enum with '2' and '3' wouldn't work for Eric's desire to have
enum values starting in letters, though. I was originally planning to
replace it with an int, but then it's not introspectable.

An enum with 'v2' and 'v3' then?

Kevin

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJab2KQAAoJEH8JsnLIjy/W2/QQAJd1EFSepZHBFkhffrsw340u
S0U5r1idsko2d8u+hKe2b34lHmQBAvysaCs8ZYFvHRTy0rhGBURxIpEZcEzdXDi5
gwntDwuJU7A7ist+mKA0HPSvnn37jfF4pd66WHzBdo7DUUFna/c6iFb+pMVfig9X
lnN45BzJA0LhyNAzediamQwGc3t31/lvg7rEFZcH9d3m8vkHWobGvP1rwWl2cWMJ
EwecZAYthv/a9Tfmlw2t5BC9obGAjHcYv34rgjRE6RVlFmhRduqDTuQGuyijLBet
zxJ9w4K3cLfVkXp358jnTrch0e5lFDNpqDW8UTXcA5GsZVUUkJh4Uc6Kdd73z1Bo
FyrsmTWu3/WQpYghTFzYN+hOJ+6sW2KMUcuD0+nkYgYgBirbeEztHKENluvkKf3Z
AYsfGyfmqKbvcwddNfJtrDQAu25WBgUbrKaLjXirkXCU7SJvlTaSh6sDLFV7gQJR
C/B9D3oTg593lYw73GKgRL336r4Z4ENfLFXETYGVZSzf/eAFRR2rrM4md5Y7i+9W
agB/Hpjx910ObQCHMyxZ5HyvRQquOHeqNkAkCu4vccbBx5ENFo1F7Ln7bjpphgo8
laUyy/jqoEEhAmBgFD2Ii/Koci+evn80SNdaspmm24DifNko9KUm66UQtbqMXFng
quh+tIXlCutaagDpWVYR
=CBbg
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
