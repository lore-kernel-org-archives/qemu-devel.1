Received: from eggs.gnu.org ([2001:4830:134:3::10]:33016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDw-0005Rt-Li
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDt-0004ur-Nz
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlDt-0004rg-AF
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 537AB307D85F
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:22:28 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:06 +0200
Message-Id: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/11] chardev: Convert IO handlers to use
 unsigned type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org

Hi Paolo,

Here are the changes you suggested in
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02294.html

First two simple cleanups while here,
then slowly convert backends then frontends.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (11):
  hw/ipmi: Remove unnecessary declarations
  target/xtensa: Remove unnecessary declarations
  chardev: Simplify IOWatchPoll::fd_can_read as a GSourceFunc
  chardev: Assert backend's chr_can_read() is positive
  chardev: Let chr_sync_read() use unsigned type
  chardev: Let chr_write use unsigned type
  chardev: Let IOReadHandler use unsigned type
  chardev: Let IOCanReadHandler use unsigned type
  chardev: Let qemu_chr_fe_* use unsigned type
  chardev: Let qemu_chr_be_* use unsigned type
  chardev: FDChardev::max_size be unsigned

 backends/rng-egd.c          |  6 +++---
 chardev/baum.c              |  2 +-
 chardev/char-fd.c           |  8 ++++----
 chardev/char-fe.c           |  8 ++++----
 chardev/char-io.c           |  4 ++--
 chardev/char-mux.c          |  6 +++---
 chardev/char-pty.c          |  6 +++---
 chardev/char-ringbuf.c      |  4 ++--
 chardev/char-socket.c       | 10 +++++-----
 chardev/char-udp.c          |  6 +++---
 chardev/char-win-stdio.c    |  2 +-
 chardev/char-win.c          |  2 +-
 chardev/char.c              | 20 ++++++++++++--------
 chardev/msmouse.c           |  2 +-
 chardev/spice.c             |  2 +-
 chardev/testdev.c           |  2 +-
 chardev/wctablet.c          |  4 ++--
 gdbstub.c                   |  6 +++---
 hw/arm/pxa2xx.c             |  4 ++--
 hw/arm/strongarm.c          |  5 +++--
 hw/bt/hci-csr.c             |  4 ++--
 hw/char/bcm2835_aux.c       |  4 ++--
 hw/char/cadence_uart.c      |  6 +++---
 hw/char/cmsdk-apb-uart.c    |  4 ++--
 hw/char/digic-uart.c        |  4 ++--
 hw/char/escc.c              |  8 ++++----
 hw/char/etraxfs_ser.c       |  4 ++--
 hw/char/exynos4210_uart.c   |  5 +++--
 hw/char/grlib_apbuart.c     |  4 ++--
 hw/char/imx_serial.c        |  4 ++--
 hw/char/ipoctal232.c        |  6 +++---
 hw/char/lm32_juart.c        |  4 ++--
 hw/char/lm32_uart.c         |  4 ++--
 hw/char/mcf_uart.c          |  4 ++--
 hw/char/milkymist-uart.c    |  4 ++--
 hw/char/parallel.c          |  2 +-
 hw/char/pl011.c             |  6 +++---
 hw/char/sclpconsole-lm.c    |  4 ++--
 hw/char/sclpconsole.c       |  6 +++---
 hw/char/serial.c            |  8 ++++----
 hw/char/sh_serial.c         |  6 +++---
 hw/char/spapr_vty.c         |  6 +++---
 hw/char/stm32f2xx_usart.c   |  5 +++--
 hw/char/terminal3270.c      |  4 ++--
 hw/char/virtio-console.c    |  4 ++--
 hw/char/xen_console.c       |  4 ++--
 hw/char/xilinx_uartlite.c   |  4 ++--
 hw/ipmi/ipmi_bmc_extern.c   |  8 ++------
 hw/misc/ivshmem.c           |  6 +++---
 hw/riscv/riscv_htif.c       |  4 ++--
 hw/riscv/sifive_uart.c      |  4 ++--
 hw/usb/ccid-card-passthru.c |  6 +++---
 hw/usb/dev-serial.c         |  4 ++--
 hw/usb/redirect.c           |  4 ++--
 include/chardev/char-fd.h   |  2 +-
 include/chardev/char-fe.h   |  6 +++---
 include/chardev/char-io.h   |  2 +-
 include/chardev/char.h      | 13 +++++++------
 include/qemu/main-loop.h    |  4 ++--
 include/sysemu/replay.h     |  8 ++++----
 monitor.c                   |  6 +++---
 net/colo-compare.c          |  6 +++---
 net/filter-mirror.c         |  4 ++--
 net/slirp.c                 |  4 ++--
 qtest.c                     |  4 ++--
 replay/replay-char.c        |  8 ++++----
 stubs/replay.c              |  8 ++++----
 target/xtensa/xtensa-semi.c |  6 ++----
 ui/console.c                |  2 +-
 ui/gtk.c                    |  2 +-
 70 files changed, 180 insertions(+), 178 deletions(-)

--=20
2.17.1
