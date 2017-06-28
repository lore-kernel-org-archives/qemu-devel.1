Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ70R-0003tW-AV
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ70O-0003xC-7R
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQ70O-0003x6-1Z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:03:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 134174ACD0
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 07:03:15 +0000 (UTC)
Date: Wed, 28 Jun 2017 15:03:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170628070308.GI14652@pxdev.xzpeter.org>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
	<20170627174019-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170627174019-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/8] VT-d: some enhancements on iotlb and
 tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Tue, Jun 27, 2017 at 05:42:59PM +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 27, 2017 at 05:03:31PM +0800, Peter Xu wrote:
> > Patch 1: fixes a very rare PT path issue on iova value. It didn't
> > break anything since it's merely not touched (only if when IOMMU
> > enabled, then set one device to PT), but still better fix it.
> 
> Pls Cc HMP/QMP maintainers on interface patches.
> 
> Adding hmp interface only seems questionable to me.
> 
> Let's split this out - functionality and performance
> can be separate from debugging and info.

Ok. I'll prepare separated series next time, and cc both QMP/HMP
maintainers for the interface series. Thanks,

-- 
Peter Xu
