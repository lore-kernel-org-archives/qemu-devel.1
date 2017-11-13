Received: from eggs.gnu.org ([2001:4830:134:3::10]:33026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEB00-0006GT-Lx
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEAzx-0000az-GR
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEAzx-0000aM-9V
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAD413A251
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:25:43 +0000 (UTC)
Date: Mon, 13 Nov 2017 10:25:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113092540.fw4euqchyd364ffy@sirius.home.kraxel.org>
References: <20171113084558.28369-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113084558.28369-1-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-pci: Don't force Subsystem
 Vendor ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com, vrozenfe@redhat.com, mst@redhat.com

On Mon, Nov 13, 2017 at 09:45:58AM +0100, Ladi Prosek wrote:
> The statement being removed doesn't change anything as virtio PCI devices already
> have Subsystem Vendor ID set to pci_default_sub_vendor_id (0x1af4), same as Vendor
> ID. And the Virtio spec does not require the two to be equal, either:
> 
>   "The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect the PCI
>   Vendor and Device ID of the environment (for informational purposes by the driver)."
> 
> Background:
> 
> Following the recent virtio-win licensing change, several vendors are planning to
> ship their own certified version of Windows guest Virtio drivers, potentially taking
> advantage of Windows Update as a distribution channel. It is therefore critical that
> each vendor uses their own PCI Subsystem Vendor ID for Virtio devices to prevent
> drivers from other vendors binding to it.
> 
> This would be trivially done by adding:
> 
>   k->subsystem_vendor_id = ...
> 
> to virtio_pci_class_init(). Except for the problematic statement deleted by this
> patch, which reverts the Subsystem Vendor ID back to 0x1af4 for legacy devices for
> no good reason.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
