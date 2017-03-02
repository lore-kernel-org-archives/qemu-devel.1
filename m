Received: from eggs.gnu.org ([2001:4830:134:3::10]:58536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjONg-0006us-Ha
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjONc-0006vP-Kq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:54:44 -0500
Received: from smtp.citrix.com ([66.165.176.89]:15676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjONc-0006vK-DA
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:54:40 -0500
Date: Thu, 2 Mar 2017 10:54:38 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170302105438.GG1760@perard.uk.xensource.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-5-git-send-email-paul.durrant@citrix.com>
	<20170301171735.GE1760@perard.uk.xensource.com>
	<61002dc9691a49d98a7feca8c9a676ce@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61002dc9691a49d98a7feca8c9a676ce@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 4/5] configure: detect presence of
 libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Mar 02, 2017 at 09:06:43AM +0000, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 01 March 2017 17:18
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> > Stabellini <sstabellini@kernel.org>
> > Subject: Re: [PATCH 4/5] configure: detect presence of libxendevicemodel
> > 
> > On Thu, Feb 23, 2017 at 02:53:54PM +0000, Paul Durrant wrote:
> > > This patch adds code in configure to set
> > CONFIG_XEN_CTRL_INTERFACE_VERSION
> > > to a new value of 490 if libxendevicemodel is present in the build
> > > environment.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > ---
> > >  configure | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/configure b/configure
> > > index 8e8f18d..fc1e12b 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -1980,6 +1980,25 @@ EOF
> > >    # Xen unstable
> > >    elif
> > >        cat > $TMPC <<EOF &&
> > > +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> > > +#define __XEN_TOOLS__
> > 
> > Isn't __XEN_TOOLS__ supposed to be reserved for some to tools inside
> > xen.git?
> > 
> > Also it seems to be the only time this define is used in your patch
> > series.
> >
> No. QEMU falls under the definition of 'tools' as far as Xen goes and the hypercalls and xendevicemodel API are protected by that. The reason you don't see it elsewhere is that xenctrl.h defines it. (See http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=tools/libxc/include/xenctrl.h;hb=HEAD#l27).
> I think that's a little underhand so I thought I'd make the new code in configure more transparent. I can change it to just include xenctrl.h before xendevicemodel.h if you'd prefer.

I guess that is fine with __XEN_TOOLS__.
You can add my
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
