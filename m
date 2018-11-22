Received: from eggs.gnu.org ([2001:4830:134:3::10]:49723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPnzw-0006s6-27
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPnzs-000261-GD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:22:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gPnzs-00024y-6u
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:22:16 -0500
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org> <87muq2fgbw.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
Date: Thu, 22 Nov 2018 13:22:11 +0100
MIME-Version: 1.0
In-Reply-To: <87muq2fgbw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On 2018-11-21 19:14, Markus Armbruster wrote:
> Time for another update.  My HEAD is at v3.1.0-rc2.

Thanks a lot for this, Markus, very appreciated!

[...]
> Unmaintained files sorted by number of commits in the past year
> (v2.11.0-rc2):
>=20
> $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v2.=
11.0-rc2.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort =
-rn | head -n 100
>     139 MAINTAINERS
>     138 configure
>     108 tests/Makefile.include
>      87 qemu-options.hx

I still think we'd need someone to look after qemu-options.hx, since
these are public interfaces...

>      62 qemu-doc.texi
>      56 Makefile
>      44 tests/test-bdrv-drain.c
>      26 tests/test-blockjob.c
>      24 Makefile.objs
>      22 VERSION
>      21 tests/test-blockjob-txn.c
>      21 scripts/checkpatch.pl
>      20 default-configs/arm-softmmu.mak

Maybe add that to one of Peter's ARM sections?

>      19 hw/display/sm501.c

Maybe Balaton wants to adopt this file?

>      17 hw/misc/Makefile.objs
>      16 include/sysemu/sysemu.h
>      15 include/hw/mem/pc-dimm.h
>      15 hw/sd/trace-events
>      15 contrib/libvhost-user/libvhost-user.c
>      14 tests/test-char.c
>      14 hw/core/qdev.c
>      13 scripts/update-linux-headers.sh
>      13 scripts/device-crash-test

That should go into the "Python scripts" section.

>      13 hw/display/Makefile.objs
>      13 .gitignore
>      12 include/qom/cpu.h
>      12 include/hw/mem/memory-device.h
>      12 include/elf.h
>      12 hw/misc/trace-events
>      12 default-configs/ppc-softmmu.mak
>      11 util/qht.c
>      10 util/memfd.c
>      10 qdev-monitor.c
>      10 include/sysemu/blockdev.h
>      10 include/qapi/qmp/dispatch.h
>      10 hw/misc/ivshmem.c
>      10 gdbstub.c
>      10 docs/devel/testing.rst
>       9 tests/check-qobject.c
>       9 include/qemu/osdep.h
>       9 include/hw/compat.h
>       9 contrib/libvhost-user/libvhost-user.h
>       8 util/qemu-config.c
>       8 util/Makefile.objs
>       8 linux-headers/linux/kvm.h
>       8 iothread.c
>       8 include/qemu/timer.h
>       8 include/qemu/qht.h
>       8 include/hw/qdev-properties.h
>       8 include/hw/pci-host/uninorth.h

uninorth is definitely related to mac99.

>       8 hw/intc/trace-events
>       8 hw/hyperv/hyperv.c
>       8 hw/core/loader.c
>       7 util/qsp.c
>       7 tests/test-qht.c
>       7 tests/.gitignore
>       7 os-posix.c
>       7 include/qemu/compiler.h
>       7 include/monitor/monitor.h
>       7 include/hw/qdev-core.h
>       7 include/hw/loader.h
>       7 include/hw/arm/smmu-common.h
>       7 docs/qcow2-cache.txt
>       7 default-configs/i386-softmmu.mak
>       7 Makefile.target
>       7 .gitmodules
>       6 tests/check-qlit.c
>       6 pc-bios/README
>       6 include/sysemu/arch_init.h
>       6 include/qemu/thread.h
>       6 include/qemu/memfd.h
>       6 include/hw/ssi/xilinx_spips.h

That belongs to one of the ARM machines, I think.

>       6 include/hw/hyperv/hyperv.h
>       6 include/hw/block/block.h
>       6 hw/nvram/fw_cfg.c
>       6 hw/input/ps2.c
>       6 docs/nvdimm.txt
>       6 docs/interop/qmp-spec.txt
>       6 device-hotplug.c
>       6 default-configs/x86_64-softmmu.mak
>       5 win_dump.c
>       5 util/uri.c
>       5 util/qemu-thread-posix.c
>       5 util/oslib-posix.c
>       5 tests/test-x86-cpuid-compat.c
>       5 tests/test-rcu-list.c
>       5 tests/tcg/README
>       5 tests/migration/Makefile
>       5 rules.mak
>       5 roms/openbios
>       5 pc-bios/openbios-ppc
>       5 linux-headers/asm-x86/kvm.h
>       5 linux-headers/asm-powerpc/kvm.h
>       5 include/standard-headers/linux/pci_regs.h
>       5 include/qemu/typedefs.h
>       5 include/qemu/cutils.h
>       5 include/hw/misc/iotkit-secctl.h
>       5 hw/watchdog/watchdog.c
>       5 hw/sd/ssi-sd.c
>       5 hw/pci-host/bonito.c

Bonito seems to belong to MIPS Fulong.

> qdev needs a maintainer.  It has needed one since forever.

Definitely. But who could do that job?

 Thomas
