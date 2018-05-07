Received: from eggs.gnu.org ([2001:4830:134:3::10]:44363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFlhW-0004gD-GB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFlhS-0002BN-I1
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:21:34 -0400
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <405408be-40d8-409a-8596-030483d2a04f@redhat.com>
Date: Mon, 7 May 2018 21:21:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180507155130.21085-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-ccw: common reset handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 07.05.2018 17:51, Cornelia Huck wrote:
> All the different virtio ccw devices use the same reset handler,
> so let's move setting it into the base virtio ccw device class.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
