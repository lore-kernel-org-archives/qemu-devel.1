Received: from eggs.gnu.org ([2001:4830:134:3::10]:54951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNCC-00061b-QZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNCC-0002DK-37
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:09:28 -0500
References: <1543262162-6351-1-git-send-email-peng.hao2@zte.com.cn>
	<1543262162-6351-10-git-send-email-peng.hao2@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48580284-d439-456b-2c6a-a10c0a9280ea@redhat.com>
Date: Mon, 26 Nov 2018 14:09:10 -0600
MIME-Version: 1.0
In-Reply-To: <1543262162-6351-10-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 9/9] pvpanic : update pvpanic document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 11/26/18 1:56 PM, Peng Hao wrote:
> Add mmio support info in docs/specs/pvpanic.txt.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>   docs/specs/pvpanic.txt | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
> index c7bbacc..67f5591 100644
> --- a/docs/specs/pvpanic.txt
> +++ b/docs/specs/pvpanic.txt
> @@ -1,14 +1,18 @@
>   PVPANIC DEVICE
>   ==============
>   
> -pvpanic device is a simulated ISA device, through which a guest panic
> -event is sent to qemu, and a QMP event is generated. This allows
> +pvpanic device is a simulated ISA/SysBus device, through which a guest
> +panic event is sent to qemu, and a QMP event is generated. This allows
>   management apps (e.g. libvirt) to be notified and respond to the event.
>   
>   The management app has the option of waiting for GUEST_PANICKED events,
>   and/or polling for guest-panicked RunState, to learn when the pvpanic
>   device has fired a panic event.
>   
> +When pvpanic device is implemented as a ISA device, it supports IOPORT
> +mode. Since QEMU v3.2 pvpanic also supports MMIO mode, it will be

The next qemu release will be 4.0, not 3.2.

> +implemented as a SYSBUS device.

Grammar suggestion:

The pvpanic device can be implemented as an ISA device (using IOPORT), 
or, since qemu 4.0, as a SYSBUS device (using MMIO).

> +
>   ISA Interface
>   -------------
>   
> @@ -19,6 +23,13 @@ Software should set only bits both itself and the device recognize.
>   Currently, only bit 0 is recognized, setting it indicates a guest panic
>   has happened.
>   
> +SYSBUS Interface
> +----------------
> +
> +The SYSBUS interface is similar to the ISA interface except that it uses
> +MMIO. For example, the arm virt machine could put the pvpanic device at
> +[0x9070000, 0x9070001] and currently only the first byte is used.
> +
>   ACPI Interface
>   --------------
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
