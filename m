Received: from eggs.gnu.org ([2001:4830:134:3::10]:52343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eOOmL-0003yO-FL
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eOOmF-0008Cj-Il
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:09:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eOOmF-0008C0-D0
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:09:51 -0500
Date: Mon, 11 Dec 2017 16:09:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171211160903-mutt-send-email-mst@kernel.org>
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
	<5A2E8067.4050000@huawei.com>
	<2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

On Mon, Dec 11, 2017 at 02:54:25PM +0100, Halil Pasic wrote:
> * I assume one request is supposed to correspond to one descriptor chain.
> Right? If yes, could you tell me, where is this expressed in the spec.
> 
> Halil

That's always the default for all virtio devices, exceptions have to
be noted in spec.
