Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dA3jY-0001X1-1b
	for qemu-devel@nongnu.org; Sun, 14 May 2017 20:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dA3jU-0002DJ-R2
	for qemu-devel@nongnu.org; Sun, 14 May 2017 20:19:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:58724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dA3jU-00027L-Gt
	for qemu-devel@nongnu.org; Sun, 14 May 2017 20:19:28 -0400
Message-ID: <5918F483.4000504@intel.com>
Date: Mon, 15 May 2017 08:21:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<1494578148-102868-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-7-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v2 06/16] virtio: add inter-vm
 notification support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 05/12/2017 04:35 PM, Wei Wang wrote:
> This patch enables the assign of an already allocated eventfd to a notifier.
> In this case, QEMU creates a new eventfd for the notifier only when the
> notifier's fd equals to -1. Otherwise, it means that the notifier has been
> assigned a vaild fd.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>
+ Suggested-by Paolo Bonzini <pbonzini@redhat.com>

Best,
Wei
