Received: from eggs.gnu.org ([2001:4830:134:3::10]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fERad-00066m-1c
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fERaZ-0002T3-Tl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:40:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fERaZ-0002SH-O0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:40:55 -0400
Date: Fri, 4 May 2018 11:40:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180504034042.GA28447@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<152540403226.2487.4650651377020838066@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152540403226.2487.4650651377020838066@71c20359a636>
Subject: Re: [Qemu-devel] [PATCH v2 00/10] intel-iommu: nested vIOMMU,
 cleanups, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kevin.tian@intel.com, mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, jintack@cs.columbia.edu

On Thu, May 03, 2018 at 08:20:33PM -0700, no-reply@patchew.org wrote:

[...]

> === OUTPUT BEGIN ===
> Checking PATCH 1/10: intel-iommu: send PSI always even if across PDEs...
> Checking PATCH 2/10: intel-iommu: remove IntelIOMMUNotifierNode...
> Checking PATCH 3/10: intel-iommu: add iommu lock...
> Checking PATCH 4/10: intel-iommu: only do page walk for MAP notifiers...
> Checking PATCH 5/10: intel-iommu: introduce vtd_page_walk_info...
> Checking PATCH 6/10: intel-iommu: pass in address space when page walk...
> Checking PATCH 7/10: util: implement simple interval tree logic...
> ERROR: space prohibited between function name and open parenthesis '('
> #56: FILE: include/qemu/interval-tree.h:33:
> +typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);
> 
> total: 1 errors, 0 warnings, 343 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

This is false positive, and should be dissolved after below patch
merged (now in Paolo's queue):

  [PATCH v2] checkpatch.pl: add common glib defines to typelist

-- 
Peter Xu
