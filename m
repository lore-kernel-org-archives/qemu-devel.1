Received: from eggs.gnu.org ([2001:4830:134:3::10]:37158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eRZz4-0007OJ-JL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eRZz1-0007Wg-82
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:44:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eRZz1-0007WD-1Z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:44:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5CB27E421
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:44:09 +0000 (UTC)
References: <20171208042654.10910-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <23ebae4e-c6eb-020a-9f6f-647a46a87871@redhat.com>
Date: Wed, 20 Dec 2017 16:43:54 +0800
MIME-Version: 1.0
In-Reply-To: <20171208042654.10910-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] vtd: tiny fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>



On 2017=E5=B9=B412=E6=9C=8808=E6=97=A5 12:26, Peter Xu wrote:
> Please review.  Thanks,
>
> Peter Xu (2):
>    intel_iommu: remove X86_IOMMU_PCI_DEVFN_MAX
>    intel_iommu: fix error param in string
>
>   hw/i386/intel_iommu.c       | 12 ++++++------
>   include/hw/i386/x86-iommu.h |  1 -
>   2 files changed, 6 insertions(+), 7 deletions(-)
>

Reviewed-by: Jason Wang <jasowang@redhat.com>
