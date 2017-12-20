Received: from eggs.gnu.org ([2001:4830:134:3::10]:38702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRcZT-0001Zj-1Z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRcZR-0004qX-TN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:29:59 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:41237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRcZR-0004pm-OO
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:29:57 -0500
Received: by mail-oi0-x22c.google.com with SMTP id t78so14398216oie.8
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 03:29:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171219042942.29297-1-david@gibson.dropbear.id.au>
References: <20171219042942.29297-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 11:29:36 +0000
Message-ID: <CAFEAcA_CrLPQDBxYs6bzYX1Venpau1McP5o7-6PKuL1H-NJR4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] ppc-for-2.12 queue 20171219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 19 December 2017 at 04:29, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4bb:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-12-18 14:17:42 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20171219
>
> for you to fetch changes up to eec745d4366076dee068750ea80245e1a46e9c13:
>
>   hw/ide: Emulate SiI3112 SATA controller (2017-12-19 15:24:28 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-12-19
>
> Here's a second batch of patches for qemu-2.12.  Highlights are:
>
>   * Optional capabilities for the "pseries" machine.  This removes
>     some places where we were changing guest visible properties based
>     on host capabilities, which makes life very bad for migration.
>   * SLOF update
>   * Significant TCG speedup from Paolo
>   * Several new devices for embedded platforms
>   * Some minor cleanups
>

Migration test hangs on aarch32 host/ppc guest:

peter.m+  3942  0.0  0.0   1452   412 pts/0    S+   Dec19   0:00  |
                   \_ /bin/sh -c
QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((
${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=quick
tests/spapr-phb-test tests/endianness-test tests/boot-order-test
tests/prom-env-test tests/pnv-xscom-test tests/drive_del-test
tests/migration-test tests/boot-serial-test tests/rtas-test
tests/pxe-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
tests/usb-hcd-xhci-test tests/virtio-net-test
tests/virtio-balloon-test tests/virtio-blk-test tests/virtio-rng-test
tests/virtio-scsi-test tests/virtio-9p-test tests/virtio-serial-test
tests/virtio-console-test tests/test-netfilter
tests/test-filter-mirror tests/test-filter-redirector
tests/display-vga-test tests/numa-test tests/ivshmem-test
tests/qmp-test tests/device-introspect-test tests/qom-test
tests/test-hmp
peter.m+  3943  0.0  0.0  11984  1828 pts/0    Sl+  Dec19   0:00  |
                       \_ gtester -k --verbose -m=quick
tests/spapr-phb-test tests/endianness-test tests/boot-order-test
tests/prom-env-test tests/pnv-xscom-test tests/drive_del-test
tests/migration-test tests/boot-serial-test tests/rtas-test
tests/pxe-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
tests/usb-hcd-xhci-test tests/virtio-net-test
tests/virtio-balloon-test tests/virtio-blk-test tests/virtio-rng-test
tests/virtio-scsi-test tests/virtio-9p-test tests/virtio-serial-test
tests/virtio-console-test tests/test-netfilter
tests/test-filter-mirror tests/test-filter-redirector
tests/display-vga-test tests/numa-test tests/ivshmem-test
tests/qmp-test tests/device-introspect-test tests/qom-test
tests/test-hmp
peter.m+  4041 99.9  0.0   3460   824 pts/0    R+   Dec19 809:16  |
                           \_ tests/migration-test --quiet
--keep-going -m=quick --GTestLogFD=6
peter.m+  4042 99.9  0.4 607804 72924 pts/0    Sl+  Dec19 809:50  |
                               \_ ppc64-softmmu/qemu-system-ppc64
-qtest unix:/tmp/qtest-4041.sock,nowait -qtest-log /dev/null -qmp
unix:/tmp/qtest-4041.qmp,nowait -machine accel=qtest -display none
-machine accel=tcg -m 256M -name pcsource,debug-threads=on -serial
file:/tmp/migration-test-vxvkIZ/src_serial -drive
file=/tmp/migration-test-vxvkIZ/bootsect,if=pflash,format=raw
peter.m+  4046  0.0  0.3 596596 49696 pts/0    Sl+  Dec19   0:01  |
                               \_ ppc64-softmmu/qemu-system-ppc64
-qtest unix:/tmp/qtest-4041.sock,nowait -qtest-log /dev/null -qmp
unix:/tmp/qtest-4041.qmp,nowait -machine accel=qtest -display none
-machine accel=tcg -m 256M -name pcdest,debug-threads=on -serial
file:/tmp/migration-test-vxvkIZ/dest_serial -incoming
unix:/tmp/migration-test-vxvkIZ/migsocket


Process 4041/4042 are using 100% CPU.

$ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 gtester -k
--verbose -m=quick tests/migration-test
TEST: tests/migration-test... (pid=5441)
  /ppc64/migration/postcopy/unix:
[hangs]

My first guess is that this is a general 32-bit host issue
rather than an arm-host specific one; arm just happens to
be the only 32-bit system in my test set.

thanks
-- PMM
