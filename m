Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmEbS-00045g-Mm
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmEbP-0007Ij-J0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:04:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cmEbP-0007Hz-DE
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:04:39 -0500
Date: Fri, 10 Mar 2017 15:04:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170310070430.GE17299@pxdev.xzpeter.org>
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
	<213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
	<1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
	<20170308085917.GC7135@pxdev.xzpeter.org>
	<1488965141.6514.33.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488965141.6514.33.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, yi l liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Mar 08, 2017 at 10:25:41AM +0100, Gerd Hoffmann wrote:
> > Current QEMU should have no restriction on parameter ordering, right?
> > Or do we have any existing case that:
> > 
> >   "$QEMU -parameter1 -parameter2"
> > 
> > will work, while...
> > 
> >   "$QEMU -parameter2 -parameter1"
> > 
> > won't work?
> 
> Well, we have.  If you, for example, add a scsi disk, you have to add a
> scsi host adapter first.

I wasn't aware of that... Thanks!

-- peterx
