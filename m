Received: from eggs.gnu.org ([2001:4830:134:3::10]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5YOR-0005dQ-V0
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5YOO-0005vx-1V
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:03:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5YON-0005vq-Rz
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:03:03 -0400
Date: Tue, 2 May 2017 15:02:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170502140252.GA16624@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170420121639.32685-1-berrange@redhat.com>
	<20170502132456.GD22502@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170502132456.GD22502@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] dist: create separate dist with
 bundled roms/libs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, May 02, 2017 at 02:24:56PM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 20, 2017 at 01:16:39PM +0100, Daniel P. Berrange wrote:
> > The qemu-XXXX.tar.bz2 currently contains bundled copies of the pixman
> > and dtc codebases, as well as pre-built ROM binaries and their sources.
> > 
> > Many OS distros want to build & ship ROMs separately to ensure license
> > compliance. Similarly they'll build pixman/dtc code independantly to
> > allow sharing with the rest of the distro. Thus they'll never use these
> > bundled files. A further complication is that these bundled files create
> > extra auditing work for distros when applying for export compliance,
> > particularly when the bundled files contain crypto code. This burden
> > applies merely by having the files in the tar.bz2, even if they're not
> > built into the binaries. If we ever want to include UEFI ROMs for x86
> > or AArch64, then the size of the QEMU dist will increase significantly
> > more.
> > 
> > The bundled ROMs though are fairly useful to end-users who are building
> > QEMU themselves and don't want to worry about figuring out the right
> > BIOS bits to build manually, so they shouldn't be dropped entirely.
> > 
> > This change thus alters 'make dist' to generate two release archives
> > 
> >  - qemu-XXX.tar.bz2 - minimal archive with only QEMU source code
> >  - qemu-bundled-XXX.tar.bz2 - QEMU source, plus bundled ROMs & libs
> > 
> > NB1, as it stands this change breaks "make install" since that assumes
> > existance of the pre-built ROMs in tree.
> 
> It would be good to fix this so that a minimal dist can build and
> install successfully.

Of course, I simply didn't want to sink time into it until we had a
little discussion about whether this is even the right direction
to take.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
