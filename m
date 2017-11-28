Received: from eggs.gnu.org ([2001:4830:134:3::10]:59857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJciT-0004ty-ER
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJciK-0007PH-1z
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:02:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJciJ-0007Oj-SD
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:02:03 -0500
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
Date: Tue, 28 Nov 2017 11:01:49 +0100
MIME-Version: 1.0
In-Reply-To: <1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com

On 28/11/2017 10:03, Gonglei wrote:
> Introduce two vhost-user meassges: VHOST_USER_CREATE_CRYPTO_SESSION
> and VHOST_USER_CLOSE_CRYPTO_SESSION. At this point, the QEMU side
> support crypto operation in cryptodev host-user backend.
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> Signed-off-by: Zhoujian <jianjay.zhou@huawei.com>
> ---
>  backends/cryptodev-vhost-user.c   | 50 +++++++++++++++++-----
>  docs/interop/vhost-user.txt       | 19 +++++++++
>  hw/virtio/vhost-user.c            | 89 +++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  8 ++++
>  4 files changed, 155 insertions(+), 11 deletions(-)

As far as I understand, VIRTIO_CRYPTO_CIPHER_CREATE_SESSION is called as
a result of sending a message on the control virtqueue.

Why can't vhost-user also process create/destroy session messages on the
control virtqueue, instead of having device-specific messages in the
protocol?

Thanks,

Paolo
