Received: from eggs.gnu.org ([2001:4830:134:3::10]:50261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gKgOT-0003n4-ME
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gKgON-0001Q6-Tk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:14:28 -0500
Date: Thu, 8 Nov 2018 10:14:03 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181108091403.tqablmur67foxmnn@kamzik.brq.redhat.com>
References: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V5 0/5]  add pvpanic mmio support
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

On Sun, Oct 28, 2018 at 02:07:25AM +0800, Peng Hao wrote:
> The first patches are simple cleanups:
> - patch 1 move the pvpanic device with the 'ocmmon objects' so we compile
>   it once for the x86/arm/aarch64 archs,
> - patch 2 simply renames ISA fields/definitions to generic ones.
> 
> Then instead of add/use the MMIO pvpanic device in the virt machine in an
> unique patch, I split it in two distinct patches:
> - patch 3 uses Peng Hao's work, but add the MMIO interface to the existing
>   device (no logical change).
> - patch 4 is Peng Hao's work in the virt machine (no logical change).
> - patch 5 add pvpanic device in acpi table in virt machine
> v2 from Peng Hao is:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html
> 
> v3 --> v4
>   patch 1,2 no modification.
>   patch 3, add TYPE_PANIC_MMIO for distinguishing different bus device,
>            virt + isa_pvpanic will abnormally terminate virtual machine. 
>   patch 4, "pvpanic,mmio" --> "qemu,pvpanic-mmio".
>   patch 5, newly added.
> 
> v4 --> v5
>   patch 1,2 no modification.
>   patch 3 delete PvpanicCommonState structure.
>   patch 4 VIRT_PVPANIC_MMIO --> VIRT_PVPANIC
>           correct VIRT_PVPANIC's overlap start address
>   patch 5 no modification.

This cover letter is missing a pointer to the Linux kernel patches that
enable the pvpanic driver to use the MMIO interface. If that hasn't been
done yet, then how has this series been tested?

Thanks,
drew
