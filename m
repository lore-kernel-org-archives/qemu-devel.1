Received: from eggs.gnu.org ([2001:4830:134:3::10]:46425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVUCK-0007R4-1H
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVUCG-0004at-2s
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:17:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVUCF-0004al-TQ
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:17:28 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<b3b2f711-c120-ec0e-689e-68bdeaa05392@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eb485cba-55f3-62e9-67c9-7040be15b72e@redhat.com>
Date: Mon, 23 Jan 2017 10:17:19 +0800
MIME-Version: 1.0
In-Reply-To: <b3b2f711-c120-ec0e-689e-68bdeaa05392@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 18/20] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8823=E6=97=A5 10:01, Jason Wang wrote:
> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>> This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
>> upstream:
>>
>>    "IOMMU: enable intel_iommu map and unmap notifiers"
>> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
>>
>> However I removed/fixed some content, and added my own codes.
>>
>> Instead of translate() every page for iotlb invalidations (which is
>> slower), we walk the pages when needed and notify in a hook function.
>>
>> This patch enables vfio devices for VT-d emulation.
>>
>> Signed-off-by: Peter Xu<peterx@redhat.com>
>> ---
>>   hw/i386/intel_iommu.c         | 66=20
>> +++++++++++++++++++++++++++++++++++++------
>>   include/hw/i386/intel_iommu.h |  8 ++++++
>>   2 files changed, 65 insertions(+), 9 deletions(-)
>
> A good side effect of this patch is that it makes vhost device IOTLB=20
> works without ATS (though may be slow). We probably need a better=20
> title :)

Probably something like "remote IOMMU/IOTLB" support.

Thanks
