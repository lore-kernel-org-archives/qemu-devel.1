Received: from eggs.gnu.org ([2001:4830:134:3::10]:55600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cica9-0002mT-D2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cica6-0006ZC-BH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:52:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cica6-0006X0-5G
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:52:22 -0500
Date: Tue, 28 Feb 2017 15:52:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170228075211.GN10022@pxdev.xzpeter.org>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1486456099-7345-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/17] VT-d: vfio enablement and misc
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Feb 07, 2017 at 04:28:02PM +0800, Peter Xu wrote:
> This is v7 of vt-d vfio enablement series.
> 
> v7:
> - for the two traces patches: Change subjects. Remove vtd_err() and
>   vtd_err_nonzero_rsvd() tracers, instead using standalone trace for
>   each of the places. Don't remove any DPRINTF() if there is no
>   replacement. [Jason]
> - add r-b and a-b for Alex/David/Jason.
> - in patch "intel_iommu: renaming gpa to iova where proper", convert
>   one more place where I missed [Jason]
> - fix the place where I should use "~0ULL" not "~0" [Jason]
> - squash patch 16 into 18 [Jason]

Hi, Michael,

Do you have plan to have patch 11-17 as well in 2.9? Just a kind
reminder in case you have it since it's reaching soft freeze. Thanks,

-- peterx
