Received: from eggs.gnu.org ([2001:4830:134:3::10]:34863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eRvIH-0002r2-9C
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eRvIC-0008LG-9Z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:29:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eRvIB-0008Ku-UX
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:29:24 -0500
Date: Thu, 21 Dec 2017 09:27:51 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20171221072750.GC2931@yuvallap>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171219194951-mutt-send-email-mst@kernel.org>
	<77710384-30d0-cb76-9dbc-6195b831f050@redhat.com>
	<20171220200550-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220200550-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V2 0/5] hw/pvrdma: PVRDMA device
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

> > 
> > > What happens if guest attempts to register all its memory?
> > > 
> > 
> > Then we loose, is not different from bare metal, reg_mr will pin all the RAM.
> 
> We need to find a way to communicate to guests about amount
> of memory they can pin.

dev_caps.max_mr_size is the way device limits guest driver.
This value is controlled by the command line argument dev-caps-max-mr-size
so we should be fine (btw, default value is 1<<32).

> 
> > However this is only one scenario, and hopefully not much used
> > for RoCE. (I know IPoIB does that, but it doesn't make sense to use it with RoCE).
> 
> SRP does it too AFAIK.
> 
