Received: from eggs.gnu.org ([2001:4830:134:3::10]:34962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faJbM-0002p9-IG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faJbL-0005JT-7o
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:36:08 -0400
Date: Tue, 3 Jul 2018 12:35:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180703113557.GC24516@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703113229.GD3812@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org

On Tue, Jul 03, 2018 at 01:32:29PM +0200, Kevin Wolf wrote:
> Am 03.07.2018 um 13:22 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Tue, Jul 03, 2018 at 12:53:44PM +0200, Christian Borntraeger wrote=
:
> > >=20
> > >=20
> > > On 07/02/2018 10:04 AM, Kevin Wolf wrote:
> > > > Am 25.06.2018 um 13:45 hat Peter Krempa geschrieben:
> > > >> On Mon, Jun 25, 2018 at 13:41:06 +0200, Kevin Wolf wrote:
> > > >>> Am 25.06.2018 um 11:53 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > >>>> On Fri, Jun 22, 2018 at 03:31:46PM +0100, Daniel P. Berrang=C3=
=A9 wrote:
> > > >>>>> On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
> > > >>>>>> Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben=
:
> > > >>
> > > >> [...]
> > > >>
> > > >>>
> > > >>> Thanks!
> > > >>>
> > > >>> I'll look into werror/rerror support for usb-storage. It should=
n't be
> > > >>> too hard, though it's strictly speaking a separate problem rela=
ted to
> > > >>> using -blockdev rather than option deprecation.
> > > >>>
> > > >>> If Peter wants to wait for QEMU support before converting werro=
r/rerror
> > > >>
> > > >> Definitely. I don't want to keep around yet another hack that wi=
ll
> > > >> satisfy one specific case and then add another capability for it=
. We
> > > >> should then gate the moving of the feature based on the presence=
 of
> > > >> werror for usb-storage.
> > > >>
> > > >>> to -device, maybe it would make sense to split your patch for v=
2 so that
> > > >>> geometry and serial can get fixed right away?
> > > >>
> > > >> Yes this can be done right away.
> > > >=20
> > > > Has serial/gemoetry been fixed meanwhile and will it make it into=
 the
> > > > next release?
> > >=20
> > > I cannot find an archive that has it, but it is on the libvirt mail=
ing
> > > list as "[libvirt] [PATCH v3] qemu: format serial and geometry on f=
rontend disk device".
> > > Review seems done, but it has missed libvirt 4.5 which was released=
 today.
> >=20
> > Just posted latest version here:
> >=20
> >   https://www.redhat.com/archives/libvir-list/2018-July/msg00130.html
> >=20
> > It will be in the next release on ~ Aug 1st
>=20
> It would have been a lot nicer to have it the July release because this
> means that we'll have the released libvirt broken during almost the
> whole rc phase of QEMU 3.0, but the release is planned for Aug 8th the
> earliest, so I guess we're still okay. People using QEMU from git will
> just need libvirt from git as well.

Yeah, unfortunately i just missed the window of possibility to get it
into yesterday's release.

Fedora at least will be ok, and when other distros do pick up new QEMU
they'll likely pick up the corresponding libvirt release at same time
anyway.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
