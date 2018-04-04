Received: from eggs.gnu.org ([2001:4830:134:3::10]:39849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3ifI-0006QY-J9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3ifF-0003j6-Fj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:41:28 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3ifF-0003ic-7O
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:41:25 -0400
Received: by mail-wr0-x242.google.com with SMTP id y55so22756539wry.3
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 06:41:25 -0700 (PDT)
Date: Wed, 4 Apr 2018 14:41:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404134122.GS4467@stefanha-x1.localdomain>
References: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
	<20180403031147.GC6839@lemon.usersys.redhat.com>
	<CAEMkAmGrW=h5Z1YncOQ4v2nmHt99-0Wg6aP6yCTd2p-ooToA4A@mail.gmail.com>
	<20180403033033.GD6839@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCKkSrrNUaKEhaIQ"
Content-Disposition: inline
In-Reply-To: <20180403033033.GD6839@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] Loadable block drivers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lindsay Mathieson <lindsay.mathieson@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


--lCKkSrrNUaKEhaIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 11:30:33AM +0800, Fam Zheng wrote:
> On Tue, 04/03 13:17, Lindsay Mathieson wrote:
> > On 3 April 2018 at 13:11, Fam Zheng <famz@redhat.com> wrote:
> >=20
> > > On Tue, 04/03 12:59, Lindsay Mathieson wrote:
> > > > Hi all, was looking at developing a block driver for qemu - have ex=
amined
> > > > the drivers at:
> > > >
> > > >   https://github.com/qemu/qemu/tree/master/block
> > > >
> > > > And it seems straightforward enough.
> > > >
> > > > One thing that is unclear - all the drivers appear to be compiled
> > > directly
> > > > into qemu. Is there no way to load them dynamically as .so modules?
> > >
> > > './configure --enable-modules' will enable building block drivers as =
=2Eso
> > > objects, and they are loaded dynamically. These are in-tree .so modul=
es;
> > > out-of-tree modules like in Linux kernel are intentionally forbidden.
> > >
> > > Fam
> > >
> >=20
> >=20
> >=20
> > Rats, I take it that means I can't develop a testing block module and l=
oad
> > it with an pre-existing qemu install.
>=20
> No, that's not possible.

Depending on what you are trying to do, you could use the blkdebug,
null-co, NBD, or iSCSI drivers to perform your testing.

blkdebug does fault injection (e.g. you can test what happens when
certain I/O requests fail).

null-co is a nop block driver useful for some types of performance
testing and it also supports introducing an artificial delays.

NBD and iSCSI can be used to forward I/O requests to an external server
where you can implement any behavior you want.

We can discuss it more if you can explain what you're trying to do.

Stefan

--lCKkSrrNUaKEhaIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxNYCAAoJEJykq7OBq3PIH1MH/ifIh859OCJZOvT4qpTmmy7G
uQecO0PIay5A69x6+dJk07+yaZogPevoe6q0am650Fx8PrXgSzXHhU4Rzc6p9uAE
jB7r0GYukbLkwUCWt6cIxmj1bhpx03G1f4/7jIY0uXUTsFhzorZ2YVCP8ATta1LW
2AXjQNjTqkcf23eUBCWYU4UbMEDtU6WoDuw2l/c7nMaSOdIFiZh0ydNUy497M3Yk
3vFLnYe/uup8FLns2lehFJeyL0JcLq+6EA+HYkWsuFzx2mSjqEuwbsNGUT3MOnOw
4vxZ4xD+xb8X66uidCJ9CL4lPQtauJn6/1+Je+m9lIoyJSn+DHksah2VKk2EK1A=
=dT+U
-----END PGP SIGNATURE-----

--lCKkSrrNUaKEhaIQ--
