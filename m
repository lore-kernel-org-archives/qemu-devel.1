Received: from eggs.gnu.org ([2001:4830:134:3::10]:35186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8O3I-00059x-01
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8O3E-0003He-Ow
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:37:00 -0400
Date: Wed, 10 May 2017 17:36:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170510093651.GA11394@lemon.lan>
References: <20170510092333.8890-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510092333.8890-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] virtio: Unregister memory
 listener when unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 05/10 17:23, Fam Zheng wrote:
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 03592c5..a7741f4 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2515,6 +2515,7 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    memory_listener_unregister(&vdev->listener);
>      g_free(vdev->bus_name);
>      vdev->bus_name = NULL;
>  }
> -- 
> 2.9.3
> 
> 

Oops, I think the one in the .finalize() callback should be removed meanwhile.

Fam
