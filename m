Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drfxQ-0000GS-ES
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drfxM-0003D1-AQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:50:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drfxM-0003Cj-0d
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:50:04 -0400
References: <cover.1505158760.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfeb3c9c-72d6-8d74-9668-09ba11d73abd@redhat.com>
Date: Tue, 12 Sep 2017 09:49:53 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1505158760.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/8] More warning reporting fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 11/09/2017 21:52, Alistair Francis wrote:
> This series expands on my previous series by converting more existing
> prints to use warn_report() instead of error_report() or fprintf().
> 
> As discussed with Paolo and Markus this series combines libqemustub.a into
> libqemuutil.a to avoid circular dependencies.
> 
> V4:
>  - Improve some extra MIPs messages
>  - Fix build issues
>  - Fix i386 print message
> V3:
>  - Small corrections as reported by Markus
>  - Rename patch 3 and 5 so they don't have the same name
>  - Combine libqemustub.a into libqemuutil.a
>  - Add an extra patch with general cleanups
> 
> V2:
>  - Fixup auto CC logic so everyone is CCed
> 
> 
> 
> Alistair Francis (8):
>   hw/i386: Improve some of the warning messages
>   Convert remaining error_report() to warn_report()
>   Convert single line fprintf(.../n) to warn_report()
>   Convert multi-line fprintf() to warn_report()
>   General warn report fixups
>   target/mips: Convert VM clock update prints to warn_report
>   Makefile: Remove libqemustub.a
>   Convert remaining single line fprintf() to warn_report()
> 
>  Makefile                    |  7 +++----
>  Makefile.target             |  2 +-
>  accel/kvm/kvm-all.c         |  7 +++----
>  block/qcow2.c               |  9 +++++----
>  block/vvfat.c               |  7 ++++---
>  docs/devel/build-system.txt | 16 +++++++---------
>  hw/acpi/core.c              | 10 +++++-----
>  hw/arm/vexpress.c           |  4 ++--
>  hw/i386/acpi-build.c        | 15 ++++++++++-----
>  hw/i386/pc.c                |  9 ++++-----
>  hw/i386/pc_q35.c            |  8 +++++---
>  hw/i386/xen/xen-mapcache.c  |  5 +++--
>  hw/mips/mips_malta.c        |  4 ++--
>  hw/mips/mips_r4k.c          |  5 ++---
>  hw/misc/applesmc.c          |  2 +-
>  hw/s390x/s390-virtio.c      | 18 ++++++++++--------
>  hw/usb/hcd-ehci.c           |  5 +++--
>  hw/virtio/virtio-balloon.c  |  3 ++-
>  net/hub.c                   | 10 ++++------
>  net/net.c                   | 15 ++++++++-------
>  qga/vss-win32.c             |  2 +-
>  target/i386/cpu.c           | 12 ++++++------
>  target/i386/hax-mem.c       |  6 +++---
>  target/mips/kvm.c           | 10 +++++-----
>  target/ppc/translate_init.c | 17 ++++++++---------
>  target/s390x/kvm.c          |  4 ++--
>  tests/Makefile.include      |  8 ++++----
>  trace/control.c             |  4 ++--
>  trace/simple.c              |  3 ++-
>  ui/keymaps.c                | 10 +++++-----
>  ui/spice-display.c          |  2 +-
>  util/cutils.c               |  3 ++-
>  util/main-loop.c            |  6 +++---
>  33 files changed, 128 insertions(+), 120 deletions(-)
> 

Queued, thanks.

Paolo
