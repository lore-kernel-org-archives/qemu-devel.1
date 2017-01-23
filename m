Received: from eggs.gnu.org ([2001:4830:134:3::10]:45610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVbqx-00012i-9J
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVbqt-0005VU-TH
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:27:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVbqt-0005VD-Ms
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:27:55 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<b3b2f711-c120-ec0e-689e-68bdeaa05392@redhat.com>
	<20170123034000.GH26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <596bad31-eba5-973d-fcf3-194c3a3a7c7c@redhat.com>
Date: Mon, 23 Jan 2017 18:27:46 +0800
MIME-Version: 1.0
In-Reply-To: <20170123034000.GH26526@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8823=E6=97=A5 11:40, Peter Xu wrote:
> On Mon, Jan 23, 2017 at 10:01:11AM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>>> This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
>>> upstream:
>>>
>>>    "IOMMU: enable intel_iommu map and unmap notifiers"
>>>    https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.htm=
l
>>>
>>> However I removed/fixed some content, and added my own codes.
>>>
>>> Instead of translate() every page for iotlb invalidations (which is
>>> slower), we walk the pages when needed and notify in a hook function.
>>>
>>> This patch enables vfio devices for VT-d emulation.
>>>
>>> Signed-off-by: Peter Xu<peterx@redhat.com>
>>> ---
>>>   hw/i386/intel_iommu.c         | 66 ++++++++++++++++++++++++++++++++=
+++++------
>>>   include/hw/i386/intel_iommu.h |  8 ++++++
>>>   2 files changed, 65 insertions(+), 9 deletions(-)
>> A good side effect of this patch is that it makes vhost device IOTLB w=
orks
>> without ATS (though may be slow). We probably need a better title :)
> How about I mention it in the commit message at the end? Like:
>
> "And, since we already have vhost DMAR support via device-iotlb, a
>   natural benefit that this patch brings is that vt-d enabled vhost can
>   live even without ATS capability now. Though more tests are needed."
>

Ok for me.

>> And I think we should block notifiers during PSI/DSI/GLOBAL for device=
 with
>> ATS enabled.
> Again, would that be okay I note this in my todo list? :)
>
> Thanks,
>
> -- peterx

Yes, on top.

Thanks
