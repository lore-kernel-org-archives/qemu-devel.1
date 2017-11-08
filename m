Received: from eggs.gnu.org ([2001:4830:134:3::10]:49319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1eCPhR-0006Lq-KJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1eCPhN-0006hv-FZ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:43:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:35609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1eCPhN-0006hS-64
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:43:17 -0500
Date: Wed, 8 Nov 2017 13:43:15 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20171108134315.0b4d9aad@kitsune.suse.cz>
In-Reply-To: <20171108123417.GQ12670@redhat.com>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<20171108102529.GL12670@redhat.com>
	<20171108130527.0afeb899@kitsune.suse.cz>
	<20171108123417.GQ12670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, 8 Nov 2017 12:34:17 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Wed, Nov 08, 2017 at 01:05:27PM +0100, Michal Such=C3=A1nek wrote:
> > On Wed, 8 Nov 2017 10:25:29 +0000
> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >  =20
> > > On Wed, Nov 08, 2017 at 10:57:21AM +0100, Thomas Huth wrote: =20
> > > >=20
> > > > That automatic git submodule stuff now broke my workflow again.
> > > > I usually keep the git repository on my laptop and then simply
> > > > rsync the sources (without .git directories) to my target
> > > > machine to compile it there. Used to work great for years. Now
> > > > it's broken, the build process complains:   =20
> > >=20
> > > Excluding the .git dir will be a problem - that needs to exist,
> > > unless you are building from tar.xz (where we will bundled all
> > > the submodule sources together in the tar.xz).
> > >=20
> > > If you really want to exclude the .git directories, then instead
> > > of doing an rsync, then use the scripts/archive-source.sh tool to
> > > create an archive of all the sources (which bundles required
> > > submodules) and unpack that on your target machine. Then all
> > > submodule handling on the target will be skipped. =20
> >=20
> > This probably does not work because it archives committed sources
> > and not actual sources. =20
>=20
> Actually that's not quite correct - if it sees you have non-comitted
> changes, and will use 'git stash create' to capture them in the
> archive it creates.  So it would only miss brand new files which have
> not yet been 'git add'ed

So there really isn't a good solution.

>=20
> > > > I've got the feeling that all this submodule crap is constantly
> > > > causing pain ... do we really need this? Can't we find another
> > > > solution instead? Or at least stop modifying files
> > > > automatically in the $SRC_PATH ?   =20
> > >=20
> > > We *have* to modify SRC_PATH, as that's where git submodule
> > > checkouts live. If we didn't do that, then people would end up
> > > having failed build due to submodules not existing, or even
> > > worse, having a silently incorrect build due to using the wrong
> > > checked out version. =20
> >=20
> > And that's another reason why submodules are bad thing.
> >=20
> > So again, can this be done without submodules?
> >=20
> > Let somebody else do the testing and polishing of this pre-alpha git
> > feature. =20
>=20
> Honestly I think the submodule stuff is working pretty well - a
> handful of people have mentioned problems and we've addressed most of
> them or illustrated alternative approaches to deal with it. For most
> developers it has been pretty much transparent and just works, or we
> would have seen alot more noise.

> On 11/08/2017 06:57 AM, Thomas Huth wrote:

>=20
> Also yesterday on IRC:
>=20
> <RaV3N> [...] I downloaded the qemu source from git and tried to
> compile it. I am getting this:
>=20
> ./configure --static && make && sudo make install
>  CC      ui/input-keymap.o
> ui/input-keymap.c:8:10: fatal error: ui/input-keymap-linux-to-qcode.c:
> No such file or directory
>=20
> <cota> [...] you might want to do "git submodule init && git submodule
> update"
>=20

 .. you call that transparent.

Yeah, right.

Please don't pretend that something is working when it clearly isn't.

Repositories using submodules are far from first class citizens as far
as support from git is concerned.

Therefore projects that don't have git development at least as
secondary focus should not use them until that changes.

Thanks

Michal
