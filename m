Received: from eggs.gnu.org ([2001:4830:134:3::10]:55988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjOEN-0005Ef-ME
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjOEJ-0003oi-QZ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:45:07 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:48930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjOEJ-0003oR-Jv
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:45:03 -0500
Date: Thu, 2 Mar 2017 10:44:59 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170302104459.GF1760@perard.uk.xensource.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-4-git-send-email-paul.durrant@citrix.com>
	<20170301161340.GD1760@perard.uk.xensource.com>
	<89af9dc8f67d4ae8b32d7e046e5bb10a@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <89af9dc8f67d4ae8b32d7e046e5bb10a@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 3/5] xen: create wrappers for all other
 uses of xc_hvm_XXX() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Mar 01, 2017 at 04:16:32PM +0000, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 01 March 2017 16:14
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> > Stabellini <sstabellini@kernel.org>; Paolo Bonzini <pbonzini@redhat.com>;
> > Richard Henderson <rth@twiddle.net>; Eduardo Habkost
> > <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>
> > Subject: Re: [PATCH 3/5] xen: create wrappers for all other uses of
> > xc_hvm_XXX() functions
> > 
> > On Thu, Feb 23, 2017 at 02:53:53PM +0000, Paul Durrant wrote:
> > > This patch creates inline wrapper functions in xen_common.h for all open
> > > coded calls to xc_hvm_XXX() functions outside of xen_common.h so that
> > use
> > > of xen_xc can be made implicit. This again is in preparation for the move
> > > to using libxendevicemodel.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > diff --git a/include/hw/xen/xen_common.h
> > b/include/hw/xen/xen_common.h
> > > index 1e08b98..31cf25f 100644
> > > --- a/include/hw/xen/xen_common.h
> > > +++ b/include/hw/xen/xen_common.h
> > > @@ -26,6 +26,50 @@ extern xc_interface *xen_xc;
> > >   * We don't support Xen prior to 4.2.0.
> > >   */
> > >
> > > +static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t
> > type,
> > > +                                   uint64_t first_pfn, uint32_t nr)
> > > +{
> > 
> > I don't know if it matters from where the functions are called, but
> > here, xc_hvm_set_mem_type takes a "uint64_t nr" (and not uint32_t).
> 
> Yes, the old APIs were wrong and discarded the upper 32 bits, so limiting here is correct. Moving to the new API fixes the issue.

OK, thanks.

In that case:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
