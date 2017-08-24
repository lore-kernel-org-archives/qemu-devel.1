Received: from eggs.gnu.org ([2001:4830:134:3::10]:58367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dktKc-0006Om-TF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 10:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dktKZ-0005tD-HE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 10:42:02 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:20417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dktKZ-0005ql-7R
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 10:41:59 -0400
Date: Thu, 24 Aug 2017 15:39:10 +0100
From: Roger Pau Monne <roger.pau@citrix.com>
Message-ID: <20170824143910.be7xidlpd6g7m4q5@dhcp-3-128.uk.xensource.com>
References: <20170824121919.78678-1-roger.pau@citrix.com>
	<20170824121919.78678-3-roger.pau@citrix.com>
	<599EEC140200007800173373@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <599EEC140200007800173373@prv-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [PATCH QEMU v2] xen/pt: allow QEMU to request MSI
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
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Thu, Aug 24, 2017 at 07:09:08AM -0600, Jan Beulich wrote:
> >>> On 24.08.17 at 14:19, <roger.pau@citrix.com> wrote:
> > When a MSI interrupt is bound to a guest using
> > xc_domain_update_msi_irq (XEN_DOMCTL_bind_pt_irq) the interrupt is
> > left masked by default.
> > 
> > This causes problems with guests that first configure interrupts and
> > clean the per-entry MSIX table mask bit and afterwards enable MSIX
> > globally. In such scenario the Xen internal msixtbl handlers would not
> > detect the unmasking of MSIX entries because vectors are not yet
> > registered since MSIX is not enabled, and vectors would be left
> > masked.
> > 
> > Introduce a new flag in the gflags field to signal Xen whether a MSI
> > interrupt should be unmasked after being bound.
> > 
> > This also requires to track the mask register for MSI interrupts, so
> > QEMU can also notify to Xen whether the MSI interrupt should be bound
> > masked or unmasked
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > Reported-by: Andreas Kinzler <hfp@posteo.de>
> 
> Reviewed-by: Jan Beulich <jbeulich@suse.com>

Thanks, Roger.
