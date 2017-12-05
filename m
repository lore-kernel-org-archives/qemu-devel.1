Received: from eggs.gnu.org ([2001:4830:134:3::10]:54059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eM7Er-000845-Ab
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eM7Em-0006fb-Gz
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:01:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eM7Em-0006fD-Ao
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:01:52 -0500
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com>
Date: Tue, 5 Dec 2017 15:01:25 +0800
MIME-Version: 1.0
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
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



On 2017=E5=B9=B412=E6=9C=8805=E6=97=A5 11:33, Wei Wang wrote:
> Vhost-pci is a point-to-point based inter-VM communication solution. Th=
is
> patch series implements the vhost-pci-net device setup and emulation. T=
he
> device is implemented as a virtio device, and it is set up via the
> vhost-user protocol to get the neessary info (e.g the memory info of th=
e
> remote VM, vring info).
>
> Currently, only the fundamental functions are implemented. More feature=
s,
> such as MQ and live migration, will be updated in the future.
>
> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>
> v2->v3 changes:
> 1) static device creation: instead of creating and hot-plugging the
>     device when receiving a vhost-user msg, the device is not created
>     via the qemu booting command line.
> 2) remove vqs: rq and ctrlq are removed in this version.
>      - receive vq: the receive vq is not needed anymore. The PMD direct=
ly
>                    shares the remote txq and rxq - grab from remote txq=
 to
>                    receive packets, and put to rxq to send packets.
>      - ctrlq: the ctrlq is replaced by the first 4KB metadata area of t=
he
>               device Bar-2.
> 3) simpler implementation: the entire implementation has been tailored
>     from ~1800 LOC to ~850 LOC.

Hi:

Any performance numbers you can share?

Thanks
