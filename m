Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpcR-0006uW-6w
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpcM-00014O-G0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:44:11 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:42035
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpcM-00013c-82
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:44:06 -0400
Date: Thu, 24 Aug 2017 11:06:53 +0100
From: Roger Pau Monne <roger.pau@citrix.com>
Message-ID: <20170824100653.mqilcui6mmcqy7io@dhcp-3-128.uk.xensource.com>
References: <20170824094753.77795-1-roger.pau@citrix.com>
	<20170824094753.77795-3-roger.pau@citrix.com>
	<599EBE6D020000780017310E@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <599EBE6D020000780017310E@prv-mh.provo.novell.com>
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

On Thu, Aug 24, 2017 at 03:54:21AM -0600, Jan Beulich wrote:
> >>> On 24.08.17 at 11:47, <roger.pau@citrix.com> wrote:
> > @@ -274,7 +278,7 @@ int xen_pt_msi_update(XenPCIPassthroughState *s)
> >  {
> >      XenPTMSI *msi = s->msi;
> >      return msi_msix_update(s, msi_addr64(msi), msi->data, msi->pirq,
> > -                           false, 0, &msi->pirq);
> > +                           false, 0, &msi->pirq, false);
> >  }
> 
> I don't think this is correct when the device has mask bits.

Right, I thought I modified this. I've already changed
pt_irq_create_bind so that the original behavior is keep if the unmask
bit is not set. In this case this should be 'true' in order to keep
the previous behavior, which was correct for MSI.

It also makes me wonder whether it would be better to change the name
of the parameter to "unmask", so that false -> no change to mask, true
-> unconditionally unmask.

Thanks, Roger.
