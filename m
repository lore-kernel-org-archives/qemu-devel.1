Received: from eggs.gnu.org ([2001:4830:134:3::10]:59522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNH3r-0007xV-To
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNH3n-0000Zp-2c
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:43:23 -0500
Date: Fri, 8 Dec 2017 12:43:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171208124313.0ceb6465.cohuck@redhat.com>
In-Reply-To: <20171128134648.21530-2-cohuck@redhat.com>
References: <20171128134648.21530-1-cohuck@redhat.com>
	<20171128134648.21530-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] s390x/css: attach css bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Tue, 28 Nov 2017 14:46:47 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Logically, the css bridge should be attached to the machine.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/css-bridge.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index c4a9735d71..84d33eafc2 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -99,6 +99,8 @@ VirtualCssBus *virtual_css_bus_init(void)
>  
>      /* Create bridge device */
>      dev = qdev_create(NULL, TYPE_VIRTUAL_CSS_BRIDGE);
> +    object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
> +                              OBJECT(dev), NULL);
>      qdev_init_nofail(dev);
>  
>      /* Create bus on bridge device */

Queued to s390-next.
