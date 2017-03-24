Received: from eggs.gnu.org ([2001:4830:134:3::10]:46123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crQtl-0007U5-NE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crQth-0002Hh-OH
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:13:05 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:46744
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crQth-0002Fg-E2
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:13:01 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 24 Mar 2017 15:12:30 +0000
Message-ID: <2fb1da9d14c14eb4826a87657f7d0eb1@AMSPEX02CL03.citrite.net>
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
	<alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
	<214bc24d-1c0c-16d6-9c33-e20962b150d2@suse.com>
	<alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
	<da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
	<alpine.DEB.2.10.1703211152240.11679@sstabellini-ThinkPad-X260>
	<f1f79b77-f3bf-4bb0-135c-802bd5829de5@suse.com>
	<alpine.DEB.2.10.1703221120530.13499@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1703221120530.13499@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: use pkg-config for
 obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>, "kraxel@redhat.com" <kraxel@redhat.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 22 March 2017 18:22
> To: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>; qemu-devel@nongnu.org;
> xen-devel@lists.xenproject.org; Anthony Perard
> <anthony.perard@citrix.com>; kraxel@redhat.com; Paul Durrant
> <Paul.Durrant@citrix.com>
> Subject: Re: [PATCH 2/2] configure: use pkg-config for obtaining xen vers=
ion
>=20
> On Wed, 22 Mar 2017, Juergen Gross wrote:
> > On 21/03/17 19:54, Stefano Stabellini wrote:
> > > On Tue, 21 Mar 2017, Juergen Gross wrote:
> > >> On 17/03/17 19:33, Stefano Stabellini wrote:
> > >>> On Fri, 17 Mar 2017, Juergen Gross wrote:
> > >>>> On 16/03/17 21:20, Stefano Stabellini wrote:
> > >>>>> On Thu, 16 Mar 2017, Juergen Gross wrote:
> > >>>>>> Instead of trying to guess the Xen version to use by compiling
> various
> > >>>>>> test programs first just ask the system via pkg-config. Only if =
it
> > >>>>>> can't return the version fall back to the test program scheme.
> > >>>>>
> > >>>>> That's OK, but why did you remove the Xen unstable test?
> > >>>>
> > >>>> >From Xen 4.9 on pkg-config will return the needed information.
> There is
> > >>>> no longer a need for a test program to determine the Xen version.
> After
> > >>>> all this was the main objective of my series adding the pkg-config
> > >>>> files to Xen.
> > >>>
> > >>> I was going to say something like "yeah, but is pkg-config always
> > >>> available?" In reality, QEMU already has pkg-config as build
> > >>> dependency, so I guess there is no problem with that.
> > >>>
> > >>> Please add a note about this to the commit message.
> > >>>
> > >>
> > >> Okay.
> > >
> > > Sorry to point this out only now, and I realize that it might be
> > > unimportant for production builds, but it is important to me, and
> > > developers in general, to be able to test a single QEMU tree against =
a
> > > number of Xen trees (all releases from 4.3 onward).
> > >
> > > With this change (specifically dropping the 4.9 build test), out of t=
ree
> > > builds don't work anymore. I would like to be able to do:
> > >
> > > ./configure --enable-xen --target-list=3Di386-softmmu \
> > >                 --extra-cflags=3D"-I$DIR/tools/include \
> > >                 -I$DIR/tools/libs/toollog/include \
> > >                 -I$DIR/tools/libs/evtchn/include \
> > >                 -I$DIR/tools/libs/gnttab/include \
> > >                 -I$DIR/tools/libs/foreignmemory/include \
> > >                 -I$DIR/tools/libs/devicemodel/include \
> > >                 -I$DIR/tools/libxc/include \
> > >                 -I$DIR/tools/xenstore/include \
> > >                 -I$DIR/tools/xenstore/compat/include" \
> > >                 --extra-ldflags=3D"-L$DIR/tools/libxc \
> > >                 -L$DIR/tools/xenstore \
> > >                 -L$DIR/tools/libs/evtchn \
> > >                 -L$DIR/tools/libs/gnttab \
> > >                 -L$DIR/tools/libs/foreignmemory \
> > >                 -L$DIR/tools/libs/devicemodel \
> > >                 -Wl,-rpath-link=3D$DIR/tools/libs/toollog \
> > >                 -Wl,-rpath-link=3D$DIR/tools/libs/evtchn \
> > >                 -Wl,-rpath-link=3D$DIR/tools/libs/gnttab \
> > >                 -Wl,-rpath-link=3D$DIR/tools/libs/call \
> > >                 -Wl,-rpath-link=3D$DIR/tools/libs/foreignmemory \
> > >                 -Wl,-rpath-link=3D$DIR/tools/libs/devicemodel" \
> > >             --disable-kvm
> > > make
> > >
> > > And the make should succeed. Is there a way to do that with pkg-confi=
g?
> >
> > Sure, for Xen 4.9 just do:
> >
> > PKG_CONFIG_PATH=3D$(DIR)/tools/pkg-config ./configure \
> > 		--enable-xen --target-list=3Di386-softmmu \
> > 		--disable-kvm
> > make
>=20
> Yes, that works, thanks! I committed it to my next branch adding
> "pkg-config, which is already a build dependency of QEMU, will be used
> exclusively to determine the Xen version from Xen 4.9 onward." to the
> commit message.

A further question...

I have a xen tree which I've been using to build and install master against=
 my own checked out QEMU repo. No problem with that. I've now reverted my t=
ree to 4.7.0 and cannot build tools (even after a make distclean) because Q=
EMU's configure is still getting up a xen_ctrl_version of 40900. This is be=
cause pkg-config is still finding a 4.9.0 xencontrol package? Where is it g=
etting this from?

  Paul
