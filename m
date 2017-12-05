Received: from eggs.gnu.org ([2001:4830:134:3::10]:33399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eM7Vz-0007Fv-9G
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eM7Vy-0007pn-9U
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:19:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eM7Vy-0007pR-3R
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:19:38 -0500
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com>
	<5A264780.2030808@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <668fc7b0-4a3a-7a3b-e939-7a0d80c03166@redhat.com>
Date: Tue, 5 Dec 2017 15:19:18 +0800
MIME-Version: 1.0
In-Reply-To: <5A264780.2030808@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com



On 2017=E5=B9=B412=E6=9C=8805=E6=97=A5 15:15, Wei Wang wrote:
> On 12/05/2017 03:01 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B412=E6=9C=8805=E6=97=A5 11:33, Wei Wang wrote:
>>> Vhost-pci is a point-to-point based inter-VM communication solution.=20
>>> This
>>> patch series implements the vhost-pci-net device setup and=20
>>> emulation. The
>>> device is implemented as a virtio device, and it is set up via the
>>> vhost-user protocol to get the neessary info (e.g the memory info of=20
>>> the
>>> remote VM, vring info).
>>>
>>> Currently, only the fundamental functions are implemented. More=20
>>> features,
>>> such as MQ and live migration, will be updated in the future.
>>>
>>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist her=
e:
>>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>>>
>>> v2->v3 changes:
>>> 1) static device creation: instead of creating and hot-plugging the
>>> =C2=A0=C2=A0=C2=A0 device when receiving a vhost-user msg, the device=
 is not created
>>> =C2=A0=C2=A0=C2=A0 via the qemu booting command line.
>>> 2) remove vqs: rq and ctrlq are removed in this version.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - receive vq: the receive vq is not needed a=
nymore. The PMD=20
>>> directly
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shares the remote txq and rxq - g=
rab from remote=20
>>> txq to
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receive packets, and put to rxq t=
o send packets.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - ctrlq: the ctrlq is replaced by the first =
4KB metadata area=20
>>> of the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 device Bar-2.
>>> 3) simpler implementation: the entire implementation has been tailore=
d
>>> =C2=A0=C2=A0=C2=A0 from ~1800 LOC to ~850 LOC.
>>
>> Hi:
>>
>> Any performance numbers you can share?
>>
>
> Hi Jason,
>
> Performance testing and tuning on the data plane is in progress (btw,=20
> that wouldn't affect the device part patches).
> If possible, could we start the device part patch review in the meantim=
e?
>
> Best,
> Wei
>

Hi Wei:

Will do, but basically, the cover lacks of the motivation for vhost-pci=20
and I want to see some numbers first since I suspect it can over-perform=20
exist data-path.

Thanks
