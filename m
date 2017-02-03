Received: from eggs.gnu.org ([2001:4830:134:3::10]:46604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZiJu-0007aj-Jz
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cZiJr-0003pa-Dx
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:10:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cZiJr-0003pK-7Y
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:10:47 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F4C265727
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 18:10:47 +0000 (UTC)
Date: Fri, 3 Feb 2017 11:10:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170203111045.4367eb34@t450s.home>
In-Reply-To: <1485244958-25911-1-git-send-email-thuth@redhat.com>
References: <1485244958-25911-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/vfio/pci-quirks: Set category of the
 "vfio-pci-igd-lpc-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 24 Jan 2017 09:02:38 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The device has "bridge" in its name, so it should obviously be in
> the category DEVICE_CATEGORY_BRIDGE.

Well, physical device is a bridge, but this is really just a stub.
Does that count?  It doesn't create a subordinate bus that can actually
host devices.  Thanks,

Alex

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/vfio/pci-quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 811eecd..4891b37 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1185,6 +1185,7 @@ static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->desc = "VFIO dummy ISA/LPC bridge for IGD assignment";
>      dc->hotpluggable = false;
>      k->realize = vfio_pci_igd_lpc_bridge_realize;
