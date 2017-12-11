Received: from eggs.gnu.org ([2001:4830:134:3::10]:46742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOPhO-0002R9-Ok
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOPhL-0003nv-0n
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOPhK-0003mZ-QT
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:08:50 -0500
Date: Mon, 11 Dec 2017 15:08:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171211150841.GE23622@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CANCZdfrJoF=4zbGW+dVC9rnPD0ip+ZxXw0mAO_=r4gxFqW0KKA@mail.gmail.com>
	<20171211122936.GA2422@work-vm> <20171211123317.GB23622@redhat.com>
	<CANCZdfrCBEFEarMpP6zf0QRh7WbdEXT9F42wjm3eWYegg=JiRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfrCBEFEarMpP6zf0QRh7WbdEXT9F42wjm3eWYegg=JiRg@mail.gmail.com>
Subject: Re: [Qemu-devel] It told me to report this...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org

On Mon, Dec 11, 2017 at 08:05:29AM -0700, Warner Losh wrote:
> On Mon, Dec 11, 2017 at 5:33 AM, Daniel P. Berrange <berrange@redhat.com>
> wrote:
> 
> > On Mon, Dec 11, 2017 at 12:29:36PM +0000, Dr. David Alan Gilbert wrote:
> > > * Warner Losh (imp@bsdimp.com) wrote:
> > > > unknown keycodes `empty+aliases(qwerty)', please report to
> > > > qemu-devel@nongnu.org
> > > >
> > > > My X server is Mac XQuartz 2.7.11. I saw this question raised several
> > years
> > > > ago in the archives, with promises of patches, but couldn't find
> > anything
> > > > relevant in the latest tree I grabbed from github (I saw this problem
> > there
> > > > as well as 2.9.0 installed from FreeBSD ports).
> > > >
> > > > What's my next step here?
> > >
> > > I think that's one of Gerd's messages, so I've added him to the
> > > email and also Daniel since he's got an interest in key mappings.
> > >
> > > Have you any idea if it happened when you pressed a particular key?
> >
> > Don't worry, this is a known limitation of the current X backend for QEMU.
> >
> > It only knows how to work with Xorg on Linux with kbd or evdev. It can't
> > cope with OS-X or Windows  X11 servers yet. I've got patches that will
> > address this which i hope to finally put into 2.12 as part of the
> > keycodemapdb
> > work.
> >
> 
> I've built qemu many times over the years. I'd be happy to test them out to
> make sure they work for me :). Also, a million years ago, I did extensive
> work with X11 keymaps when I was working on the OI toolkit, so I have some
> familiarity...

I'm basically copying the same code / approach we've already done with
GTK-VNC & SPICE-GTK

I've got a patch here:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02058.html

but that almost certainly won't apply to current GIT master, so I'll be
sending updated versions soonish.

> > In the meantime your best bet is to use the native OS-X cocoa frontend for
> > QEMU, or VNC.
> >
> 
> That's... awkward since it would mean copying the VM over to mac... VNC
> might work though...

VNC would be my recommendation, or perhaps SPICE if you want some of its
extra features over VNC.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
