Received: from eggs.gnu.org ([2001:4830:134:3::10]:50793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cc4cy-0001jg-Ph
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cc4cv-0002tb-Kw
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:24:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cc4cv-0002tP-FG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:24:13 -0500
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-18-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5dc0cbd-9dec-bd37-d809-9d84d50f523d@redhat.com>
Date: Fri, 10 Feb 2017 14:24:02 +0800
MIME-Version: 1.0
In-Reply-To: <1486456099-7345-18-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B402=E6=9C=8807=E6=97=A5 16:28, Peter Xu wrote:
> This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
> upstream:
>
>    "IOMMU: enable intel_iommu map and unmap notifiers"
>    https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
>
> However I removed/fixed some content, and added my own codes.
>
> Instead of translate() every page for iotlb invalidations (which is
> slower), we walk the pages when needed and notify in a hook function.
>
> This patch enables vfio devices for VT-d emulation.
>
> And, since we already have vhost DMAR support via device-iotlb, a
> natural benefit that this patch brings is that vt-d enabled vhost can
> live even without ATS capability now. Though more tests are needed.

Michael, if you want to apply this series, I would propose a better=20
title for this patch e.g "cowork with remote IOMMU/IOTLB"

Thanks

>
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c          | 191 ++++++++++++++++++++++++++++++++=
++++++---
>   hw/i386/intel_iommu_internal.h |   1 +
>   hw/i386/trace-events           |   1 +
>   include/hw/i386/intel_iommu.h  |   8 ++
>   4 files changed, 188 insertions(+), 13 deletions(-)

[...]
