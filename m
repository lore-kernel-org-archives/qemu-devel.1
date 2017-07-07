Received: from eggs.gnu.org ([2001:4830:134:3::10]:51660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSxm-0002Wh-Kt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSxj-0000hS-Gi
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:06:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSxj-0000hG-AR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:06:23 -0400
Date: Fri, 7 Jul 2017 15:06:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170707150617.0f19e6a5@dhcp-192-215.str.redhat.com>
In-Reply-To: <2e3bc24b-2244-1cb7-4276-73b1126d6973@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-4-git-send-email-thuth@redhat.com>
	<20170707145402.30187319@dhcp-192-215.str.redhat.com>
	<2e3bc24b-2244-1cb7-4276-73b1126d6973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/8] pc-bios/s390-ccw: Move
 virtio-block related functions into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri, 7 Jul 2017 15:04:55 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 07.07.2017 14:54, Cornelia Huck wrote:
> > On Fri,  7 Jul 2017 12:26:59 +0200
> > Thomas Huth <thuth@redhat.com> wrote:

> >> +void virtio_assume_scsi(void)
> >> +{
> >> +    VDev *vdev = virtio_get_device();
> >> +
> >> +    switch (vdev->senseid.cu_model) {
> >> +    case VIRTIO_ID_BLOCK:
> >> +        vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
> >> +        vdev->config.blk.blk_size = VIRTIO_SCSI_BLOCK_SIZE;
> >> +        vdev->config.blk.physical_block_exp = 0;
> >> +        vdev->blk_factor = 1;
> >> +        break;
> >> +    case VIRTIO_ID_SCSI:
> >> +        vdev->scsi_block_size = VIRTIO_SCSI_BLOCK_SIZE;  
> > 
> > More scsi. Maybe the file just needs a different name :)  
> 
> Do you have a better suggestion?

virtio-blockdev.c ?
