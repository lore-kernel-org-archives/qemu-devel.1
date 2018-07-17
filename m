Received: from eggs.gnu.org ([2001:4830:134:3::10]:50387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffMNE-0002VA-To
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffMNB-0004Fw-QX
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:34:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffMNB-0004FD-LV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:34:21 -0400
Date: Tue, 17 Jul 2018 10:34:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717093418.GI18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180624124540.6659-1-sameeh@daynix.com>
	<153177183866.7766.1789433991037567183@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153177183866.7766.1789433991037567183@sif>
Subject: Re: [Qemu-devel] [PATCH] qga-win: Handle fstrim for OSes lower than
 Win8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Mon, Jul 16, 2018 at 03:10:38PM -0500, Michael Roth wrote:
> Quoting Sameeh Jubran (2018-06-24 07:45:40)
> > From: Sameeh Jubran <sjubran@redhat.com>
> > 
> > The defrag.exe tool which is used for executing the fstrim command
> > on Windows doesn't support retrim for OSes lower than Win8. This
> > commit handles this case and returns a suitable error.
> > 
> > Output of fstrim before this commit:
> > {"execute":"guest-fstrim"}
> > {"return": {"paths": [{"path": "C:\\", "error": "An invalid command line option
> > was specified. (0x89000008)"}, {"path": "F:\\", "error": "An invalid command
> > line option was specified. (0x89000008)"}, {"path": "S:\\", "error": "An
> > invalid command line option was specified. (0x89000008)"}]}}
> > 
> > Reported on:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1594113
> > 
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> > ---
> >  qga/commands-win32.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index d79974f212..0bdcd9dd38 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -30,6 +30,7 @@
> >  #include <lm.h>
> >  #include <wtsapi32.h>
> >  #include <wininet.h>
> > +#include <versionhelpers.h>
> 
> I have this queued locally but the mingw64 build environment I've been
> using (fc20) doesn't support this header and I'm running into some odd

Please tell me that fc20 is a typo, and you're actually using the modern
fc28 :-)  Fedora 20 went end of life 3 years ago, so is not considered
a supported platform for QEMU per our policy here:

  https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

> null pointer / 0xc0000005 / access violation issues with the binary
> generated in newer tool chains. I'll send a pull for this next week when
> I can get it tested.
> 
> What build envionment are you using?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
