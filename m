Received: from eggs.gnu.org ([2001:4830:134:3::10]:42876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVzbB-0003Ba-D1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVzbA-00010T-HG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:49:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVzbA-00010D-C5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:49:16 -0500
Date: Tue, 24 Jan 2017 19:49:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170124114910.GD16400@pxdev.xzpeter.org>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485253571-19058-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/18] VT-d: vfio enablement and misc
 enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Jan 24, 2017 at 06:25:53PM +0800, Peter Xu wrote:
> This is v5 of vt-d vfio enablement series.
> 
> Most of the changes in v5 is not functionally, but related to
> comments, error_report()s, debugging, squashing patches, etc. (which
> are confirmed changes in v4), besides a tiny tweak when unmapping a
> whole address space (please see below changelog). There are still
> discussions in v4 thread, we can just continue there (or here), and
> from this version I'll remove RFC tag.
> 
> I didn't rebase to master since current master failed to build on my
> laptop (with a "vl.c/hax..." error), however this series should be
> okay to be applied cleanly upon it.

Sorry I forgot to append the todo list (please help adding in in case
I missed anything):

- don't need to notify IOTLB (psi/gsi/global) invalidations to devices
  that with ATS enabled
- investigate when guest map page while mask contains existing mapped
  pages (e.g. map 12k-16k first, then map 0-12k)
- coalesce unmap during page walk (currently, we send it once per
  page)
- when do PSI for unmap, whether we can send one notify directly
  instead of walking over the page table?

Above does not contain those that are still during discussion. And,
some of the entries still need tests to further prove it's
feasibility.

Thanks,

-- peterx
