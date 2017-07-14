Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVsGW-0005co-7y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVsGT-0006J0-4N
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVsGS-0006Ii-UY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:31:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFB714E024
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:31:39 +0000 (UTC)
Date: Fri, 14 Jul 2017 12:31:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714043136.GJ27284@pxdev.xzpeter.org>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-3-git-send-email-peterx@redhat.com>
	<20170713204619-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713204619-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] intel_iommu: let iotlb size tunable
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

On Thu, Jul 13, 2017 at 08:47:00PM +0300, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 04:13:41PM +0800, Peter Xu wrote:
> > We were having static IOTLB size as 1024. Let it be a tunable. We can
> > also turns IOTLB off if we want, by specify the size as zero.
> > 
> > The tunable is named as "x-iotlb-size" since that should not really be
> > something used by user yet, but mostly for debugging purpose now.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I'm somewhat vary of adding tunables just for developers to play with.
> People will find and abuse them :)

I would think it convenient (especially with "x-") and I would never
worry about people using it (I really see nothing dangerous...). But
if you don't like it, I can drop it in next version for sure.

Thanks,

-- 
Peter Xu
