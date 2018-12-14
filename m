Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXpCp-0003co-Hi
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXpCo-0007t8-5R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:16:47 -0500
Date: Fri, 14 Dec 2018 15:16:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181214151611.GC3882@stefanha-x1.localdomain>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20181213223737.11793-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] avoid TABs in files that only contain
 a few
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Fam Zheng <famz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "open list:bochs" <qemu-block@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:ppc4xx" <qemu-ppc@nongnu.org>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 11:37:37PM +0100, Paolo Bonzini wrote:
> Most files that have TABs only contain a handful of them.  Change
> them to spaces so that we don't confuse people.
>=20
> disas, standard-headers, linux-headers and libdecnumber are imported
> from other projects and probably should be exempted from the check.
> Outside those, after this patch the following files still contain both
> 8-space and TAB sequences at the beginning of the line.  Many of them
> have a majority of TABs, or were initially committed with all tabs.
>=20
>     bsd-user/i386/target_syscall.h
>     bsd-user/x86_64/target_syscall.h
>     crypto/aes.c
>     hw/audio/fmopl.c
>     hw/audio/fmopl.h
>     hw/block/tc58128.c
>     hw/display/cirrus_vga.c
>     hw/display/xenfb.c
>     hw/dma/etraxfs_dma.c
>     hw/intc/sh_intc.c
>     hw/misc/mst_fpga.c
>     hw/net/pcnet.c
>     hw/sh4/sh7750.c
>     hw/timer/m48t59.c
>     hw/timer/sh_timer.c
>     include/crypto/aes.h
>     include/disas/bfd.h
>     include/hw/sh4/sh.h
>     libdecnumber/decNumber.c
>     linux-headers/asm-generic/unistd.h
>     linux-headers/linux/kvm.h
>     linux-user/alpha/target_syscall.h
>     linux-user/arm/nwfpe/double_cpdo.c
>     linux-user/arm/nwfpe/fpa11_cpdt.c
>     linux-user/arm/nwfpe/fpa11_cprt.c
>     linux-user/arm/nwfpe/fpa11.h
>     linux-user/flat.h
>     linux-user/flatload.c
>     linux-user/i386/target_syscall.h
>     linux-user/ppc/target_syscall.h
>     linux-user/sparc/target_syscall.h
>     linux-user/syscall.c
>     linux-user/syscall_defs.h
>     linux-user/x86_64/target_syscall.h
>     slirp/cksum.c
>     slirp/if.c
>     slirp/ip.h
>     slirp/ip_icmp.c
>     slirp/ip_icmp.h
>     slirp/ip_input.c
>     slirp/ip_output.c
>     slirp/mbuf.c
>     slirp/misc.c
>     slirp/sbuf.c
>     slirp/socket.c
>     slirp/socket.h
>     slirp/tcp_input.c
>     slirp/tcpip.h
>     slirp/tcp_output.c
>     slirp/tcp_subr.c
>     slirp/tcp_timer.c
>     slirp/tftp.c
>     slirp/udp.c
>     slirp/udp.h
>     target/cris/cpu.h
>     target/cris/mmu.c
>     target/cris/op_helper.c
>     target/sh4/helper.c
>     target/sh4/op_helper.c
>     target/sh4/translate.c
>     tcg/sparc/tcg-target.inc.c
>     tests/tcg/cris/check_addo.c
>     tests/tcg/cris/check_moveq.c
>     tests/tcg/cris/check_swap.c
>     tests/tcg/multiarch/test-mmap.c
>     ui/vnc-enc-hextile-template.h
>     ui/vnc-enc-zywrle.h
>     util/envlist.c
>     util/readline.c
>=20
> The following have only TABs:
>=20
>     bsd-user/i386/target_signal.h
>     bsd-user/sparc64/target_signal.h
>     bsd-user/sparc64/target_syscall.h
>     bsd-user/sparc/target_signal.h
>     bsd-user/sparc/target_syscall.h
>     bsd-user/x86_64/target_signal.h
>     crypto/desrfb.c
>     hw/audio/intel-hda-defs.h
>     hw/core/uboot_image.h
>     hw/sh4/sh7750_regnames.c
>     hw/sh4/sh7750_regs.h
>     include/hw/cris/etraxfs_dma.h
>     linux-user/alpha/termbits.h
>     linux-user/arm/nwfpe/fpopcode.h
>     linux-user/arm/nwfpe/fpsr.h
>     linux-user/arm/syscall_nr.h
>     linux-user/arm/target_signal.h
>     linux-user/cris/target_signal.h
>     linux-user/i386/target_signal.h
>     linux-user/linux_loop.h
>     linux-user/m68k/target_signal.h
>     linux-user/microblaze/target_signal.h
>     linux-user/mips64/target_signal.h
>     linux-user/mips/target_signal.h
>     linux-user/mips/target_syscall.h
>     linux-user/mips/termbits.h
>     linux-user/ppc/target_signal.h
>     linux-user/sh4/target_signal.h
>     linux-user/sh4/termbits.h
>     linux-user/sparc64/target_syscall.h
>     linux-user/sparc/target_signal.h
>     linux-user/x86_64/target_signal.h
>     linux-user/x86_64/termbits.h
>     pc-bios/optionrom/optionrom.h
>     slirp/mbuf.h
>     slirp/misc.h
>     slirp/sbuf.h
>     slirp/tcp.h
>     slirp/tcp_timer.h
>     slirp/tcp_var.h
>     target/i386/svm.h
>     target/sparc/asi.h
>     target/xtensa/core-dc232b/xtensa-modules.inc.c
>     target/xtensa/core-dc233c/xtensa-modules.inc.c
>     target/xtensa/core-de212/core-isa.h
>     target/xtensa/core-de212/xtensa-modules.inc.c
>     target/xtensa/core-fsf/xtensa-modules.inc.c
>     target/xtensa/core-sample_controller/core-isa.h
>     target/xtensa/core-sample_controller/xtensa-modules.inc.c
>     target/xtensa/core-test_kc705_be/core-isa.h
>     target/xtensa/core-test_kc705_be/xtensa-modules.inc.c
>     tests/tcg/cris/check_abs.c
>     tests/tcg/cris/check_addc.c
>     tests/tcg/cris/check_addcm.c
>     tests/tcg/cris/check_addoq.c
>     tests/tcg/cris/check_bound.c
>     tests/tcg/cris/check_ftag.c
>     tests/tcg/cris/check_int64.c
>     tests/tcg/cris/check_lz.c
>     tests/tcg/cris/check_openpf5.c
>     tests/tcg/cris/check_sigalrm.c
>     tests/tcg/cris/crisutils.h
>     tests/tcg/cris/sys.c
>     tests/tcg/i386/test-i386-ssse3.c
>     ui/vgafont.h
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/bochs.c                              | 22 ++---
>  block/file-posix.c                         |  2 +-
>  block/file-win32.c                         |  8 +-
>  block/linux-aio.c                          |  4 +-
>  block/qcow2-cluster.c                      |  2 +-
>  block/vpc.c                                |  2 +-
>  bsd-user/elfload.c                         |  2 +-
>  contrib/elf2dmp/main.c                     |  2 +-
>  hw/alpha/typhoon.c                         | 12 +--
>  hw/arm/stellaris.c                         |  2 +-
>  hw/arm/virt.c                              |  2 +-
>  hw/char/sh_serial.c                        | 18 ++---
>  hw/char/virtio-serial-bus.c                |  2 +-
>  hw/char/xen_console.c                      | 58 ++++++-------
>  hw/core/loader.c                           | 28 +++----
>  hw/display/tc6393xb.c                      |  6 +-
>  hw/display/vga.c                           |  8 +-
>  hw/display/virtio-gpu-3d.c                 |  6 +-
>  hw/dma/pxa2xx_dma.c                        |  4 +-
>  hw/dma/soc_dma.c                           |  2 +-
>  hw/gpio/max7310.c                          |  2 +-
>  hw/i386/xen/xen-hvm.c                      |  4 +-
>  hw/ide/core.c                              | 94 +++++++++++-----------
>  hw/input/lm832x.c                          |  2 +-
>  hw/input/pckbd.c                           |  2 +-
>  hw/input/tsc210x.c                         |  2 +-
>  hw/intc/apic.c                             |  2 +-
>  hw/mips/gt64xxx_pci.c                      |  6 +-
>  hw/mips/mips_r4k.c                         |  4 +-
>  hw/misc/max111x.c                          |  6 +-
>  hw/misc/omap_l4.c                          |  4 +-
>  hw/net/mipsnet.c                           | 16 ++--
>  hw/net/ne2000.c                            | 44 +++++-----
>  hw/net/rocker/rocker.c                     |  2 +-
>  hw/net/virtio-net.c                        |  4 +-
>  hw/net/vmxnet3.c                           |  6 +-
>  hw/pci/msix.c                              |  2 +-
>  hw/pci/pci.c                               | 44 +++++-----
>  hw/pci/pci_bridge.c                        |  2 +-
>  hw/ppc/ppc405_uc.c                         |  2 +-
>  hw/ppc/prep.c                              |  4 +-
>  hw/scsi/lsi53c895a.c                       |  6 +-
>  hw/sh4/r2d.c                               | 16 ++--
>  hw/usb/dev-bluetooth.c                     |  2 +-
>  hw/usb/dev-hid.c                           |  6 +-
>  hw/usb/dev-hub.c                           | 14 ++--
>  hw/xen/xen_devconfig.c                     |  2 +-
>  hw/xenpv/xen_domainbuild.c                 |  8 +-
>  include/elf.h                              | 10 +--
>  include/hw/acpi/acpi.h                     | 14 ++--
>  include/hw/elf_ops.h                       |  2 +-
>  include/hw/ide/internal.h                  |  2 +-
>  include/hw/sh4/sh_intc.h                   | 20 ++---
>  include/hw/xen/io/ring.h                   |  4 +-
>  include/qemu/acl.h                         | 14 ++--
>  include/qemu/iov.h                         |  2 +-
>  include/scsi/constants.h                   |  2 +-
>  include/sysemu/balloon.h                   |  2 +-
>  linux-user/linuxload.c                     | 14 ++--
>  linux-user/main.c                          |  4 +-
>  linux-user/mmap.c                          | 10 +--
>  linux-user/qemu.h                          |  4 +-
>  linux-user/signal.c                        | 16 ++--
>  linux-user/strace.c                        |  4 +-
>  linux-user/uaccess.c                       |  2 +-
>  linux-user/vm86.c                          |  2 +-
>  nbd/client.c                               |  2 +-
>  net/checksum.c                             |  2 +-
>  qtest.c                                    |  4 +-
>  target/alpha/translate.c                   |  2 +-
>  target/cris/helper.c                       |  2 +-
>  target/cris/mmu.h                          | 10 +--
>  target/cris/translate_v10.inc.c            |  2 +-
>  target/i386/translate.c                    | 12 +--
>  target/mips/translate.c                    |  2 +-
>  target/tilegx/translate.c                  |  2 +-
>  tcg/i386/tcg-target.inc.c                  |  4 +-
>  tests/tcg/alpha/test-cond.c                |  4 +-
>  tests/tcg/arm/hello-arm.c                  | 20 ++---
>  tests/tcg/cris/check_glibc_kernelversion.c |  8 +-
>  tests/tcg/cris/check_mmap3.c               |  2 +-
>  tests/tcg/cris/check_openpf1.c             |  2 +-
>  tests/tcg/cris/check_settls1.c             |  2 +-
>  tests/tcg/i386/hello-i386.c                | 14 ++--
>  tests/tcg/mips/hello-mips.c                | 10 +--
>  tests/tcg/multiarch/sha1.c                 | 12 +--
>  tests/vhost-user-test.c                    |  4 +-
>  ui/keymaps.h                               |  4 +-
>  ui/qemu-pixman.c                           |  2 +-
>  ui/vnc-enc-zywrle-template.c               |  4 +-
>  ui/vnc.c                                   |  4 +-
>  util/bitops.c                              |  4 +-
>  util/osdep.c                               |  4 +-
>  util/qemu-sockets.c                        |  4 +-
>  94 files changed, 388 insertions(+), 388 deletions(-)

Block parts:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcE8k7AAoJEJykq7OBq3PIllsH/jeHnhoXQNzsW/s1Lfdw1dF9
XQceJGlfbYuejNEJ0NUw3EWjyWkcAfq539GBQX3nRyhA3AtLWW9eBYrUc90Ec0F0
Oh+WVUHNcCT/lO92Y3toCGuH6HXNJ5mESZ+ZTgDwvZ9xG6c+YlZDEfqdzVXjwl/b
IT2SAfffSJG1wARCeKWL3uu4G3tN1dABICNMN0hne8hOT3C19lNvLjruprMkkqrB
p50L1WJ13E8ckcp+ITjQmSCZznmANKmvCUbmGOnRO/jUkKwoaS64okIfUVc1biPd
NrbBiJKZIWuRhXVHisU5TRj4K5o4nZXnYva8R19qgj2jmGRa20y65kCYoalTOd4=
=uq7T
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
