Received: from eggs.gnu.org ([2001:4830:134:3::10]:51312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gEWoQ-0000Iu-Md
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gEWoM-0005z8-JW
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:47:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gEWoM-0005wp-D8
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:47:46 -0400
Date: Mon, 22 Oct 2018 10:47:37 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181022094737.GI32717@xz-x1>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
	<849fed2b-3763-14c1-d3a7-cc9891aeaff5@amd.com>
	<20181019122756-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181019122756-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v5 0/9] x86_iommu/amd: add interrupt remap
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

On Fri, Oct 19, 2018 at 12:28:20PM -0400, Michael S. Tsirkin wrote:
> It looks good to me, I am merging it.

Hi, Michael,

Would you like to consider taking some of the other IOMMU fixes into
your next pull too altogether?  They are:

  [PATCH v4 0/2] intel_iommu: better handling of dmar state switch
  [PATCH v3 0/2] intel_iommu: handle invalid ce for shadow sync

For each of the series, there should be two r-bs already.

Thanks,

-- 
Peter Xu
