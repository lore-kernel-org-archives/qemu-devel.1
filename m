Received: from eggs.gnu.org ([2001:4830:134:3::10]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dbDdO-0007Ay-L1
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dbDdN-0007zZ-Mk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:21:26 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dbDdN-0007yN-FI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:21:25 -0400
Received: by mail-wm0-x244.google.com with SMTP id t138so10040982wmt.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 15:21:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1501280035.git.alistair.francis@xilinx.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jul 2017 15:20:53 -0700
Message-ID: <CAKmqyKOX+Y4YPvPZQRUQ3GZioV2HpvbxAFHtct4te1oKjk0_=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] More warning reporting fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Jul 28, 2017 at 3:14 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> This series expands on my previous series by converting more existing
> prints to use warn_report() instead of error_report() or fprintf().
>
> V2:
>  - Fixup auto CC logic so everyone is CCed

+ Markus who got dropped off the cover letter

Thanks,
Alistair

>
> Alistair Francis (5):
>   hw/i386: Improve some of the warning messages
>   Convert remaining error_report() to warn_report()
>   Convert single line fprintf() to warn_report()
>   Convert multi-line fprintf() to warn_report()
>   Convert single line fprintf() to warn_report()
>
>  accel/kvm/kvm-all.c         |  7 +++----
>  block/qcow2.c               | 10 +++++-----
>  block/vvfat.c               |  8 +++++---
>  hw/acpi/core.c              | 10 +++++-----
>  hw/arm/vexpress.c           |  4 ++--
>  hw/i386/acpi-build.c        | 15 ++++++++++-----
>  hw/i386/pc.c                |  9 ++++-----
>  hw/i386/pc_q35.c            |  8 +++++---
>  hw/i386/xen/xen-mapcache.c  |  4 ++--
>  hw/mips/mips_malta.c        |  4 ++--
>  hw/mips/mips_r4k.c          |  6 +++---
>  hw/misc/applesmc.c          |  2 +-
>  hw/s390x/s390-virtio.c      | 16 ++++++++--------
>  hw/usb/hcd-ehci.c           |  5 +++--
>  hw/virtio/virtio-balloon.c  |  3 ++-
>  net/hub.c                   | 12 ++++++------
>  net/net.c                   | 14 +++++++-------
>  net/socket.c                |  7 +++++--
>  qga/vss-win32.c             |  2 +-
>  target/i386/cpu.c           | 12 ++++++------
>  target/i386/hax-mem.c       |  6 +++---
>  target/mips/kvm.c           |  4 ++--
>  target/ppc/translate_init.c | 18 +++++++++---------
>  target/s390x/kvm.c          |  4 ++--
>  tests/Makefile.include      |  4 ++--
>  trace/control.c             |  4 ++--
>  trace/simple.c              |  2 +-
>  ui/keymaps.c                | 11 ++++++-----
>  ui/spice-display.c          |  2 +-
>  util/cutils.c               |  3 ++-
>  util/main-loop.c            |  6 +++---
>  31 files changed, 118 insertions(+), 104 deletions(-)
>
> --
> 2.11.0
>
