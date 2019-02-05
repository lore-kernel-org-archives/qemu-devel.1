Received: from eggs.gnu.org ([209.51.188.92]:56661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gr2V9-0004Dd-1I
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gr2V3-0007gr-6z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:19:06 -0500
Date: Tue, 5 Feb 2019 16:18:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190205161815.1182dc5c@Igors-MacBook-Pro.local>
In-Reply-To: <20190131112240.8395-1-peter.maydell@linaro.org>
References: <20190131112240.8395-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] hw/arm/boot: Support DTB autoload for
 firmware-only boots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Hongbo Zhang <hongbo.zhang@linaro.org>, patches@linaro.org

On Thu, 31 Jan 2019 11:22:35 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The arm_boot_info struct has a skip_dtb_autoload flag: if this is
> set to true by the board code then arm_load_kernel() will not
> load the DTB itself, but will leave this for the board code to
> do itself later. However, the check for this is done in a
> code path which is only executed for the case where we load
> a kernel image file. If we're taking the "boot via firmware"
> code path then the flag isn't honoured and the DTB is never
> loaded.
>     
> We didn't notice this because the only real user of "boot
> via firmware" that cares about the DTB is the virt board
> (for UEFI boot), and that always wants skip_dtb_autoload
> anyway. But the SBSA reference board model we're planning to
> add will want the flag to behave correctly.
> 
> The first four patches in this set are just refactoring,
> splitting the code in arm_load_kernel() out into a
> couple of sub-functions for "direct kernel boot" and
> "firmware boot". The last patch that fixes the issue is
> then just a one-liner. (Without the refactoring we'd
> need to use a goto, which is what I wanted to avoid.)
> 
> thanks
> -- PMM
> 
> Peter Maydell (5):
>   hw/arm/boot: Fix block comment style in arm_load_kernel()
>   hw/arm/boot: Factor out "direct kernel boot" code into its own
>     function
>   hw/arm/boot: Factor out "set up firmware boot" code
>   hw/arm/boot: Clarify why arm_setup_firmware_boot() doesn't set
>     env->boot_info
>   hw/arm/boot: Support DTB autoload for firmware-only boots
> 
>  hw/arm/boot.c | 166 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 96 insertions(+), 70 deletions(-)
> 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
