Received: from eggs.gnu.org ([2001:4830:134:3::10]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhCX-0005e6-5X
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhCT-00046P-Uf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:40:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGhCT-00044r-LR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:40:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 11:40:25 +0400
Message-Id: <20170602074040.7400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 43771d5d92312504305c19abe29ec5bfabd55f=
01:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-31'=
 into staging (2017-06-01 16:39:16 +0100)

are available in the git repository at:

  github/chrfe chrfe-pull-request

for you to fetch changes up to 6b10e573d15ef82dbc5c5b3726028e6642e134f6:

  char: move char devices to chardev/ (2017-06-02 11:33:53 +0400)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (14):
  char-win: simplify win_chr_read()
  char-win: remove WinChardev.len
  char-win: rename win_chr_init/poll win_chr_serial_init/poll
  char-win: rename hcom->file
  char-win: close file handle except with console
  Remove/replace sysemu/char.h inclusion
  chardev: move headers to include/chardev
  chardev: serial & parallel declaration to own headers
  be-hci: use backend functions
  char: generalize qemu_chr_write_all()
  char: move CharBackend handling in char-fe unit
  char: rename functions that are not part of fe
  char: make chr_fe_deinit() optionaly delete backend
  char: move char devices to chardev/

Philippe Mathieu-Daud=C3=A9 (1):
  char: cast ARRAY_SIZE() as signed to silent warning on empty array

 {chardev =3D> include/chardev}/char-fd.h        |   2 +-
 include/chardev/char-fe.h                     | 251 +++++++++++++
 {chardev =3D> include/chardev}/char-io.h        |   2 +-
 {chardev =3D> include/chardev}/char-mux.h       |   3 +-
 {chardev =3D> include/chardev}/char-parallel.h  |  20 +-
 {chardev =3D> include/chardev}/char-serial.h    |  22 ++
 {chardev =3D> include/chardev}/char-win-stdio.h |   0
 {chardev =3D> include/chardev}/char-win.h       |  14 +-
 include/chardev/char.h                        | 229 ++++++++++++
 include/hw/char/bcm2835_aux.h                 |   2 +-
 include/hw/char/cadence_uart.h                |   2 +-
 include/hw/char/digic-uart.h                  |   2 +-
 include/hw/char/imx_serial.h                  |   2 +-
 include/hw/char/serial.h                      |   4 +-
 include/hw/char/stm32f2xx_usart.h             |   2 +-
 include/sysemu/char.h                         | 499 --------------------=
------
 backends/rng-egd.c                            |   4 +-
 {backends =3D> chardev}/baum.c                  |   2 +-
 chardev/char-console.c                        |   4 +-
 chardev/char-fd.c                             |   6 +-
 chardev/char-fe.c                             | 361 +++++++++++++++++++
 chardev/char-file.c                           |   8 +-
 chardev/char-io.c                             |   2 +-
 chardev/char-mux.c                            |   6 +-
 chardev/char-null.c                           |   2 +-
 chardev/char-parallel.c                       |   6 +-
 chardev/char-pipe.c                           |  16 +-
 chardev/char-pty.c                            |   4 +-
 chardev/char-ringbuf.c                        |   2 +-
 chardev/char-serial.c                         |   8 +-
 chardev/char-socket.c                         |   4 +-
 chardev/char-stdio.c                          |   8 +-
 chardev/char-udp.c                            |   4 +-
 chardev/char-win-stdio.c                      |   4 +-
 chardev/char-win.c                            |  95 ++---
 chardev/char.c                                | 390 +-------------------
 {backends =3D> chardev}/msmouse.c               |   2 +-
 spice-qemu-char.c =3D> chardev/spice.c          |   4 +-
 {backends =3D> chardev}/testdev.c               |   2 +-
 {backends =3D> chardev}/wctablet.c              |   2 +-
 gdbstub.c                                     |  18 +-
 hmp.c                                         |   2 +-
 hw/arm/bcm2835_peripherals.c                  |   1 -
 hw/arm/fsl-imx25.c                            |   2 +-
 hw/arm/fsl-imx31.c                            |   2 +-
 hw/arm/fsl-imx6.c                             |   2 +-
 hw/arm/omap2.c                                |   2 +-
 hw/arm/pxa2xx.c                               |   2 +-
 hw/arm/strongarm.c                            |   3 +-
 hw/bt/hci-csr.c                               |  11 +-
 hw/char/cadence_uart.c                        |   3 +-
 hw/char/debugcon.c                            |   2 +-
 hw/char/digic-uart.c                          |   2 +-
 hw/char/escc.c                                |   3 +-
 hw/char/etraxfs_ser.c                         |   2 +-
 hw/char/exynos4210_uart.c                     |   3 +-
 hw/char/grlib_apbuart.c                       |   2 +-
 hw/char/imx_serial.c                          |   1 -
 hw/char/ipoctal232.c                          |   2 +-
 hw/char/lm32_juart.c                          |   2 +-
 hw/char/lm32_uart.c                           |   2 +-
 hw/char/mcf_uart.c                            |   2 +-
 hw/char/milkymist-uart.c                      |   2 +-
 hw/char/omap_uart.c                           |   2 +-
 hw/char/parallel.c                            |   3 +-
 hw/char/pl011.c                               |   2 +-
 hw/char/sclpconsole-lm.c                      |   2 +-
 hw/char/sclpconsole.c                         |   2 +-
 hw/char/serial.c                              |   4 +-
 hw/char/sh_serial.c                           |   2 +-
 hw/char/spapr_vty.c                           |   2 +-
 hw/char/terminal3270.c                        |   2 +-
 hw/char/virtio-console.c                      |   2 +-
 hw/char/xen_console.c                         |   4 +-
 hw/char/xilinx_uartlite.c                     |   2 +-
 hw/core/qdev-properties-system.c              |   4 +-
 hw/core/qdev-properties.c                     |   2 +-
 hw/display/xenfb.c                            |   1 -
 hw/i386/xen/xen-hvm.c                         |   1 -
 hw/ipmi/ipmi_bmc_extern.c                     |   2 +-
 hw/isa/pc87312.c                              |   2 +-
 hw/mips/boston.c                              |   2 +-
 hw/mips/mips_fulong2e.c                       |   1 -
 hw/mips/mips_malta.c                          |   1 -
 hw/misc/ivshmem.c                             |   2 +-
 hw/net/xgmac.c                                |   1 -
 hw/ppc/spapr_events.c                         |   1 -
 hw/ppc/spapr_rtas.c                           |   1 -
 hw/sparc/leon3.c                              |   1 -
 hw/usb/ccid-card-emulated.c                   |   2 +-
 hw/usb/ccid-card-passthru.c                   |   7 +-
 hw/usb/dev-serial.c                           |   3 +-
 hw/usb/redirect.c                             |   6 +-
 hw/virtio/vhost-user.c                        |   2 +-
 hw/xen/xen-common.c                           |   2 +-
 hw/xen/xen_backend.c                          |   1 -
 hw/xtensa/xtfpga.c                            |   2 +-
 monitor.c                                     |   4 +-
 net/colo-compare.c                            |  10 +-
 net/filter-mirror.c                           |   8 +-
 net/slirp.c                                   |   2 +-
 net/vhost-user.c                              |   7 +-
 qmp.c                                         |   2 +-
 qtest.c                                       |   2 +-
 replay/replay-char.c                          |   2 +-
 slirp/slirp.c                                 |   2 +-
 tests/postcopy-test.c                         |   2 +-
 tests/test-char.c                             |  24 +-
 tests/vhost-user-test.c                       |   6 +-
 ui/console.c                                  |   2 +-
 ui/gtk.c                                      |   2 +-
 util/event_notifier-posix.c                   |   1 -
 vl.c                                          |   2 +-
 MAINTAINERS                                   |   5 +-
 Makefile.objs                                 |   4 +-
 backends/Makefile.objs                        |   4 -
 backends/trace-events                         |  10 -
 chardev/Makefile.objs                         |   7 +
 chardev/trace-events                          |  18 +
 trace-events                                  |   7 -
 120 files changed, 1126 insertions(+), 1158 deletions(-)
 rename {chardev =3D> include/chardev}/char-fd.h (98%)
 create mode 100644 include/chardev/char-fe.h
 rename {chardev =3D> include/chardev}/char-io.h (98%)
 rename {chardev =3D> include/chardev}/char-mux.h (97%)
 rename {chardev =3D> include/chardev}/char-parallel.h (70%)
 rename {chardev =3D> include/chardev}/char-serial.h (75%)
 rename {chardev =3D> include/chardev}/char-win-stdio.h (100%)
 rename {chardev =3D> include/chardev}/char-win.h (84%)
 create mode 100644 include/chardev/char.h
 delete mode 100644 include/sysemu/char.h
 rename {backends =3D> chardev}/baum.c (99%)
 create mode 100644 chardev/char-fe.c
 rename {backends =3D> chardev}/msmouse.c (99%)
 rename spice-qemu-char.c =3D> chardev/spice.c (99%)
 rename {backends =3D> chardev}/testdev.c (99%)
 rename {backends =3D> chardev}/wctablet.c (99%)
 create mode 100644 chardev/trace-events

--=20
2.13.0.91.g00982b8dd
