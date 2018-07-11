Received: from eggs.gnu.org ([2001:4830:134:3::10]:39541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fd5aO-0005sA-SN
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 23:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fd5aL-0000cL-O0
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 23:14:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2554 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhengui@huawei.com>)
	id 1fd5aL-0000ak-7z
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 23:14:33 -0400
References: <20180710155037.16834-1-stefanha@redhat.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <2c0e71e2-454e-3f2c-b560-afc034d6e222@huawei.com>
Date: Wed, 11 Jul 2018 11:13:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180710155037.16834-1-stefanha@redhat.com>
Content-Type: multipart/mixed; boundary="------------D393B9098B4C4B00DB8990A8"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio-scsi: fix hotplug ->reset() vs
 event race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

--------------D393B9098B4C4B00DB8990A8
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I will test your patch soon.


On 2018/7/10 23:50, Stefan Hajnoczi wrote:
> The virtio-scsi command virtqueues run during hotplug.  This creates the
> possibility of race conditions since the guest can submit commands while the
> monitor is performing hotplug.
>
> See Patch 2 for a fix for the ->reset() vs event race condition that Zhengui Li
> encountered.
>
> Zhengui Li: Sorry it took me so long to look into this.  Please let me know if
> this fixes the issue you are seeing.  Thanks!
>
> Stefan Hajnoczi (2):
>    qdev: add HotplugHandler->post_plug() callback
>    virtio-scsi: fix hotplug ->reset() vs event race
>
>   include/hw/hotplug.h  | 12 ++++++++++++
>   hw/core/hotplug.c     | 11 +++++++++++
>   hw/core/qdev.c        |  7 +++++++
>   hw/scsi/virtio-scsi.c | 11 ++++++++++-
>   4 files changed, 40 insertions(+), 1 deletion(-)
>


--------------D393B9098B4C4B00DB8990A8
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------D393B9098B4C4B00DB8990A8--
