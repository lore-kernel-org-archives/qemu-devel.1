Received: from eggs.gnu.org ([2001:4830:134:3::10]:48326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1etY05-0002br-3u
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1etY03-0004Sx-Ay
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:16:53 -0500
From: luigi burdo <intermediadc@hotmail.com>
Date: Wed, 7 Mar 2018 12:16:42 +0000
Message-ID: <DB7P194MB0378C28B4B253292D3248BC2C8D80@DB7P194MB0378.EURP194.PROD.OUTLOOK.COM>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>,
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
In-Reply-To: <fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

HI,

i had test last git with Zoltan sam emultation but at start i recive this


./qemu-system-ppc -M sam460ex
qemu-system-ppc: /home/gigi/src/tags/ppc-for-2.12-20180306/include/qemu/rcu=
.h:89: rcu_read_unlock: asserzione "p_rcu_reader->depth !=3D 0" non riuscit=
a.
Annullato (core dump creato)


My machie is a Threadripper 1950x the distro is Ubuntu mate 17.10


Thanks

Luigi


________________________________
Da: Qemu-ppc <qemu-ppc-bounces+intermediadc=3Dhotmail.com@nongnu.org> per c=
onto di Thomas Huth <thuth@redhat.com>
Inviato: marted=EC 6 marzo 2018 17:48
A: David Gibson; Mark Cave-Ayland
Cc: qemu-ppc@nongnu.org; qemu-devel@nongnu.org
Oggetto: Re: [Qemu-ppc] [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 201803=
06

On 06.03.2018 05:01, David Gibson wrote:
> The following changes since commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a5=
62:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-05 16:41:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180306
>
> for you to fetch changes up to 21b786f607b11d888f90bbb8c3414500515d11e7:
>
>   PowerPC: Add TS bits into msr_mask (2018-03-06 13:16:29 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-03-06
>
> This pull request supersedes ppc-for-2.12-20180302 which had compile
> problems with some gcc versions.  It also contains a few additional
> patches.
>
> Highlights are:
>     * New Sam460ex machine type
>     * Yet more fixes related to vcpu id allocation for spapr
>     * Numerous macio cleanupsr
>     * Some enhancements to the Spectre/Meltdown fixes for pseries,
>       allowing use of a better mitigation for indirect branch based
>       exploits
>     * New pseries machine types with Spectre/Meltdown mitigations
>       enabled (stop gap until libvirt and management understands the
>       machine options)
>     * A handful of other fixes
>
> ----------------------------------------------------------------
> BALATON Zoltan (5):
>       ppc440_uc: Fix unintialized variable warning with older gcc
>       ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
>       roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
>       pc-bios: Added u-boot-sam460 firmware binary
>       ppc: Add aCube Sam460ex board
>
> David Engraf (1):
>       PPC: e500: Fix duplicate kernel load and device tree overlap
>
> Greg Kurz (3):
>       spapr: fix missing CPU core nodes in DT when running with TCG
>       spapr: register dummy ICPs later
>       spapr: harden code that depends on VSMT
>
> Mark Cave-Ayland (13):
>       macio: embed DBDMA device directly within macio
>       macio: move ESCC device within the macio device
>       heathrow: QOMify heathrow PIC
>       heathrow: convert to trace-events
>       heathrow: change heathrow_pic_init() to return the heathrow device
>       macio: move macio related structures and defines into separate maci=
o.h file
>       mac_oldworld: use object link to pass heathrow PIC object to macio
>       openpic: move KVM-specific declarations into separate openpic_kvm.h=
 file
>       openpic: move OpenPIC state and related definitions to openpic.h
>       mac_newworld: use object link to pass OpenPIC object to macio
>       macio: move setting of CUDA timebase frequency to macio_common_real=
ize()
>       macio: remove macio_init() function
>       adb: add trace-events for monitoring keyboard/mouse during bus enum=
eration

Something in the recent commits introduced a new way to cause unexpected
aborts of QEMU:

$ ppc64-softmmu/qemu-system-ppc64 -monitor stdio
QEMU 2.11.50 monitor - type 'help' for more information
(qemu) device_add macio-newworld
Unexpected error in qemu_chr_fe_init() at
/home/thuth/devel/qemu/chardev/char-fe.c:222:
Device 'serial0' is in use
Aborted (core dumped)

Of course it does not make sense to add a macio-newworld device on the
pseries machine, but QEMU should not abort in this case - it should just
print an error message and continue afterwards. Any ideas how to fix this?

 Thomas
