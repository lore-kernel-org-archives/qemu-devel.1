Received: from eggs.gnu.org ([2001:4830:134:3::10]:37024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBD5P-0007SV-F3
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBD5M-00079g-BA
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:35:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBD5M-00079M-2i
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:35:20 -0400
Date: Wed, 25 Apr 2018 13:34:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180425053457.GK9036@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<152463271320.2265.7000482836762876371@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152463271320.2265.7000482836762876371@71c20359a636>
Subject: Re: [Qemu-devel] [PATCH 00/10] intel-iommu: nested vIOMMU, cleanups,
 bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, jintack@cs.columbia.edu, mst@redhat.com

On Tue, Apr 24, 2018 at 10:05:14PM -0700, no-reply@patchew.org wrote:

[...]

> === OUTPUT BEGIN ===
> Checking PATCH 1/10: intel-iommu: send PSI always even if across PDEs...
> Checking PATCH 2/10: intel-iommu: remove IntelIOMMUNotifierNode...
> Checking PATCH 3/10: intel-iommu: add iommu lock...
> Checking PATCH 4/10: intel-iommu: only do page walk for MAP notifiers...
> Checking PATCH 5/10: intel-iommu: introduce vtd_page_walk_info...
> Checking PATCH 6/10: intel-iommu: pass in address space when page walk...
> Checking PATCH 7/10: util: implement simple interval tree logic...
> WARNING: architecture specific defines should be avoided
> #34: FILE: include/qemu/interval-tree.h:11:
> +#ifndef __INTERVAL_TREE_H__

This is valid; I'll remove __ prefix/suffix and it'll fix.

> 
> ERROR: space prohibited between function name and open parenthesis '('
> #56: FILE: include/qemu/interval-tree.h:33:
> +typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);

While this is not; We possibly need the gboolean type into type list.
I'll post a standalone patch for checkpatch instead.

> 
> total: 1 errors, 1 warnings, 352 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 8/10: intel-iommu: maintain per-device iova ranges...
> Checking PATCH 9/10: intel-iommu: don't unmap all for shadow page table...
> Checking PATCH 10/10: intel-iommu: remove notify_unmap for page walk...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

-- 
Peter Xu
