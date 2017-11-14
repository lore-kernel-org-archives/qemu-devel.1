Received: from eggs.gnu.org ([2001:4830:134:3::10]:43042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEbcE-00060K-3w
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEbc8-00028K-DL
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:51:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:40342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEbc8-00027G-6R
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:50:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEbc4-0002aa-Ox
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 13:50:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1E3012E80E8
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 13:50:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 13:41:49 -0000
From: Gerd Hoffmann <1713825@bugs.launchpad.net>
Reply-To: Bug 1713825 <1713825@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150404140220.18876.2468100840644103776.malonedeb@chaenomeles.canonical.com>
Message-Id: <151066690981.28431.3286003128183223092.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1713825] Re: Booting Windows 2016 with qxl video
 crashes qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Doesn't reproduce.  It's a newer driver though (10.0.0.18000).
Does updating the driver help?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1713825

Title:
  Booting Windows 2016 with qxl video crashes qemu

Status in QEMU:
  New

Bug description:
  launched from libvirt.

  qemu version: 2.9.0
  host: Linux <hostname> 4.9.34-gentoo #1 SMP Sat Jul 29 13:28:43 PDT 2017 =
x86_64 Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz GenuineIntel GNU/Linux
  guest: Windows 2016 64 bit

  Thread 28 (Thread 0x7f0e2edff700 (LWP 29860)):
  #0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.=
c:51
          set =3D {__val =3D {18446744067266837079, 139698892694944, 139699=
853745096, 139700858749789, 4222451712, 139694281220640, 139694281220741, 1=
39694281220640, 139694281220640, 139694281220810, =

              139694281220940, 139694281220640, 139694281220940, 0, 0, 0}}
          pid =3D <optimized out>
          tid =3D <optimized out>
  #1  0x00007f0ea40b644a in __GI_abort () at abort.c:89
          save_stage =3D 2
          act =3D {__sigaction_handler =3D {sa_handler =3D 0x7f0e2edfe5c0, =
sa_sigaction =3D 0x7f0e2edfe5c0}, sa_mask =3D {__val =3D {139694281219872, =
139698106269697, 139698892695344, 4, 2676511744, 0, 139698892695144, 0, =

                139698892694912, 1, 4737316546111099904, 139700859888720, 4=
737316546111099904, 139700862161824, 139700911349760, 94211934977482}}, sa_=
flags =3D 416, =

            sa_restorer =3D 0x55af6ceb0500 <__PRETTY_FUNCTION__.36381>}
          sigs =3D {__val =3D {32, 0 <repeats 15 times>}}
  #2  0x00007f0ea40abab6 in __assert_fail_base (fmt=3D<optimized out>, asse=
rtion=3Dassertion@entry=3D0x55af6ceafdca "offset < qxl->vga.vram_size", =

      file=3Dfile@entry=3D0x55af6ceaeaa0 "/var/tmp/portage/app-emulation/qe=
mu-2.9.0-r2/work/qemu-2.9.0/hw/display/qxl.c", line=3Dline@entry=3D416, =

      function=3Dfunction@entry=3D0x55af6ceb0500 <__PRETTY_FUNCTION__.36381=
> "qxl_ram_set_dirty") at assert.c:92
          str =3D 0x7f0d1c026220 "\340r\002\034\r\177"
          total =3D 4096
  #3  0x00007f0ea40abb81 in __GI___assert_fail (assertion=3Dassertion@entry=
=3D0x55af6ceafdca "offset < qxl->vga.vram_size", =

      file=3Dfile@entry=3D0x55af6ceaeaa0 "/var/tmp/portage/app-emulation/qe=
mu-2.9.0-r2/work/qemu-2.9.0/hw/display/qxl.c", line=3Dline@entry=3D416, =

      function=3Dfunction@entry=3D0x55af6ceb0500 <__PRETTY_FUNCTION__.36381=
> "qxl_ram_set_dirty") at assert.c:101
  No locals.
  #4  0x000055af6cc58805 in qxl_ram_set_dirty (qxl=3D<optimized out>, ptr=
=3D<optimized out>) at /var/tmp/portage/app-emulation/qemu-2.9.0-r2/work/qe=
mu-2.9.0/hw/display/qxl.c:416
          base =3D <optimized out>
          offset =3D <optimized out>
          qxl =3D <optimized out>
          ptr =3D <optimized out>
          base =3D <optimized out>
          offset =3D <optimized out>
  #5  0x000055af6cc5b9e2 in interface_release_resource (sin=3D0x55af71a91ed=
0, ext=3D...) at /var/tmp/portage/app-emulation/qemu-2.9.0-r2/work/qemu-2.9=
.0/hw/display/qxl.c:767
          qxl =3D 0x55af71a91450
          ring =3D <optimized out>
          item =3D <optimized out>
          id =3D 18446690739814400920
          __func__ =3D "interface_release_resource"
  #6  0x00007f0ea510afa8 in red_drawable_unref (red_drawable=3D0x7f0d1c0261=
20) at red-worker.c:101
  No locals.
  #7  0x00007f0ea510b609 in red_drawable_unref (red_drawable=3D<optimized o=
ut>) at red-worker.c:104
  No locals.
  #8  0x00007f0ea510eae9 in drawable_unref (drawable=3Ddrawable@entry=3D0x7=
f0e68285ac0) at display-channel.c:1438
          display =3D 0x55af71dbd3c0
          __FUNCTION__ =3D "drawable_unref"
  #9  0x00007f0ea51109f7 in draw_until (display=3Ddisplay@entry=3D0x55af71d=
bd3c0, surface=3Dsurface@entry=3D0x7f0e6828aae8, last=3D0x7f0e68285ac0) at =
display-channel.c:1637
          container =3D 0x0
          now =3D 0x7f0e68285ac0
  #10 0x00007f0ea510f93f in display_channel_draw (display=3D0x55af71dbd3c0,=
 area=3D0x7f0e2edfe8e0, surface_id=3D<optimized out>) at display-channel.c:=
1729
          surface =3D 0x7f0e6828aae8
          last =3D <optimized out>
          __FUNCTION__ =3D "display_channel_draw"
          __func__ =3D "display_channel_draw"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1713825/+subscriptions
