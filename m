Received: from eggs.gnu.org ([2001:4830:134:3::10]:49343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1g6vwD-0002Rl-NL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1g6vw7-0002jr-8B
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:00:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1g6vw5-0002hG-Eu
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:00:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EC6E7F6CE
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 11:00:19 +0000 (UTC)
References: <20180929033615.4257-1-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <dde13a52-7570-478b-3cce-c2b73883f3b4@redhat.com>
Date: Mon, 1 Oct 2018 13:00:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180929033615.4257-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Peter,

On 9/29/18 5:36 AM, Peter Xu wrote:
> v4:
> - add a patch to introduce vtd_reset_caches()
> - reset the caches in the two places where GCMD update happens [Eric]
> 
> Please review, thanks.

For the series

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
> Peter Xu (2):
>   intel_iommu: introduce vtd_reset_caches()
>   intel_iommu: better handling of dmar state switch
> 
>  hw/i386/intel_iommu.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
