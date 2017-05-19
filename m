Received: from eggs.gnu.org ([2001:4830:134:3::10]:51977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBg2Q-0008N1-Hv
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBg2M-0002lI-Jj
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:55632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBg2M-0002l5-BP
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBg2K-0005lK-C9
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 11:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5ACE82E8050
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 11:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 11:10:42 -0000
From: Owen Tuz <1034423@bugs.launchpad.net>
Reply-To: Bug 1034423 <1034423@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120808150403.6400.41896.malonedeb@chaenomeles.canonical.com>
	<149518950523.12634.14889487151077938980.malone@gac.canonical.com>
Message-Id: <CA+1c7PYW1JroD1m3noiqc8mqFCKg8UQB-ZZY7jyw3teLXzgBJA@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1034423] Re: Guests running OpenIndiana (and
 relatives) fail to boot on AMD hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an old ticket! I had completely forgotten about it, but will test
when I get a chance and let you know.

Cheers,

Owen

On Fri, May 19, 2017 at 11:25 AM, Thomas Huth <1034423@bugs.launchpad.net>
wrote:

> Triaging old bug tickets ... can you still reproduce this issue with the
> latest version of QEMU (currently v2.9)?
>
> ** Changed in: qemu
>        Status: New =3D> Incomplete
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1034423
>
> Title:
>   Guests running OpenIndiana (and relatives) fail to boot on AMD
>   hardware
>
> Status in QEMU:
>   Incomplete
>
> Bug description:
>   First observed with OpenSolaris 2009.06, and also applies to the
>   latest OpenIndiana release.
>
>   Version: qemu-kvm 1.1.1
>
>   Hardware:
>
>   2 x AMD Opteron 6128 8-core processors, 64GB RAM.
>
>   These guests boot on equivalent Intel hardware.
>
>   To reproduce:
>
>   qemu-kvm -nodefaults -m 512 -cpu host -vga cirrus -usbdevice tablet
>   -vnc :99 -monitor stdio -hda drive.img -cdrom oi-dev-
>   151a5-live-x86.iso -boot order=3Ddc
>
>   I've tested with "-vga std" and various different emulated CPU types,
>   to no effect.
>
>   What happens:
>
>   GRUB loads, and offers multiple boot options, but none work. Some kind
>   of kernel panic flies by very fast before restarting the VM, and
>   careful use of the screenshot button reveals that it reads as follows:
>
>   panic[cpu0]/thread=3Dfec22de0: BAD TRAP: type=3D8 (#df Double fault)
>   rp=3Dfec2b48c add r=3D0
>
>   #df Double fault
>   pid=3D0, pc=3D0xault
>   pid=3D0, pc=3D0xfe800377, sp=3D0xfec40090, eflags=3D0x202
>   cr0: 80050011<pg,wp,et,pe> cr4:b8<pge,pae,pse,de>
>   cr2: 0cr3: ae2f000
>                 gs:            1b0    fs:              0   es:
>  160   ds:          160
>                edi:                0  esi:              0 ebp:
>  0 esp: fec2b4c4
>                ebx: c0010015 edx:              0 ecx:             0 eax:
> fec40400
>                trp:                 8  err:              0 eip: fe800377
> cs:           158
>                efl:             202 usp: fec40090  ss:           160
>   tss.tss_link:     0x0
>   tss.tss_esp0:   0x0
>   tss.tss_ss0:     0x160
>   tss.tss_esp1:   0x0
>   tss.tss_ss1:      0x0
>   tss.tss esp2:     0x0
>   tss.tss_ss2:      0x0
>   tss.tss_cr3:       0xae2f000
>   tss.tss_eip:       0xfec40400
>   tss.tss_eflags:  0x202
>   tss.tss_eax:      0xfec40400
>   tss.tss_ebx:      0xc0010015
>   tss.tss_ecx:      0xc0010000
>   tss.tss_edx:      0x0
>   tss.tss_esp:      0xfec40090
>
>   Warning - stack not written to the dumpbuf
>   fec2b3c8 unix:due+e4 (8, fec2b48c, 0, 0)
>   fec2b478 unix:trap+12fa (fec2b48c, 0, 0)
>   fec2b48c unix:_cmntrap+7c (1b0, 0, 160, 160, 0)
>
>   If there's any more, I haven't managed to catch it.
>
>   Solaris 11 does not seem to suffer from the same issue, although the
>   first message that appears at boot (after the version info) is "trap:
>   Unkown trap type 8 in user mode". Could be related?
>
>   As always, thanks in advance and please let me know if I can help to
>   test, or provide any more information.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1034423/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1034423

Title:
  Guests running OpenIndiana (and relatives) fail to boot on AMD
  hardware

Status in QEMU:
  Incomplete

Bug description:
  First observed with OpenSolaris 2009.06, and also applies to the
  latest OpenIndiana release.

  Version: qemu-kvm 1.1.1

  Hardware:

  2 x AMD Opteron 6128 8-core processors, 64GB RAM.

  These guests boot on equivalent Intel hardware.

  To reproduce:

  qemu-kvm -nodefaults -m 512 -cpu host -vga cirrus -usbdevice tablet
  -vnc :99 -monitor stdio -hda drive.img -cdrom oi-dev-
  151a5-live-x86.iso -boot order=3Ddc

  I've tested with "-vga std" and various different emulated CPU types,
  to no effect.

  What happens:

  GRUB loads, and offers multiple boot options, but none work. Some kind
  of kernel panic flies by very fast before restarting the VM, and
  careful use of the screenshot button reveals that it reads as follows:

  panic[cpu0]/thread=3Dfec22de0: BAD TRAP: type=3D8 (#df Double fault)
  rp=3Dfec2b48c add r=3D0

  #df Double fault
  pid=3D0, pc=3D0xault
  pid=3D0, pc=3D0xfe800377, sp=3D0xfec40090, eflags=3D0x202
  cr0: 80050011<pg,wp,et,pe> cr4:b8<pge,pae,pse,de>
  cr2: 0cr3: ae2f000
                gs:            1b0    fs:              0   es:         160 =
  ds:          160
               edi:                0  esi:              0 ebp:             =
0 esp: fec2b4c4
               ebx: c0010015 edx:              0 ecx:             0 eax: fe=
c40400
               trp:                 8  err:              0 eip: fe800377  c=
s:           158
               efl:             202 usp: fec40090  ss:           160
  tss.tss_link:     0x0
  tss.tss_esp0:   0x0
  tss.tss_ss0:     0x160
  tss.tss_esp1:   0x0
  tss.tss_ss1:      0x0
  tss.tss esp2:     0x0
  tss.tss_ss2:      0x0
  tss.tss_cr3:       0xae2f000
  tss.tss_eip:       0xfec40400
  tss.tss_eflags:  0x202
  tss.tss_eax:      0xfec40400
  tss.tss_ebx:      0xc0010015
  tss.tss_ecx:      0xc0010000
  tss.tss_edx:      0x0
  tss.tss_esp:      0xfec40090

  Warning - stack not written to the dumpbuf
  fec2b3c8 unix:due+e4 (8, fec2b48c, 0, 0)
  fec2b478 unix:trap+12fa (fec2b48c, 0, 0)
  fec2b48c unix:_cmntrap+7c (1b0, 0, 160, 160, 0)

  If there's any more, I haven't managed to catch it.

  Solaris 11 does not seem to suffer from the same issue, although the
  first message that appears at boot (after the version info) is "trap:
  Unkown trap type 8 in user mode". Could be related?

  As always, thanks in advance and please let me know if I can help to
  test, or provide any more information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1034423/+subscriptions
