Received: from eggs.gnu.org ([2001:4830:134:3::10]:33172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gF51c-0003W8-H3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gF51b-0007Yk-06
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:19:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gF51a-0007WZ-D5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:19:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E18ADC050018
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 22:19:40 +0000 (UTC)
Date: Tue, 23 Oct 2018 23:19:29 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181023221929.GB12892@xz-x1.hotspot.internet-for-guests.com>
References: <20180929033615.4257-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180929033615.4257-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] intel_iommu: better handling of
 dmar state switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>

Hi, Michael,

Just a kind reminder that this series has got enough ACKs and please
consider to merge it in your next pull.  Thanks!

On Sat, Sep 29, 2018 at 11:36:13AM +0800, Peter Xu wrote:
> v4:
> - add a patch to introduce vtd_reset_caches()
> - reset the caches in the two places where GCMD update happens [Eric]
> 
> Please review, thanks.
> 
> Peter Xu (2):
>   intel_iommu: introduce vtd_reset_caches()
>   intel_iommu: better handling of dmar state switch
> 
>  hw/i386/intel_iommu.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
