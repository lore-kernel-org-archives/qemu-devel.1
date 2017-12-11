Received: from eggs.gnu.org ([2001:4830:134:3::10]:44691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1eOPeD-0007cq-VP
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1eOPe7-0000G1-J1
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:05:37 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:45785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1eOPe7-0000FE-5K
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:05:31 -0500
Received: by mail-it0-x22e.google.com with SMTP id z6so16563870iti.4
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 07:05:30 -0800 (PST)
MIME-Version: 1.0
Sender: wlosh@bsdimp.com
In-Reply-To: <20171211123317.GB23622@redhat.com>
References: <CANCZdfrJoF=4zbGW+dVC9rnPD0ip+ZxXw0mAO_=r4gxFqW0KKA@mail.gmail.com>
	<20171211122936.GA2422@work-vm> <20171211123317.GB23622@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 11 Dec 2017 08:05:29 -0700
Message-ID: <CANCZdfrCBEFEarMpP6zf0QRh7WbdEXT9F42wjm3eWYegg=JiRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] It told me to report this...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org

On Mon, Dec 11, 2017 at 5:33 AM, Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Mon, Dec 11, 2017 at 12:29:36PM +0000, Dr. David Alan Gilbert wrote:
> > * Warner Losh (imp@bsdimp.com) wrote:
> > > unknown keycodes `empty+aliases(qwerty)', please report to
> > > qemu-devel@nongnu.org
> > >
> > > My X server is Mac XQuartz 2.7.11. I saw this question raised several
> years
> > > ago in the archives, with promises of patches, but couldn't find
> anything
> > > relevant in the latest tree I grabbed from github (I saw this problem
> there
> > > as well as 2.9.0 installed from FreeBSD ports).
> > >
> > > What's my next step here?
> >
> > I think that's one of Gerd's messages, so I've added him to the
> > email and also Daniel since he's got an interest in key mappings.
> >
> > Have you any idea if it happened when you pressed a particular key?
>
> Don't worry, this is a known limitation of the current X backend for QEMU.
>
> It only knows how to work with Xorg on Linux with kbd or evdev. It can't
> cope with OS-X or Windows  X11 servers yet. I've got patches that will
> address this which i hope to finally put into 2.12 as part of the
> keycodemapdb
> work.
>

I've built qemu many times over the years. I'd be happy to test them out to
make sure they work for me :). Also, a million years ago, I did extensive
work with X11 keymaps when I was working on the OI toolkit, so I have some
familiarity...


> In the meantime your best bet is to use the native OS-X cocoa frontend for
> QEMU, or VNC.
>

That's... awkward since it would mean copying the VM over to mac... VNC
might work though...

Warner
