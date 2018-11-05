Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1gJepA-0003Fl-Oc
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1gJep7-0001vk-JL
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:21:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1gJep0-0001PR-R0
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:21:41 -0500
Message-ID: <4222cd0b956ac767f74b56a32772d190d1b84b51.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Mon, 05 Nov 2018 15:21:21 +0200
In-Reply-To: <20181102191538.7532-1-v.mayatskih@gmail.com>
References: <20181102191538.7532-1-v.mayatskih@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Fri, 2018-11-02 at 19:15 +0000, Vitaly Mayatskikh wrote:
> This driver uses the kernel-mode acceleration for virtio-blk and
> allows to get a near bare metal disk performance inside a VM.
> 
> Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
> ---
>  configure                  | 10 +++++++
>  default-configs/virtio.mak |  1 +
>  hw/block/Makefile.objs     |  1 +
>  hw/virtio/virtio-pci.c     | 60 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.h     | 19 ++++++++++++
>  5 files changed, 91 insertions(+)
> 

I think that you haven't sent all the files because at least some of the files
are missing.
For example the build fails with missing 'hw/virtio/vhost-blk.h'

Also I don't see here any mention on how the qemu passes to the in-kernel
driver, the file which the in-kernel driver is supposed to read/write.
I don't think that generic vhost backend have this functionality because till
now it was limited to iscsi, and thus qemu just passed to the kernel, the wwpn
of the device.

Best regards,
       Maxim Levitsky
