Received: from eggs.gnu.org ([2001:4830:134:3::10]:39349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSlEk-0005u4-8c
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSlEe-00050a-Md
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:01:48 -0500
Date: Fri, 30 Nov 2018 17:00:57 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181130160057.i2ucjyprf5t3vs5l@kamzik.brq.redhat.com>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-10-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543407172-16175-10-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V10 9/9] pvpanic : update pvpanic document
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

On Wed, Nov 28, 2018 at 08:12:52PM +0800, Peng Hao wrote:
> Add mmio support info in docs/specs/pvpanic.txt.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  docs/specs/pvpanic.txt | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
> index c7bbacc..b1beea3 100644
> --- a/docs/specs/pvpanic.txt
> +++ b/docs/specs/pvpanic.txt
> @@ -1,14 +1,17 @@
>  PVPANIC DEVICE
>  ==============
>  
> -pvpanic device is a simulated ISA device, through which a guest panic
> -event is sent to qemu, and a QMP event is generated. This allows
> +pvpanic device is a simulated ISA/SYSBUS device, through which a guest

Why add the ISA/SYSBUS here? It's not really the best use of '/', IMO,
I'd just drop that as the ISA and SYSBUS is pointed out later.

> +panic event is sent to qemu, and a QMP event is generated. This allows
>  management apps (e.g. libvirt) to be notified and respond to the event.
>  
>  The management app has the option of waiting for GUEST_PANICKED events,
>  and/or polling for guest-panicked RunState, to learn when the pvpanic
>  device has fired a panic event.
>  
> +The pvpanic device can be implemented as an ISA device (using IOPORT), 
> +or, since qemu 4.0, as a SYSBUS device (using MMIO).
> +
>  ISA Interface
>  -------------
>  
> @@ -19,6 +22,13 @@ Software should set only bits both itself and the device recognize.
>  Currently, only bit 0 is recognized, setting it indicates a guest panic
>  has happened.
>  
> +SYSBUS Interface
> +----------------
> +
> +The SYSBUS interface is similar to the ISA interface except that it uses
> +MMIO. For example, the arm virt machine could put the pvpanic device at
> +[0x9070000, 0x9070001] and currently only the first byte is used.

instead of '] and currently'. I'd write '], where currently'

> +
>  ACPI Interface
>  --------------
>  
> -- 
> 1.8.3.1
> 
> 

Otherwise 

Reviewed-by: Andrew Jones <drjones@redhat.com>
