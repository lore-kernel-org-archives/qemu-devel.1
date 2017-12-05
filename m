Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM7Pq-00043G-Ld
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM7Pm-0004jt-Lf
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:13:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:45755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eM7Pm-0004i9-C1
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:13:14 -0500
Message-ID: <5A264780.2030808@intel.com>
Date: Tue, 05 Dec 2017 15:15:12 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com>
In-Reply-To: <3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com

On 12/05/2017 03:01 PM, Jason Wang wrote:
>
>
> On 2017年12月05日 11:33, Wei Wang wrote:
>> Vhost-pci is a point-to-point based inter-VM communication solution. 
>> This
>> patch series implements the vhost-pci-net device setup and emulation. 
>> The
>> device is implemented as a virtio device, and it is set up via the
>> vhost-user protocol to get the neessary info (e.g the memory info of the
>> remote VM, vring info).
>>
>> Currently, only the fundamental functions are implemented. More 
>> features,
>> such as MQ and live migration, will be updated in the future.
>>
>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>>
>> v2->v3 changes:
>> 1) static device creation: instead of creating and hot-plugging the
>>     device when receiving a vhost-user msg, the device is not created
>>     via the qemu booting command line.
>> 2) remove vqs: rq and ctrlq are removed in this version.
>>      - receive vq: the receive vq is not needed anymore. The PMD 
>> directly
>>                    shares the remote txq and rxq - grab from remote 
>> txq to
>>                    receive packets, and put to rxq to send packets.
>>      - ctrlq: the ctrlq is replaced by the first 4KB metadata area of 
>> the
>>               device Bar-2.
>> 3) simpler implementation: the entire implementation has been tailored
>>     from ~1800 LOC to ~850 LOC.
>
> Hi:
>
> Any performance numbers you can share?
>

Hi Jason,

Performance testing and tuning on the data plane is in progress (btw, 
that wouldn't affect the device part patches).
If possible, could we start the device part patch review in the meantime?

Best,
Wei
