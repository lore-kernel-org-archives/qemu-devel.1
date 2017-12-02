Received: from eggs.gnu.org ([2001:4830:134:3::10]:54250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eL65H-0006S4-OC
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 06:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eL65D-00080O-5N
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 06:35:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eL65C-0007yh-U0
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 06:35:47 -0500
Date: Sat, 2 Dec 2017 11:35:41 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171202113541.GU2787@redhat.com>
References: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
	<20171201151538.6844-2-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201151538.6844-2-farman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] vhost-scsi: add missing virtqueue_size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>, Felipe Franciosi <felipe@nutanix.com>, qemu-devel@nongnu.org

On Fri, Dec 01, 2017 at 04:15:38PM +0100, Eric Farman wrote:
> Commit 5c0919d02066 ("virtio-scsi: Add virtqueue_size parameter allowing
> virtqueue size to be set.") introduced a new parameter to virtio-scsi.
> Later, commit 920036106044 ("vhost-user-scsi: add missing virtqueue_size
> param") added that parameter to the new vhost-user-scsi interface but
> neglected the existing vhost-scsi interface it was built on.
> 
> Apply the same change to vhost-scsi, so that we can boot a guest with
> a device defined.  This also avoids crashing a guest when hotplugging
> a vhost-scsi device.
> 
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  hw/scsi/vhost-scsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index cd4ab05233..9c1bea8ff3 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -233,6 +233,8 @@ static Property vhost_scsi_properties[] = {
>      DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
>      DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
> +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
> +                       128),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                         0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),

Yes, this fix is fine.  Sorry for breaking it :-/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
