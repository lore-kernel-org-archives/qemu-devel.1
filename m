Received: from eggs.gnu.org ([2001:4830:134:3::10]:38011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMwC7-0006TX-9e
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMwC3-0007V0-Df
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:31:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMwC3-0007Lc-0R
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:30:59 -0500
Date: Wed, 14 Nov 2018 14:30:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114143038.GL19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114142642.GA3103@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114142642.GA3103@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, samuel.thibault@ens-lyon.org, renzo@cs.unibo.it, qemu-devel@nongnu.org, rjones@redhat.com

On Wed, Nov 14, 2018 at 02:26:42PM +0000, Stefan Hajnoczi wrote:
> On Wed, Nov 14, 2018 at 04:36:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >=20
> > Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
> >=20
> > This series goal is to allow building libslirp as an independent libr=
ary.
> >=20
> > While looking at making SLIRP a seperate running process, I thought
> > that having an independent library from QEMU would be a first step.
> >=20
> > There has been some attempts to make slirp a seperate project in the =
past.
> > (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> > Unfortunately, they forked from QEMU and didn't provide enough
> > compatibility for QEMU to make use of it (in particular, vmstate
> > handling was removed, they lost git history etc). Furthermore, they
> > are not maintained as far as I can see.
> >=20
> > I would propose to make slirp a seperate project, that can initially
> > be used by QEMU as a submodule, keeping Makefile.objs until a proper
> > shared library with stability guarantees etc is ready..
> >=20
> > The subproject could created by preserving git tags, and cleaning up =
the code style, this way:
> >=20
> > git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clan=
g-format -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-em=
pty --tag-name-filter cat -- --all
> > (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8=
a2404678ac73)
> >=20
> > What do you think?
>=20
> Great idea!
>=20
> Maybe in the future there will be a tests too.  Right now my impression
> is that slirp isn't hardened and suitable for production use cases (i.e=
.
> security).  But with some love (and testing!) I think that could change=
.

With Marc-Andr=C3=A9's desire to move it to a separate process, it is the
kind of thing where seccomp could actually do a fairly good job as it
would be a narrow enough piece of functionality that you can put some
meaningful constraints around it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
