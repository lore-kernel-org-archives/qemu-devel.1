Received: from eggs.gnu.org ([2001:4830:134:3::10]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4aD-00022v-Kh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4aA-0003p5-Io
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dX4aA-0003oR-Ca
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:52:58 -0400
Date: Mon, 17 Jul 2017 13:52:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170717135251.7e885510@gondolin>
In-Reply-To: <20170717081152.17153-3-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-3-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] virtio: introduce virtqueue_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Mon, 17 Jul 2017 10:11:45 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> Most virtio error output pertains to a specific virtqueue so it makes

s/pertains/pertain/

> sense to include the queue index in error messages.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio.c         | 44 +++++++++++++++++++++++++++++++++-----------
>  include/hw/virtio/virtio.h |  1 +
>  2 files changed, 34 insertions(+), 11 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
