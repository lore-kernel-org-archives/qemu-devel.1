Received: from eggs.gnu.org ([2001:4830:134:3::10]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eEb6a-0003Ap-B5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eEb6W-0000d9-8P
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:18:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eEb6W-0000cm-24
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:18:16 -0500
Date: Tue, 14 Nov 2017 13:18:07 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171114131807.GV2787@redhat.com>
References: <1510676916-76409-1-git-send-email-dariuszx.stojaczyk@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510676916-76409-1-git-send-email-dariuszx.stojaczyk@intel.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: add missing
 virtqueue_size param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Tue, Nov 14, 2017 at 05:28:36PM +0100, Dariusz Stojaczyk wrote:
> Commit 5c0919d0 [1] introduced virtqueue_size parameter
> for common virtio-scsi path, without updaing the vhost-user-scsi
> code. vhost-user-scsi devices right now report size 0 for each vq.
> 
> This patch introduces virtqueue_size param to vhost-user-scsi,
> that can now be set by the user. However, the most importantly, it
> now has a default value of 128 (same as QEMU's virtio-scsi).
> 
> [1] 5c0919d0 ("virtio-scsi: Add virtqueue_size parameter
> allowing virtqueue size to be set.")
> 
> Change-Id: I70e87eab702ebf1196c028dbf17d54fdc0c89a14
> Signed-off-by: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>
> ---
>  hw/scsi/vhost-user-scsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 500fa6a..f7561e2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -135,6 +135,8 @@ static Property vhost_user_scsi_properties[] = {
>      DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
>      DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
> +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
> +                       128),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                         0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),

Looks good to me.

However I don't really know the code well enough to say if there
could be other problems.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
