Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXniA-0000Cw-NJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXni6-0004xc-LC
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gXni5-0004uf-AF
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:40:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18AC8A6E05
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 13:40:54 +0000 (UTC)
References: <20181213223737.11793-1-pbonzini@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <dd90ef6b-51e1-87e1-ab5d-3648fefce60c@redhat.com>
Date: Fri, 14 Dec 2018 11:40:51 -0200
MIME-Version: 1.0
In-Reply-To: <20181213223737.11793-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix TABs in many files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


On 12/13/2018 08:37 PM, Paolo Bonzini wrote:
> Space-tab sequences at the beginning of the line are always a mistake,
> so patch 1 fixes them.  I am not touching space-tab in the middle of
> the line, many of which are in #define lines.
>
> In addition, about a third of the files with TABs have only a few of
> them and it's worth converting them for consistency.  Of the files
> touched by patch 2, hw/ide/core.c is the worst in absolute terms, with
> over 50 occurrences in a 3000 lines file; hw/char/xen_console.c has
> about a third TABs and two-thirds spaces but it is small so I included it.
>
> The files were selected by hand starting from a list of .c and .h
> files in the tree, sorted by number of occurrences.  I left out
> files that for example were using TABs consistently for structs,
> on the grounds that those were probably copied from Linux.  I also
> left out slirp from patch 2 because I did not want to complicate the
> ongoing surgery to extract it from QEMU.
>
> Thanks,
>
> Paolo
>
> Paolo Bonzini (2):
>    remove space-tab sequences
>    avoid TABs in files that only contain a few
>
>   block/bochs.c                              | 22 ++---
>   block/file-posix.c                         |  2 +-
>   block/file-win32.c                         |  8 +-
>   block/linux-aio.c                          |  4 +-
>   block/qcow2-cluster.c                      |  2 +-
>   block/vpc.c                                |  2 +-
>   bsd-user/elfload.c                         |  2 +-
>   bsd-user/x86_64/target_syscall.h           |  2 +-
>   contrib/elf2dmp/main.c                     |  2 +-
>   crypto/aes.c                               | 28 +++----
>   disas/alpha.c                              |  8 +-
>   disas/arm.c                                |  2 +-
>   disas/i386.c                               |  4 +-
>   disas/m68k.c                               |  4 +-
>   hw/alpha/typhoon.c                         | 12 +--
>   hw/arm/stellaris.c                         |  2 +-
>   hw/arm/virt.c                              |  2 +-
>   hw/char/sh_serial.c                        | 18 ++---
>   hw/char/virtio-serial-bus.c                |  2 +-
>   hw/char/xen_console.c                      | 58 ++++++-------
>   hw/core/loader.c                           | 28 +++----
>   hw/display/tc6393xb.c                      |  6 +-
>   hw/display/vga.c                           |  8 +-
>   hw/display/virtio-gpu-3d.c                 |  6 +-
>   hw/dma/pxa2xx_dma.c                        |  4 +-
>   hw/dma/soc_dma.c                           |  2 +-
>   hw/gpio/max7310.c                          |  2 +-
>   hw/i386/xen/xen-hvm.c                      |  4 +-
>   hw/ide/core.c                              | 94 +++++++++++-----------
>   hw/input/lm832x.c                          |  2 +-
>   hw/input/pckbd.c                           |  2 +-
>   hw/input/tsc210x.c                         |  2 +-
>   hw/intc/apic.c                             |  2 +-
>   hw/mips/gt64xxx_pci.c                      |  6 +-
>   hw/mips/mips_r4k.c                         |  4 +-
>   hw/misc/max111x.c                          |  6 +-
>   hw/misc/omap_l4.c                          |  4 +-
>   hw/net/mipsnet.c                           | 16 ++--
>   hw/net/ne2000.c                            | 44 +++++-----
>   hw/net/rocker/rocker.c                     |  2 +-
>   hw/net/virtio-net.c                        |  4 +-
>   hw/net/vmxnet3.c                           |  6 +-
>   hw/pci/msix.c                              |  2 +-
>   hw/pci/pci.c                               | 44 +++++-----
>   hw/pci/pci_bridge.c                        |  2 +-
>   hw/ppc/ppc405_uc.c                         |  2 +-
>   hw/ppc/prep.c                              |  4 +-
>   hw/scsi/lsi53c895a.c                       |  6 +-
>   hw/sh4/r2d.c                               | 16 ++--
>   hw/usb/dev-bluetooth.c                     |  2 +-
>   hw/usb/dev-hid.c                           |  6 +-
>   hw/usb/dev-hub.c                           | 14 ++--
>   hw/usb/hcd-uhci.c                          |  4 +-
>   hw/xen/xen_devconfig.c                     |  2 +-
>   hw/xenpv/xen_domainbuild.c                 |  8 +-
>   include/elf.h                              | 10 +--
>   include/hw/acpi/acpi.h                     | 14 ++--
>   include/hw/elf_ops.h                       |  2 +-
>   include/hw/ide/internal.h                  |  2 +-
>   include/hw/sh4/sh_intc.h                   | 20 ++---
>   include/hw/xen/io/ring.h                   |  4 +-
>   include/qemu/acl.h                         | 14 ++--
>   include/qemu/iov.h                         |  2 +-
>   include/scsi/constants.h                   |  2 +-
>   include/sysemu/balloon.h                   |  2 +-
>   linux-user/linuxload.c                     | 14 ++--
>   linux-user/main.c                          |  4 +-
>   linux-user/mmap.c                          | 10 +--
>   linux-user/qemu.h                          |  4 +-
>   linux-user/signal.c                        | 16 ++--
>   linux-user/strace.c                        |  4 +-
>   linux-user/syscall.c                       |  2 +-
>   linux-user/syscall_defs.h                  |  4 +-
>   linux-user/uaccess.c                       |  2 +-
>   linux-user/vm86.c                          |  2 +-
>   linux-user/x86_64/target_syscall.h         |  2 +-
>   nbd/client.c                               |  2 +-
>   net/checksum.c                             |  2 +-
>   qtest.c                                    |  4 +-
>   slirp/ip_input.c                           |  4 +-
>   slirp/tcp_input.c                          | 10 +--
>   slirp/tcp_output.c                         |  4 +-
>   slirp/tcp_timer.c                          |  2 +-
>   slirp/udp.c                                |  2 +-
>   target/alpha/translate.c                   |  2 +-
>   target/cris/helper.c                       |  2 +-
>   target/cris/mmu.h                          | 10 +--
>   target/cris/translate_v10.inc.c            |  2 +-
>   target/i386/translate.c                    | 12 +--
>   target/mips/translate.c                    |  2 +-
>   target/tilegx/translate.c                  |  2 +-
>   tcg/i386/tcg-target.inc.c                  |  4 +-
>   tests/tcg/alpha/test-cond.c                |  4 +-
>   tests/tcg/arm/hello-arm.c                  | 20 ++---
>   tests/tcg/cris/check_glibc_kernelversion.c |  8 +-
>   tests/tcg/cris/check_mmap3.c               |  2 +-
>   tests/tcg/cris/check_openpf1.c             |  2 +-
>   tests/tcg/cris/check_settls1.c             |  2 +-
>   tests/tcg/i386/hello-i386.c                | 14 ++--
>   tests/tcg/mips/hello-mips.c                | 10 +--
>   tests/tcg/multiarch/sha1.c                 | 12 +--
>   tests/vhost-user-test.c                    |  4 +-
>   ui/keymaps.h                               |  4 +-
>   ui/qemu-pixman.c                           |  2 +-
>   ui/vnc-enc-zywrle-template.c               |  4 +-
>   ui/vnc.c                                   |  4 +-
>   util/bitops.c                              |  4 +-
>   util/osdep.c                               |  4 +-
>   util/qemu-sockets.c                        |  4 +-
>   109 files changed, 429 insertions(+), 429 deletions(-)
>

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
