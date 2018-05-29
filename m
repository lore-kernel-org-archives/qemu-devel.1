Received: from eggs.gnu.org ([2001:4830:134:3::10]:52452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNgTy-0001Sc-Ma
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNgTv-0007Mm-53
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:24:18 -0400
Date: Tue, 29 May 2018 09:24:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180529092408.2803fe05@w520.home>
In-Reply-To: <20180529151753.22912.14813.stgit@gimli.home>
References: <20180529151753.22912.14813.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Default display option to "off"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Erik Skultety <eskultet@redhat.com>, libvir-list@redhat.com

[Cc +Erik,libvirt]

Sorry, should have cc'd libvirt with this initially since display
support is under development.  I think "off" is the better
compatibility option, but perhaps the damage is done since it was the
2.12 default.  Thanks,

Alex

On Tue, 29 May 2018 09:18:10 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Commit a9994687cb9b ("vfio/display: core & wireup") added display
> support to vfio-pci with the default being "auto", which breaks
> existing VMs when the vGPU requires GL support but had no previous
> requirement for a GL compatible configuration.  "Off" is the safer
> default as we impose no new requirements to VM configurations.
> 
> Fixes: a9994687cb9b ("vfio/display: core & wireup")
> Cc: qemu-stable@nongnu.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 84e27c7bb2d1..18c493b49ec1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3160,7 +3160,7 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
>      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> -                            display, ON_OFF_AUTO_AUTO),
> +                            display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                         intx.mmap_timeout, 1100),
>      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> 
