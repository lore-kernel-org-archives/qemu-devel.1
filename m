Received: from eggs.gnu.org ([2001:4830:134:3::10]:33145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cVkMy-00053K-Hh
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cVkMt-0003Cw-Kt
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:33:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cVkMt-0003Ci-EX
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:33:31 -0500
Date: Mon, 23 Jan 2017 12:33:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170123123329.2d9daa9c@t450s.home>
In-Reply-To: <20170122085118.GA26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v4 15/20] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com

On Sun, 22 Jan 2017 16:51:18 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Sun, Jan 22, 2017 at 03:56:10PM +0800, Jason Wang wrote:
> >   
> > >+            trace_vtd_page_walk_one(level, entry.iova, entry.translated_addr,
> > >+                                    entry.addr_mask, entry.perm);
> > >+            if (hook_fn) {
> > >+                ret = hook_fn(&entry, private);  
> > 
> > For better performance, we could try to merge adjacent mappings here. I
> > think both vfio and vhost support this and it can save a lot of ioctls.  
> 
> Looks so, and this is in my todo list.
> 
> Do you mind I do it later after this series merged? I would really
> appreciate if we can have this codes settled down first (considering
> that this series has been dangling for half a year, or more, startint
> from Aviv's series), and I am just afraid this will led to
> unconvergence of this series (and I believe there are other places
> that can be enhanced in the future as well).

NAK, we can't merge mappings per my comment on 18/20.  You're looking
at an entirely new or at best revised version of the vfio IOMMU
interface to do so.  vfio does not support invalidations at a smaller
granularity than the original mapping.  Thanks,

Alex
