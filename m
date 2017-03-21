Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cq8mA-0002QB-26
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cq8m6-0003gJ-W1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cq8m6-0003gB-Q7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6D70C05683F
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 01:39:50 +0000 (UTC)
Date: Tue, 21 Mar 2017 09:39:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170321013943.GB3860@pxdev.xzpeter.org>
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
	<1489980999-5965-3-git-send-email-jasowang@redhat.com>
	<20170320090734.GN17405@pxdev.xzpeter.org>
	<20170321031220-mutt-send-email-mst@kernel.org>
	<3d33b743-3939-9917-fc8c-f13c09ff7f1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d33b743-3939-9917-fc8c-f13c09ff7f1d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH fixup 2/2] vhost: genearlize iommu memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 20, 2017 at 08:21:44PM -0500, Eric Blake wrote:
> On 03/20/2017 08:12 PM, Michael S. Tsirkin wrote:
> 
> >>
> >> Since this patchset depends on vtd vfio series and fixes its breakage
> >> to vhost, I'll pick them up for consistency for next post of vtd vfio
> >> series as well.
> >>
> >> Thanks,
> >>
> >> -- peterx
> > 
> > Sounds good. It's best to order patches in a way that avoids
> > breakages even for people that bisect though.
> > Might require some patch squashing.
> 
> Indeed - a patch submitted with 'fixup' in the title is usually best
> incorporated by squashing into a prior patch that has not actually
> landed in master, rather than as a standalone patch.
> 
> But if you do post this to master as a standalone patch, please fix the
> subject line: s/genearlize/generalize/

Will do. Thanks!

-- peterx
