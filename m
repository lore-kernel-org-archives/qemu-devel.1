Received: from eggs.gnu.org ([2001:4830:134:3::10]:33085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfQr-0007mx-Eq
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfQo-0008HK-9N
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:49:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVfQo-0008Gv-3B
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:49:30 -0400
Date: Thu, 13 Jul 2017 16:49:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713164920.10b40b92@gondolin>
In-Reply-To: <20170713110237.6712-5-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-5-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] virtio-9p: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

On Thu, 13 Jul 2017 13:02:33 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> virtqueue_error includes queue index in the error output and is preferred

s/includes queue index/includes the queue index/

(also the other patches in this series)

> for errors that pertain to a virtqueue rather than to the device as a whole.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/9pfs/virtio-9p-device.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
