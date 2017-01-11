Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRMEt-00079N-5O
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRMEr-0003Gq-A3
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:59:07 -0500
MIME-Version: 1.0
In-Reply-To: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 17:58:40 +0100
Message-ID: <CACXAS8AGTGJ-3yEzf9gzOmfRfppL2REmTyB2SAkb3Nd8eyVYig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] ppc: add a IBM 40p machine (RS/6000,
 PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Giancarlo Teodori <gteodori@gmail.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi Herv=C3=A9,

nice work!

On Thu, Dec 29, 2016 at 11:12 PM, Herv=C3=A9 Poussineau <hpoussin@reactos.o=
rg> wrote:
> Hi,
>
> This patchset adds the emulation of the IBM RS/6000 7020 (40p). The real =
machine is
> able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta of OS=
/2 PowerPC,
> Solaris, Linux, NetBSD/PReP ...
>
> I've tested current emulation with Open Hack'Ware, OpenBIOS and official =
firmware.
>
> Linux kernel starts, and freezes during boot (like with 'prep' machine).

If prep can't do it anymore, it looks like a regression. I definitely
remember seen a sitting penguin and a login prompt ~ 2 years ago. At
least with OFW.

> Windows NT starts up to the point where it wants to change endianness.

I hit that with Solaris/PPC a few years back as you published your
previous attempt. Do you know what is missing? I guess CPU endianness
switch emulation is working because it is used in the newer POWER
CPUs. Is it just the systemIO which has to be improved, or is it more?

> Other OSes have not been tested.
>
> This machine is a superset of the 'prep' one, because we know exactly wha=
t is/should
> emulated, and that operating system list running on it is quite wide.
> I hope that 'prep' machine can be deprecated soon and then later removed.

Would be nice to keep 'prep' until the 40p can boot Linux and NetBSD
6.1.3 (this version used to work with -M prep last time I checked).

Artyom

> Patches 1 to 3 are cleanups, and can probably be committed first.
> Patches 4 to 6 are the real implementation of the IBM 40p.
>
> Herv=C3=A9 Poussineau (6):
>   pci: add pci_vga_type(), giving the device name of the chosen VGA
>     device
>   vga: increase priority of 0xa0000 memory region
>   prep: do not use global variable to access nvram
>   prep: QOM'ify System I/O
>   prep: add IBM RS/6000 7020 (40p) memory controller
>   prep: add IBM RS/6000 7020 (40p) machine emulation
>
>  default-configs/ppc-softmmu.mak |   2 +
>  hw/display/vga.c                |   2 +-
>  hw/pci/pci.c                    |  22 ++-
>  hw/ppc/Makefile.objs            |   2 +
>  hw/ppc/prep.c                   | 235 ++++++++++++++++++++++++++++++-
>  hw/ppc/prep_systemio.c          | 302 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/rs6000_mc.c              | 232 ++++++++++++++++++++++++++++++
>  hw/ppc/trace-events             |  11 ++
>  include/hw/pci/pci.h            |   1 +
>  9 files changed, 800 insertions(+), 9 deletions(-)
>  create mode 100644 hw/ppc/prep_systemio.c
>  create mode 100644 hw/ppc/rs6000_mc.c
>
> --
> 2.1.4
>
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
