Received: from eggs.gnu.org ([2001:4830:134:3::10]:56272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gWOHo-00042N-Bs
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gWOHl-0004JQ-7l
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:20:00 -0500
Date: Mon, 10 Dec 2018 17:19:34 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181210161934.5zmat6tjtx4utmzh@kamzik.brq.redhat.com>
References: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
	<1544095560-70807-6-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544095560-70807-6-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH]  pvpanic : update pvpanic document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Thu, Dec 06, 2018 at 07:26:00PM +0800, Peng Hao wrote:
> Add mmio mode as a pci device support info in docs/specs/pvpanic.txt.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  docs/specs/pvpanic.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
> index c7bbacc..6d62d72 100644
> --- a/docs/specs/pvpanic.txt
> +++ b/docs/specs/pvpanic.txt
> @@ -1,7 +1,7 @@
>  PVPANIC DEVICE
>  ==============
>  
> -pvpanic device is a simulated ISA device, through which a guest panic
> +pvpanic device is a simulated device, through which a guest panic
>  event is sent to qemu, and a QMP event is generated. This allows
>  management apps (e.g. libvirt) to be notified and respond to the event.
>  
> @@ -9,6 +9,10 @@ The management app has the option of waiting for GUEST_PANICKED events,
>  and/or polling for guest-panicked RunState, to learn when the pvpanic
>  device has fired a panic event.
>  
> +The pvpanic device can be implemented as an ISA device (using IOPORT),
> +or, since qemu 4.0, as a PCI device (using MMIO address space of pci
> +device).

I'd drop the part in (). Just end with 'as a PCI device.' The MMIO stuff
is described below in the "PCI Interface" section.

> +
>  ISA Interface
>  -------------
>  
> @@ -19,6 +23,13 @@ Software should set only bits both itself and the device recognize.
>  Currently, only bit 0 is recognized, setting it indicates a guest panic
>  has happened.
>  
> +PCI Interface
> +-------------
> +
> +The PCI interface is similar to the ISA interface except that it uses
> +MMIO.

uses an MMIO address space provided by its BAR0.

Should describe that the MMIO address is two bytes in size here as well.


> For example, the arm virt machine could enable pvpanic-pci device 
> +according to adding "-device pvpanic-pci" in qemu command.

For example, the arm virt machine may enable a pvpanic device by
adding '-device pvpanic-pci' to the command line.

> +
>  ACPI Interface
>  --------------
>  
> -- 
> 1.8.3.1
> 
>

Thanks,
drew 
