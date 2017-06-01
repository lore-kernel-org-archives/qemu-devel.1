Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGLee-0006DK-4p
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dGLeb-0006m6-5U
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:40:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dGLea-0006lK-Vo
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:40:25 -0400
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-7-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3695b34a-9181-4006-0e37-31749dc7e6d6@redhat.com>
Date: Thu, 1 Jun 2017 10:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170529135520.101429-7-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On 29.05.2017 15:55, Halil Pasic wrote:
> Turn on migration for the channel subsystem for the next machine.  For
> legacy machines we still have to do things the old way.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c             | 5 +++++
>  hw/s390x/s390-virtio-ccw.c | 9 ++++-----
>  hw/s390x/virtio-ccw.c      | 1 -
>  include/hw/s390x/css.h     | 4 ++++
>  4 files changed, 13 insertions(+), 6 deletions(-)
[...]
>  static void ccw_machine_2_10_class_options(MachineClass *mc)
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index a75eedeffb..4a0271b0be 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1360,7 +1360,6 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
>  
>      sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
>  
> -
>      css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>                            d->hotplugged, 1);
>  }

Unrelated white-space change?

 Thomas
