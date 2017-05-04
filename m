Received: from eggs.gnu.org ([2001:4830:134:3::10]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2906375c9=wei.liu2@citrix.com>)
	id 1d6Ed7-00067X-9A
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2906375c9=wei.liu2@citrix.com>)
	id 1d6Ed3-00084f-AF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:09:05 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:46328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2906375c9=wei.liu2@citrix.com>)
	id 1d6Ed3-00083o-4e
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:09:01 -0400
Date: Thu, 4 May 2017 12:08:24 +0100
From: Wei Liu <wei.liu2@citrix.com>
Message-ID: <20170504110824.acom22gpn5oaecxn@citrix.com>
References: <alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
	<03cfd81856554ecd91c0c317353e819b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704181038360.31486@sstabellini-ThinkPad-X260>
	<51ac3ff38f464abfb98928e6fb959bf7@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704191552450.31486@sstabellini-ThinkPad-X260>
	<6738c7d96a1c476187f69616f25b28d1@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704201035390.18403@sstabellini-ThinkPad-X260>
	<20170503164838.GB1553@perard.uk.xensource.com>
	<20170503165207.k4z3xwusbi4vmmf5@citrix.com>
	<20170503165536.GC1553@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170503165536.GC1553@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] QEMU build breakage on ARM against Xen 4.9 caused
 by libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Wei Liu <wei.liu2@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Wed, May 03, 2017 at 05:55:36PM +0100, Anthony PERARD wrote:
> > > --- a/tools/libs/devicemodel/Makefile
> > > +++ b/tools/libs/devicemodel/Makefile
> > > @@ -63,7 +63,7 @@ libxendevicemodel.so.$(MAJOR): libxendevicemodel.so.$(MAJOR).$(MINOR)
> > >         $(SYMLINK_SHLIB) $< $@
> > >  
> > >  libxendevicemodel.so.$(MAJOR).$(MINOR): $(PIC_OBJS) libxendevicemodel.map
> > > -       $(CC) $(LDFLAGS) $(PTHREAD_LDFLAGS) -Wl,$(SONAME_LDFLAG) -Wl,libxendevicemodel.so.$(MAJOR) $(SHLIB_LDFLAGS) -o $@ $(PIC_OBJS) $(LDLIBS_libxentoollog) $(APPEND_LDFLAGS)
> > > +       $(CC) $(LDFLAGS) $(PTHREAD_LDFLAGS) -Wl,$(SONAME_LDFLAG) -Wl,libxendevicemodel.so.$(MAJOR) $(SHLIB_LDFLAGS) -o $@ $(PIC_OBJS) $(LDLIBS_libxentoollog) $(LDLIBS_libxencall) $(APPEND_LDFLAGS)
> > >  
> > 
> > Isn't the dependency already encoded in tools/Rules.mk?
> 
> How? Which makefile variable would include -lxencall in the abrove line?
> 

I was thinking about SHDEPS_* in Rules.mk. That's for something else.

And you're right. We should fix it here.

Wei.
