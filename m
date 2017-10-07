Received: from eggs.gnu.org ([2001:4830:134:3::10]:47279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cc3-0002Qa-L8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cc2-0006hb-3E
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:05:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5422cc1a-12bd-5a9b-b0f6-fd0015b0f146@amsat.org>
Date: Fri, 6 Oct 2017 21:04:52 -0300
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/88] use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

... and I obviously forgot to paste this...
(useful for Marc-André mostly)

[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively
001/88:[down] 'cocci: script to use g_new() & friends'
002/88:[down] 'cocci: add more g_new() transformations'
003/88:[down] 'cocci: extract typeof() from g_new()'
004/88:[down] 'cocci: avoid use of g_new0()'
005/88:[down] 'cocci: use g_strfreev()'
006/88:[down] 'ARM: use g_new() family of functions'
007/88:[0018] [FC] 'Audio: use g_new() family of functions'
008/88:[0002] [FC] 'BT: use g_new() family of functions'
009/88:[----] [--] 'Bootdevice: use g_new() family of functions'
010/88:[0006] [FC] 'Character devices: use g_new() family of functions'
011/88:[----] [--] 'Cryptodev Backends: use g_new() family of functions'
012/88:[down] 'backends/hostmem: use g_new() family of functions'
013/88:[0002] [FC] 'Dirty Bitmaps: use g_new() family of functions'
014/88:[down] 'ui/vnc: use g_new() family of functions'
015/88:[down] 'ui/spice: use g_new() family of functions'
016/88:[0022] [FC] 'Main loop: use g_new() family of functions'
017/88:[----] [--] 'Memory API: use g_new() family of functions'
018/88:[----] [--] 'memory: use g_new() family of functions'
019/88:[down] 'exec: use g_new() family of functions'
020/88:[0007] [FC] 'Migration: use g_new() family of functions'
021/88:[----] [--] 'NBD: use g_new() family of functions'
022/88:[0002] [FC] 'LM32: use g_new() family of functions'
023/88:[0009] [FC] 'M68K: use g_new() family of functions'
024/88:[0006] [FC] 'MIPS: use g_new() family of functions'
025/88:[0002] [FC] 'OpenRISC: use g_new() family of functions'
026/88:[0018] [FC] 'S390: use g_new() family of functions'
027/88:[0008] [FC] 'SH4: use g_new() family of functions'
028/88:[down] 'disas: use g_new() family of functions'
029/88:[0004] [FC] 'SPARC: use g_new() family of functions'
030/88:[0032] [FC] 'QEMU Guest Agent: use g_new() family of functions'
031/88:[0038] [FC] 'QMP: use g_new() family of functions'
032/88:[0016] [FC] 'QObject: use g_new() family of functions'
033/88:[down] 'qom: use g_new() family of functions'
034/88:[down] 'qapi: use g_new() family of functions'
035/88:[----] [--] 'Record/replay: use g_new() family of functions'
036/88:[0004] [FC] 'SLIRP: use g_new() family of functions'
037/88:[0002] [FC] 'TCG: use g_new() family of functions'
038/88:[0034] [FC] 'VFIO: use g_new() family of functions'
039/88:[down] 'hw/i386: use g_new() family of functions'
040/88:[down] 'hw/xen: use g_new() family of functions'
041/88:[down] 'target/i386: use g_new() family of functions'
042/88:[----] [--] 'XTFPGA: use g_new() family of functions'
043/88:[0002] [FC] 'hw/core: use g_new() family of functions'
044/88:[down] 'hw/core/loader: use g_new() family of functions'
045/88:[0002] [FC] 'hw/display: use g_new() family of functions'
046/88:[down] 'hw/display/vga: use g_new() family of functions'
047/88:[----] [--] 'hw/i2c: use g_new() family of functions'
048/88:[0002] [FC] 'hw/input: use g_new() family of functions'
049/88:[0002] [FC] 'hw/misc: use g_new() family of functions'
050/88:[----] [--] 'ivshmem: use g_new() family of functions'
051/88:[0002] [FC] 'hw/timer: use g_new() family of functions'
052/88:[----] [--] 'i.MX31: use g_new() family of functions'
053/88:[----] [--] 'iSCSI: use g_new() family of functions'
054/88:[0002] [FC] 'KVM: use g_new() family of functions'
055/88:[----] [--] 'PReP: use g_new() family of functions'
056/88:[0010] [FC] 'PowerPC: use g_new() family of functions'
057/88:[down] 'ppc: use g_new() family of functions'
058/88:[down] 'ppc4xx: use g_new() family of functions'
059/88:[0003] [FC] 'ppce500: use g_new() family of functions'
060/88:[0008] [FC] 'sPAPR: use g_new() family of functions'
061/88:[0020] [FC] 'tests: use g_new() family of functions'
062/88:[0002] [FC] 'user: use g_new() family of functions'
063/88:[down] 'bsd-user/syscall: fix a memory leak on EFAULT, use g_new()'
064/88:[----] [--] 'user: use g_strfreev()'
065/88:[0030] [FC] 'util: use g_new() family of functions'
066/88:[down] 'util/qemu-thread-win32: use g_new() family of functions'
067/88:[down] 'util/coroutine: use g_new() family of functions'
068/88:[0012] [FC] 'virtio: use g_new() family of functions'
069/88:[0004] [FC] 'virtio-9p: use g_new() family of functions'
070/88:[down] 'block: use g_new() family of functions'
071/88:[down] 'block: avoid use of g_new0()'
072/88:[down] 'hw/block/nvme: use g_new() family of functions'
073/88:[down] 'hw/block/xen_disk: avoid use of g_new0()'
074/88:[down] 'balloon: use g_new() family of functions'
075/88:[----] [--] 'decnumber: use g_new() family of functions'
076/88:[0002] [FC] 'dma: use g_new() family of functions'
077/88:[----] [--] 'dump: use g_new() family of functions'
078/88:[----] [--] 'gdb: use g_new() family of functions'
079/88:[down] 'hmp: use g_new() family of functions'
080/88:[down] 'numa: use g_new() family of functions'
081/88:[down] 'hw/acpi: use g_new() family of functions'
082/88:[down] 'hw/ipmi: use g_new() family of functions'
083/88:[down] 'hw/pci: use g_new() family of functions'
084/88:[down] 'hw/scsi: use g_new() family of functions'
085/88:[down] 'hw/usb: use g_new() family of functions'
086/88:[down] 'net/hub: use g_new() family of functions'
087/88:[down] 'hw/net/rocker: use g_new() family of functions'
088/88:[down] 'scripts/coverity-model: use g_new() family of functions'

On 10/06/2017 08:48 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This is a follow-up of Marc-André's clang-tidy series [1].
> While chatting we realized we were trying to reach the same goal, Marc-André
> using clang-tidy and me using spatch; so he let me finish his series applying
> my changes over his.
> I also included Jan's patch which fits well.
> 
> Summary:
> - 1 bugfix (memory leak)
> - few optimizations (avoid to zeroise when all memory is assigned)
> - bunch of mechanical refactors
> 
> Regards,
> 
> Phil.
> 
> [1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg00881.html
