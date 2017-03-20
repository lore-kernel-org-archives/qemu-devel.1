Received: from eggs.gnu.org ([2001:4830:134:3::10]:32779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cpz7l-0001w6-9W
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cpz7h-0001tU-7k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cpz7h-0001tA-1v
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:21:29 -0400
References: <20170317215725.GJ996@jhogan-linux.le.imgtec.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <6b3ec98b-55e2-ecc8-d962-dc9d13866319@redhat.com>
Date: Mon, 20 Mar 2017 17:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170317215725.GJ996@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [BUG] virtio-net linux driver fails to probe on
 MIPS Malta since 'hw/virtio-pci: fix virtio behaviour'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org

On 03/17/2017 11:57 PM, James Hogan wrote:
> Hi,
>
> I've bisected the following failure of the virtio_net linux v4.10 driver
> to probe in QEMU v2.9.0-rc1 emulating a MIPS Malta machine:
>
> virtio_net virtio0: virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
> virtio_net: probe of virtio0 failed with error -22
>
> To QEMU commit 9a4c0e220d8a ("hw/virtio-pci: fix virtio behaviour").
>
> It appears that adding ",disable-modern=on,disable-legacy=off" to the
> virtio-net -device makes it work again.
>
> I presume this should really just work out of the box. Any ideas why it
> isn't?
>

Hi,


This is strange. This commit changes virtio devices from legacy to virtio "transitional".
(your command line changes it to legacy)
Linux 4.10 supports virtio modern/transitional (as far as I know) and on QEMU side
there is nothing new.

Michael, do you have any idea?

Thanks,
Marcel

> Cheers
> James
>
