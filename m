Received: from eggs.gnu.org ([2001:4830:134:3::10]:51401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXpEv-0004rV-9b
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXpEr-00033k-3U
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:18:57 -0500
Date: Fri, 14 Dec 2018 10:17:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181214101725-mutt-send-email-mst@kernel.org>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Fam Zheng <famz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "open list:bochs" <qemu-block@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:ppc4xx" <qemu-ppc@nongnu.org>

On Thu, Dec 13, 2018 at 11:37:37PM +0100, Paolo Bonzini wrote:
> Most files that have TABs only contain a handful of them.  Change
> them to spaces so that we don't confuse people.
> 
> disas, standard-headers, linux-headers and libdecnumber are imported
> from other projects and probably should be exempted from the check.
> Outside those, after this patch the following files still contain both
> 8-space and TAB sequences at the beginning of the line.  Many of them
> have a majority of TABs, or were initially committed with all tabs.
> 
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
> 
> The following have only TABs:
> 
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
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Seems sane:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
