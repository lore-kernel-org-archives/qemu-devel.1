Received: from eggs.gnu.org ([2001:4830:134:3::10]:37546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1GSc-0005sU-C0
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1GSZ-0007k3-6W
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:05:42 -0400
Received: from mail.kernel.org ([198.145.29.136]:46926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1GSY-0007jm-VV
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:05:39 -0400
Date: Thu, 20 Apr 2017 11:05:33 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <6738c7d96a1c476187f69616f25b28d1@AMSPEX02CL03.citrite.net>
Message-ID: <alpine.DEB.2.10.1704201035390.18403@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
	<03cfd81856554ecd91c0c317353e819b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704181038360.31486@sstabellini-ThinkPad-X260>
	<51ac3ff38f464abfb98928e6fb959bf7@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704191552450.31486@sstabellini-ThinkPad-X260>
	<6738c7d96a1c476187f69616f25b28d1@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Wei Liu <wei.liu2@citrix.com>, "jgross@suse.com" <jgross@suse.com>, "julien.grall@arm.com" <julien.grall@arm.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Thu, 20 Apr 2017, Paul Durrant wrote:
> > -----Original Message-----
> > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > Sent: 20 April 2017 00:02
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: 'Stefano Stabellini' <sstabellini@kernel.org>; qemu-devel@nongnu.org;
> > Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> > <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen-
> > devel@lists.xenproject.org
> > Subject: RE: QEMU build breakage on ARM against Xen 4.9 caused by
> > libxendevicemodel
> > 
> > On Wed, 19 Apr 2017, Paul Durrant wrote:
> > > > -----Original Message-----
> > > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > > Sent: 18 April 2017 18:41
> > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > Cc: 'Stefano Stabellini' <sstabellini@kernel.org>; qemu-
> > devel@nongnu.org;
> > > > Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> > > > <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen-
> > > > devel@lists.xenproject.org
> > > > Subject: RE: QEMU build breakage on ARM against Xen 4.9 caused by
> > > > libxendevicemodel
> > > >
> > > > On Tue, 18 Apr 2017, Paul Durrant wrote:
> > > > > > -----Original Message-----
> > > > > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > > > > Sent: 15 April 2017 01:40
> > > > > > To: Stefano Stabellini <sstabellini@kernel.org>
> > > > > > Cc: Paul Durrant <Paul.Durrant@citrix.com>; qemu-
> > devel@nongnu.org;
> > > > > > Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> > > > > > <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen-
> > > > > > devel@lists.xenproject.org
> > > > > > Subject: Re: QEMU build breakage on ARM against Xen 4.9 caused by
> > > > > > libxendevicemodel
> > > > > >
> > > > > > On Fri, 14 Apr 2017, Stefano Stabellini wrote:
> > > > > > > Hi Paul,
> > > > > > >
> > > > > > > The following commit in my qemu "next" branch breaks the build on
> > > > arm
> > > > > > > and arm64:
> > > > > > >
> > > > > > > commit 670271647ad15e9d937ced7a72c892349c709216
> > > > > > > Author: Paul Durrant <paul.durrant@citrix.com>
> > > > > > > Date:   Tue Mar 7 10:55:34 2017 +0000
> > > > > > >
> > > > > > >     xen: use libxendevicemodel when available
> > > > > > >
> > > > > > > See the appended build log. Sorry for not realizing it sooner.
> > > > > >
> > > > > > As I imagined, this bug is easy to solve. It is reproducible on x86 too,
> > > > > > if you pass -DXC_WANT_COMPAT_DEVICEMODEL_API=1 to configure
> > > > and
> > > > > > forcefully disable Xen 4.9 detection in the configure script.
> > > > > >
> > > > > > If QEMU detects xen_ctrl_version = 480, the build will fail against Xen
> > > > > > 4.9, even when -DXC_WANT_COMPAT_DEVICEMODEL_API=1 is
> > > > specified.
> > > > > >
> > > > > > The appended patch solves the problem. However, Xen 4.9 detection
> > > > and
> > > > > > compilation remain broken.
> > > > >
> > > > > Ok, that fix looks fine to me.
> > > >
> > > > I merged this change into "use libxendevicemodel when available" in my
> > > > next branch.
> > > >
> > > > Are you going to take care of getting the QEMU build on ARM to work
> > > > against Xen 4.9 (properly detecting 4.9, without
> > > > -DXC_WANT_COMPAT_DEVICEMODEL_API=1)?
> > > >
> > >
> > > I can take a look once I get access to some h/w. Since the 4.9 detection
> > should merely be based upon the presence of libxendevicemodel, I can't
> > really imagine why ARM should behave any differently to x86.
> > 
> > I managed to find the time to do some debugging. You are right that is
> > not anything major. The bug is due to a missing -lxencall in the QEMU
> > configure script, I wonder why it works on x86.
> 
> Yes, that's weird. libxendevicemodel does depend on libxencall for the case when the privcmd driver in dom0 does not support the new DM_OP ioctl, but that dependency should be there regardless of architecture.
> 
> > 
> > diff --git a/configure b/configure
> > index 99d6cbc..363a126 100755
> > --- a/configure
> > +++ b/configure
> > @@ -2027,9 +2027,9 @@ int main(void) {
> >    return 0;
> >  }
> >  EOF
> > -        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> > +        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel -
> > lxencall"
> >        then
> > -      xen_stable_libs="$xen_stable_libs -lxendevicemodel"
> > +      xen_stable_libs="$xen_stable_libs -lxendevicemodel -lxencall"
> >        xen_ctrl_version=40900
> >        xen=yes
> >      elif
> 
> I think xencall should be part of the base xen_stable_libs anyway.

Yes, you are right. However I noticed that -lxencall needs to come after
-lxendevicemodel. So, I'll have to move -lxendevicemodel before
$xen_stable_libs, see below. I'll merge this patch into "configure:
detect presence of libxendevicemodel", if that's OK.

diff --git a/configure b/configure
index 99d6cbc..3133ef8 100755
--- a/configure
+++ b/configure
@@ -1992,7 +1992,7 @@ if test "$xen" != "no" ; then
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
-    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
+    xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
 
     # First we test whether Xen headers and libraries are available.
     # If no, we are done and there is no Xen support.
@@ -2027,9 +2027,9 @@ int main(void) {
   return 0;
 }
 EOF
-        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
       then
-      xen_stable_libs="$xen_stable_libs -lxendevicemodel"
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
       xen_ctrl_version=40900
       xen=yes
     elif
