Received: from eggs.gnu.org ([2001:4830:134:3::10]:43063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fn2pR-000171-N4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fn2pN-0002NR-OJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:19:17 -0400
References: <20180725143413.9728-1-geert+renesas@glider.be>
	<20180725143413.9728-4-geert+renesas@glider.be>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2d36dfa2-744b-1570-d2c2-51352ce98e23@redhat.com>
Date: Tue, 7 Aug 2018 16:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180725143413.9728-4-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/arm/virt: Allow dynamic sysbus
 devices again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

On 07/25/2018 04:34 PM, Geert Uytterhoeven wrote:
> Allow the instantation of generic dynamic sysbus devices again, without
> the need to create a new device-specific vfio type.
The patch title and commit message need to be updated as we allow the
dynamic instantiation of VFIO PLATFORM devices.

Thanks

Eric
> 
> This is more or less a partial revert of commit 6f2062b9758ebc64
> ("hw/arm/virt: Allow only supported dynamic sysbus devices").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Drop RFC state,
> 
> v2:
>   - Restrict from TYPE_SYS_BUS_DEVICE to TYPE_VFIO_PLATFORM, as
>     suggested by Eric Auger.
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 281ddcdf6e26236d..24c1d8e28c7c4285 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1724,6 +1724,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
>      mc->block_default_type = IF_VIRTIO;
>      mc->no_cdrom = 1;
>      mc->pci_allow_0_address = true;
> 
