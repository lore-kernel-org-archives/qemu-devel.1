Received: from eggs.gnu.org ([2001:4830:134:3::10]:47381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOPj2-0003Dt-17
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOPiy-0005GS-8i
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:10:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOPiy-0005G0-1r
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:10:32 -0500
Date: Mon, 11 Dec 2017 15:10:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171211151020.GF23622@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CANCZdfrJoF=4zbGW+dVC9rnPD0ip+ZxXw0mAO_=r4gxFqW0KKA@mail.gmail.com>
	<20171211122936.GA2422@work-vm>
	<CANCZdfovw_fX0wDf5-A4ibmFbK5H1iYEaw=U4Wa1V-9kMz2-aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfovw_fX0wDf5-A4ibmFbK5H1iYEaw=U4Wa1V-9kMz2-aw@mail.gmail.com>
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

On Mon, Dec 11, 2017 at 08:06:47AM -0700, Warner Losh wrote:
> On Mon, Dec 11, 2017 at 5:29 AM, Dr. David Alan Gilbert <dgilbert@redhat.com
> > wrote:
> 
> > * Warner Losh (imp@bsdimp.com) wrote:
> > > unknown keycodes `empty+aliases(qwerty)', please report to
> > > qemu-devel@nongnu.org
> > >
> > > My X server is Mac XQuartz 2.7.11. I saw this question raised several
> > years
> > > ago in the archives, with promises of patches, but couldn't find anything
> > > relevant in the latest tree I grabbed from github (I saw this problem
> > there
> > > as well as 2.9.0 installed from FreeBSD ports).
> > >
> > > What's my next step here?
> >
> > I think that's one of Gerd's messages, so I've added him to the
> > email and also Daniel since he's got an interest in key mappings.
> >
> > Have you any idea if it happened when you pressed a particular key?
> >
> 
> It's just once, on boot. Pressing keys, though, is an exercise in futility.
> Nothing maps right at all.

Yep, QEMU tries to detect if Xorg is using evdev, and if not it assumes the
legacy Linux  "kbd" driver mapping. This is unquestionably wrong for any
non-Linux  X11 server, so you'll just get complete garbage, as you found
out.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
