Received: from eggs.gnu.org ([2001:4830:134:3::10]:37250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePnHN-0000x4-Mw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePnHK-0003xP-7i
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:31:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:29790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ePnHJ-0003vx-Tc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:31:42 -0500
Message-ID: <5A33A509.1000105@intel.com>
Date: Fri, 15 Dec 2017 18:33:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<5A3211CC.60607@intel.com>
	<20171214180449.GU14433@stefanha-x1.localdomain>
In-Reply-To: <20171214180449.GU14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On 12/15/2017 02:04 AM, Stefan Hajnoczi wrote:
> On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
>> 3rd one: I'm not able to solve this one, as discussed, there are too many
>> differences and it's too complex. I prefer the direction of simply gating
>> the vhost-user protocol and deliver to the guest what it should see (just
>> what this patch series shows). You would need to solve this issue to show
>> this direction is simpler :)
> At the moment the main issue deciding what to do seems to be that we
> have no patches for the approach I've described.  I'll begin working on
> a patch series.


Are you planning to implement the multiple masters and slaves?
Master-->QemuSlave1-->GuestSlave
Master<--QemuSlave2<--GuestSlave



> If there is something else you think I could help with, please let me
> know.  I'd like to contribute to vhost-pci.
>

Thanks.

Best,
Wei
