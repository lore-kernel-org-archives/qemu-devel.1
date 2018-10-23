Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gF506-0002IU-F7
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gF500-00052Q-DG
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gF4zz-0004f3-4L
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DFCE30F8BE2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 22:17:52 +0000 (UTC)
Date: Tue, 23 Oct 2018 23:17:37 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181023221712.GA12892@xz-x1.hotspot.internet-for-guests.com>
References: <20181009074543.6013-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009074543.6013-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] intel_iommu: handle invalid ce for
 shadow sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pei Zhang <pezhang@redhat.com>, Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>

Hi, Michael,

Just a kind reminder that this series has got enough ACKs and please
consider to merge it in your next pull.  Thanks!

On Tue, Oct 09, 2018 at 03:45:41PM +0800, Peter Xu wrote:
> v3:
> - pick r-b
> - return when -VTD_FR_CONTEXT_ENTRY_P is detected (v1 is correct here,
>   but I did wrong thing when splitting the patch in v2) [Eric]
> 
> v2:
> - split patch into more, remove useless comment [Eric]
> - remove one error_report_once() when rework the code [Jason]
> 
> This series fixes a QEMU crash reported here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1627272
> 
> Please review, thanks.
> 
> Peter Xu (2):
>   intel_iommu: move ce fetching out when sync shadow
>   intel_iommu: handle invalid ce for shadow sync
> 
>  dtc                   |  2 +-
>  hw/i386/intel_iommu.c | 55 +++++++++++++++++++++++--------------------
>  2 files changed, 30 insertions(+), 27 deletions(-)
> 
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
