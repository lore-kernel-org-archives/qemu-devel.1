Received: from eggs.gnu.org ([2001:4830:134:3::10]:39818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxuMU-0003El-9X
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxuMT-0004Za-9I
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:25:46 -0400
Date: Fri, 29 Sep 2017 14:25:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170929122531.GE3812@localhost.localdomain>
References: <20170923111411.18626-1-el13635@mail.ntua.gr>
	<20170926110024.GA13332@stefanha-x1.localdomain>
	<20170926124425.ubuecf6haepcqeec@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20170926124425.ubuecf6haepcqeec@postretch>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] add bdrv_co_drain_begin/end
 BlockDriver callbacks
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.09.2017 um 14:44 hat Manos Pitsidianakis geschrieben:
> On Tue, Sep 26, 2017 at 12:00:24PM +0100, Stefan Hajnoczi wrote:
> > On Sat, Sep 23, 2017 at 02:14:08PM +0300, Manos Pitsidianakis wrote:
> > > This patch series renames bdrv_co_drain to bdrv_co_drain_begin and ad=
ds a new
> > > bdrv_co_drain_end callback to match bdrv_drained_begin/end and
> > > drained_begin/end of BdrvChild. This is needed because the throttle d=
river
> > > (block/throttle.c) needs a way to mark the end of the drain in order =
to toggle
> > > io_limits_disabled correctly.
> > >=20
> > > Based-on: <20170918202529.28379-1-el13635@mail.ntua.gr>
> > >     "block/throttle-groups.c: allocate RestartData on the heap"
> > >     Which fixes a coroutine crash in block/throttle-groups.c
> > >=20
> > > v3:
> > >   fixed commit message typo in first patch [Fam]
> > >   rephrased doc comment based on mailing discussion
> > > v2:
> > >   add doc for callbacks and change order of request polling for compl=
etion
> > >   [Stefan]
> > >=20
> > > Manos Pitsidianakis (3):
> > >   block: add bdrv_co_drain_end callback
> > >   block: rename bdrv_co_drain to bdrv_co_drain_begin
> > >   block/throttle.c: add bdrv_co_drain_begin/end callbacks
> > >=20
> > >  include/block/block_int.h | 13 ++++++++++---
> > >  block/io.c                | 48 +++++++++++++++++++++++++++++++++----=
----------
> > >  block/qed.c               |  6 +++---
> > >  block/throttle.c          | 18 ++++++++++++++++++
> > >  4 files changed, 65 insertions(+), 20 deletions(-)
> >=20
> > Oops, this seems to cause a qemu-iotests failure.  Please take a look:
> >=20
> > $ ./check -qcow2 184
> > 184 0s ... - output mismatch (see 184.out.bad)
> > --- /home/stefanha/qemu/tests/qemu-iotests/184.out	2017-09-19 14:51:46.=
673854437 +0100
> > +++ 184.out.bad	2017-09-26 11:13:06.946610239 +0100
> > @@ -142,6 +142,9 @@
> >         "guest": false
> >     }
> > }
> > +./common.config: line 118:  9196 Segmentation fault      (core dumped)=
 ( if [ -n "${QEMU_NEED_PID}" ]; then
> > +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
> > +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
> >=20
>=20
> Hey Stefan,
>=20
> This is fixed in
> > > Based-on: <20170918202529.28379-1-el13635@mail.ntua.gr>
> > >     "block/throttle-groups.c: allocate RestartData on the heap"
> > >     Which fixes a coroutine crash in block/throttle-groups.c
>=20
> Which I sent before this series and is in Kevin's branch.

Stefan, the fix is in master by now, so you can stage this series again.
(Or I can take it, if you prefer.)

Kevin

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZzju7AAoJEH8JsnLIjy/WOC0QAL/cPkZbIDVtj6c1Hb9c5B8t
Oh8sUBwM3q2Zozzu6X1TCUzIL2nKKoLwQ32sq74qE+BrXu22E7p/OnWKsUhJdJ5l
k5ZOmjBuKZnFVAw8mJzKRV2H4axAjRK0NzRYqICzWJVImp2QSTV6lKnTYEv83wg0
ho0Is/W//oLHYRyBdmGl1E6BbKC7t4Ff6npG49vYK/3HI7QnscPcOVduVoCnc5Zp
Mdd8hY3eggaYp25Q3C7is3rBEaC+pHpMezrf7E8KhkhobbXGKWdqubi05kj5MA2D
jNqnnBiy4OIBTbP+md8b0gV41IXumlLBGJdYj76G0zjP63oHJt6pvf/CvtrJAT2y
r1ghlznVde1HnHaFNvyFIdeg6uPt82guvQ4cILLQGb+oiIcSNz5Amh/luFlhNcJk
aN2HuugK/wppVuNeZwAGb0gEFODp29tJBlVdFvSU/HInh1FQwJQRn/+YiGA0MY+/
iVJl6pmIWpOJj8pXCPlE8Y00wHP71FRkqR1d6PSog5ArMk+vD+i2M26reKzIgPjM
2KWfIARcjsQuf4p4xXoCH/KEaQqU3ST6C6/BRS4kdLhLTQveBC/8L2SXira92uI3
B0MvaagZGUYHIkuidH5MRS/j0N2oeO3b8OYVzTafLH2RkL7OCyfPdhgCXjsfAPzg
55YAvEoxsu0PKmKwUTN+
=MfcR
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
