Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g9LxH-0005Bf-VP
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g9LxD-00032s-IP
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1g9LxA-00030g-Cz
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:11:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B068C8666F
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 03:11:25 +0000 (UTC)
References: <20180929033615.4257-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b853bd8-7ca8-3db9-3824-2b52ed02e622@redhat.com>
Date: Mon, 8 Oct 2018 11:11:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180929033615.4257-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>



On 2018=E5=B9=B409=E6=9C=8829=E6=97=A5 11:36, Peter Xu wrote:
> v4:
> - add a patch to introduce vtd_reset_caches()
> - reset the caches in the two places where GCMD update happens [Eric]
>
> Please review, thanks.
>
> Peter Xu (2):
>    intel_iommu: introduce vtd_reset_caches()
>    intel_iommu: better handling of dmar state switch
>
>   hw/i386/intel_iommu.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
>

Reviewed-by: Jason Wang <jasowang@redhat.com>
