Received: from eggs.gnu.org ([2001:4830:134:3::10]:46260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eONH3-0001HK-Uv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eONH0-0007Gl-9z
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:33:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eONH0-0007EI-3t
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:33:30 -0500
Date: Mon, 11 Dec 2017 12:33:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171211123317.GB23622@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CANCZdfrJoF=4zbGW+dVC9rnPD0ip+ZxXw0mAO_=r4gxFqW0KKA@mail.gmail.com>
	<20171211122936.GA2422@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171211122936.GA2422@work-vm>
Subject: Re: [Qemu-devel] It told me to report this...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, kraxel@redhat.com, qemu-devel@nongnu.org

On Mon, Dec 11, 2017 at 12:29:36PM +0000, Dr. David Alan Gilbert wrote:
> * Warner Losh (imp@bsdimp.com) wrote:
> > unknown keycodes `empty+aliases(qwerty)', please report to
> > qemu-devel@nongnu.org
> > 
> > My X server is Mac XQuartz 2.7.11. I saw this question raised several years
> > ago in the archives, with promises of patches, but couldn't find anything
> > relevant in the latest tree I grabbed from github (I saw this problem there
> > as well as 2.9.0 installed from FreeBSD ports).
> > 
> > What's my next step here?
> 
> I think that's one of Gerd's messages, so I've added him to the
> email and also Daniel since he's got an interest in key mappings.
> 
> Have you any idea if it happened when you pressed a particular key?

Don't worry, this is a known limitation of the current X backend for QEMU.

It only knows how to work with Xorg on Linux with kbd or evdev. It can't
cope with OS-X or Windows  X11 servers yet. I've got patches that will
address this which i hope to finally put into 2.12 as part of the keycodemapdb
work.

In the meantime your best bet is to use the native OS-X cocoa frontend for
QEMU, or VNC.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
