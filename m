Received: from eggs.gnu.org ([2001:4830:134:3::10]:33208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpaZ-0005I8-AY
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpaU-0000C3-Js
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:42:15 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:33359
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpaU-0000Au-AI
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:42:10 -0400
Date: Thu, 24 Aug 2017 11:42:04 +0100
From: Roger Pau Monne <roger.pau@citrix.com>
Message-ID: <20170824104204.wq2rsxx2uovwtdmf@dhcp-3-128.uk.xensource.com>
References: <20170824094753.77795-1-roger.pau@citrix.com>
	<20170824094753.77795-3-roger.pau@citrix.com>
	<599EBE6D020000780017310E@prv-mh.provo.novell.com>
	<20170824100653.mqilcui6mmcqy7io@dhcp-3-128.uk.xensource.com>
	<599EC30602000078001731A4@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <599EC30602000078001731A4@prv-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [PATCH QEMU] xen/pt: allow QEMU to request MSI
 unmasking at bind time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, hfp@posteo.de

On Thu, Aug 24, 2017 at 04:13:58AM -0600, Jan Beulich wrote:
> >>> On 24.08.17 at 12:06, <roger.pau@citrix.com> wrote:
> > On Thu, Aug 24, 2017 at 03:54:21AM -0600, Jan Beulich wrote:
> >> >>> On 24.08.17 at 11:47, <roger.pau@citrix.com> wrote:
> >> > @@ -274,7 +278,7 @@ int xen_pt_msi_update(XenPCIPassthroughState *s)
> >> >  {
> >> >      XenPTMSI *msi = s->msi;
> >> >      return msi_msix_update(s, msi_addr64(msi), msi->data, msi->pirq,
> >> > -                           false, 0, &msi->pirq);
> >> > +                           false, 0, &msi->pirq, false);
> >> >  }
> >> 
> >> I don't think this is correct when the device has mask bits.
> > 
> > Right, I thought I modified this. I've already changed
> > pt_irq_create_bind so that the original behavior is keep if the unmask
> > bit is not set. In this case this should be 'true' in order to keep
> > the previous behavior, which was correct for MSI.
> 
> Wouldn't you want to pass the state of the mask bit here,
> rather than uniformly hard coding true or false?

Yes, I think so. I've overlooked the MSI code because I thought we
allowed QEMU to directly write to the mask register, but that's not
true, it's trapped by Xen.

Thanks, Roger.
