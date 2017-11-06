Received: from eggs.gnu.org ([2001:4830:134:3::10]:49436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBmfh-0001Xe-OA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBmfg-0000QU-G0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:57 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017164426.25277-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <68421658-f4db-a74f-f577-85d6b6e2ccd9@amsat.org>
Date: Mon, 6 Nov 2017 16:02:42 -0300
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/42] remove i386/pc dependency from
 non-PC world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi Michael,

Since we are now in Soft Freeze, I'll respin this series rebased once
the next merge window opens.

On 10/17/2017 01:43 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> quite a bunch of patches and files modified, but the diffstat is not that big.
> 
> patches missing review: 2 3 16 20 21 33-37 39-41

In the meaning time patches 3 16 20 21 39 can still get some R|A-b :)

Regards,

Phil.

> since v3:
> 
> - addressed Thomas & Paolo comments (thanks for your reviews!)
> - split/fixed MAINTAINERS entries
> - dropped port92 patch
> - dropped i8237* patches
> 
> I couldn't test the KVM/XEN/HAX part (thanks Corey Minyard for v1 testing!).
> 
> since v2:
> - added R-b, A-b
> - added missing MAINTAINERS entries (as separate patches)
> - dma/i82374: avoid multiple creations on the same ISA bus
> - i386/pc: extract port92 from pc.c
> - i386/pc: move vmport.c/pvpanic.c from hw/misc/ to hw/i386/
> 
> v1:
> 
> - clean includes (mostly from script)
> - code movement (about no logical changes)
> 
> Regards,
> 
> Phil.
> 
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/42:[----] [--] 'MAINTAINERS: add entries for i2c/ppc4xx'
> 002/42:[down] 'MAINTAINERS: add an entry for the i82374 (southbridge)'
> 003/42:[down] 'MAINTAINERS: add an entry for the i8257 (DMA controller)'
> 004/42:[----] [--] 'MAINTAINERS: add an entry for the i82378 (superio)'
> 005/42:[----] [-C] 'MAINTAINERS: add an entry for watchdog/wdt_ib700'
> 006/42:[----] [--] 'MAINTAINERS: add an entry for input/pckbd.c'
> 007/42:[----] [--] 'MAINTAINERS: add entries for timer/m48t59'
> 008/42:[----] [--] 'MAINTAINERS: add missing entry for include/hw/net/'
> 009/42:[----] [--] 'hw: use "qemu/osdep.h" as first #include in source files'
> 010/42:[----] [--] 'hw: remove "qemu/osdep.h" from header files'
> 011/42:[----] [--] 'block: remove "qemu/osdep.h" from header file'
> 012/42:[----] [--] 'misc: remove headers implicitly included'
> 013/42:[----] [--] 'misc: remove duplicated includes'
> 014/42:[----] [--] 'ppc: remove duplicated includes'
> 015/42:[----] [--] 'i386/hax: remove duplicated includes'
> 016/42:[0013] [FC] 'i386/hax: remove duplicated include'
> 017/42:[----] [--] 'nios2: remove duplicated includes (in code commented out)'
> 018/42:[----] [--] 'misc: avoid "include/" in include path'
> 019/42:[----] [--] 'numa: remove unused #include'
> 020/42:[down] 'hw/input/vmmouse: remove unused #include'
> 021/42:[down] 'hw/misc/pvpanic: remove unused #include'
> 022/42:[----] [--] 'hw/ssi/aspeed_smc: remove unused #include'
> 023/42:[----] [--] 'amd_iommu: avoid needless includes in header file'
> 024/42:[0001] [FC] 'misc: remove old i386 dependency'
> 025/42:[----] [--] 'hw/ide: remove old i386 dependency'
> 026/42:[----] [--] 'hw/ipmi: remove old i386 dependency'
> 027/42:[----] [--] 'hw/i2c: remove old i386 dependency'
> 028/42:[----] [--] 'hw/tpm: remove old i386 dependency'
> 029/42:[----] [--] 'hw/virtio-balloon: remove old i386 dependency'
> 030/42:[0001] [FC] 'hw/unicore32: restrict hw addr defines to source file'
> 031/42:[----] [--] 'hw/timer/i8254: rename pit_init() -> i8254_pit_init()'
> 032/42:[----] [-C] 'hw/timer/mc146818: rename rtc_init() -> mc146818_rtc_init()'
> 033/42:[0003] [FC] 'hw/acpi: ACPI_PM_* defines are not restricted to i386 arch'
> 034/42:[down] 'hw/acpi/ich9: extract ACPI_PM_PROP_TCO_ENABLED from i386/pc'
> 035/42:[down] 'hw/display/vga: "vga.h" only contains registers defs, rename it "vga_regs.h"'
> 036/42:[down] 'hw/display/vga: "vga_int.h" requires "ui/console.h"'
> 037/42:[down] 'hw/display/vga: extract public API from i386/pc to "hw/display/vga.h"'
> 038/42:[----] [-C] 'hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c'
> 039/42:[down] 'hw/misc/pvpanic: extract public API from i386/pc to "hw/misc/pvpanic.h"'
> 040/42:[down] 'i386/pc: move vmport.c to hw/i386/'
> 041/42:[down] 'i386/pc: move vmmouse.c to hw/i386/'
> 042/42:[----] [--] 'misc: drop old i386 dependency'
[...]
