Received: from eggs.gnu.org ([2001:4830:134:3::10]:59323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1cqeAL-0005hP-3L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1cqeAJ-0004y0-Op
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:10:57 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1cqeAJ-0004xr-J9
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:10:55 -0400
Received: by mail-io0-x236.google.com with SMTP id z13so63972886iof.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 04:10:55 -0700 (PDT)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 22 Mar 2017 12:10:53 +0100
Message-ID: <CABLmASG4Fmf7KbzDBmqoZMJcViLG+HB=2HHki=YcsFfHn+UgRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Bug: qemu-system-ppc in Fedora 25 and Windows 10 hangs
 and/or shows video driver related errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi,

2.9 RC1 builds of qemu-system-ppc for Linux and Windows 10 running Mac
OS 9 or OSX 10.3 hang/throw errors when using the SDL2 gui. This does
not happen when using the GTK gui.

Linux build compiled with:
./configure --target-list=ppc-softmmu --enable-sdl --with-sdlabi=2.0
--enable-gtk --with-gtk-abi=3.0

Windows build (cross-compile from fedora 25) compiled with:
./configure --cross-prefix=x86_64-w64-mingw32-
--target-list="ppc-softmmu" --enable-gtk --with-gtkabi=3.0
--enable-sdl --with-sdlabi=2.0

The windows build simply hangs at the SDL window showing the guest has
not initialised the display (yet).

Here is an example of the output in the command window (Fedora 25,
using the nouveau video driver)

nouveau: kernel rejected pushbuf: No such file or directory
nouveau: ch10: krec 0 pushes 0 bufs 1 relocs 0
nouveau: ch10: buf 00000000 00000002 00000004 00000004 00000000
nouveau: kernel rejected pushbuf: No such file or directory
nouveau: ch10: krec 0 pushes 2 bufs 15 relocs 0
nouveau: ch10: buf 00000000 00000002 00000004 00000004 00000000
nouveau: ch10: buf 00000001 00000006 00000004 00000000 00000004
nouveau: ch10: buf 00000002 00000012 00000002 00000000 00000002
nouveau: ch10: buf 00000003 0000000d 00000004 00000004 00000000
nouveau: ch10: buf 00000004 0000001a 00000002 00000002 00000002
nouveau: ch10: buf 00000005 0000000e 00000004 00000004 00000000
nouveau: ch10: buf 00000006 00000008 00000002 00000002 00000002
nouveau: ch10: buf 00000007 00000002 00000004 00000004 00000000
nouveau: ch10: buf 00000008 00000007 00000002 00000002 00000000
nouveau: ch10: buf 00000009 0000000b 00000002 00000002 00000000
nouveau: ch10: buf 0000000a 0000000a 00000002 00000002 00000002
nouveau: ch10: buf 0000000b 00000006 00000004 00000000 00000004
nouveau: ch10: buf 0000000c 0000001b 00000002 00000000 00000002
nouveau: ch10: buf 0000000d 0000001c 00000002 00000000 00000002
nouveau: ch10: buf 0000000e 0000000c 00000004 00000004 00000000
nouveau: ch10: psh 00000000 0000072f48 0000072fd8
nouveau:     0x20056080
nouveau:     0x000000d5
nouveau:     0x00000000
nouveau:     0x00000040
nouveau:     0x00000001
nouveau:     0x00000000
nouveau:     0x20046086
nouveau:     0x00000280
nouveau:     0x00000180
nouveau:     0x00000000
nouveau:     0x01f80000
nouveau:     0x2002608c
nouveau:     0x000000cf
nouveau:     0x00000001
nouveau:     0x20056091
nouveau:     0x00000a00
nouveau:     0x00000280
nouveau:     0x00000180
nouveau:     0x00000000
nouveau:     0x019c0000
nouveau:     0x80006223
nouveau:     0x2004622c
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000280
nouveau:     0x00000180
nouveau:     0x20046230
nouveau:     0x00000000
nouveau:     0x00000001
nouveau:     0x00000000
nouveau:     0x00000001
nouveau:     0x20046234
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau: ch10: psh 00000007 0000072fd8 0000073168
nouveau:     0x20056080
nouveau:     0x000000d5
nouveau:     0x00000000
nouveau:     0x00000040
nouveau:     0x00000001
nouveau:     0x00000000
nouveau:     0x20046086
nouveau:     0x00000320
nouveau:     0x00000258
nouveau:     0x00000000
nouveau:     0x02980000
nouveau:     0x2002608c
nouveau:     0x000000cf
nouveau:     0x00000001
nouveau:     0x20056091
nouveau:     0x00000c80
nouveau:     0x00000320
nouveau:     0x00000258
nouveau:     0x00000000
nouveau:     0x02b80000
nouveau:     0x80006223
nouveau:     0x2004622c
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000320
nouveau:     0x00000258
nouveau:     0x20046230
nouveau:     0x00000000
nouveau:     0x00000001
nouveau:     0x00000000
nouveau:     0x00000001
nouveau:     0x20046234
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x200308e0
nouveau:     0x00000100
nouveau:     0x00000000
nouveau:     0x00360000
nouveau:     0xa01108e3
nouveau:     0x00000000
nouveau:     0x3b23d70a
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0xbb5a740e
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0xc0000000
nouveau:     0x00000000
nouveau:     0xbf800000
nouveau:     0x3f800000
nouveau:     0xbf800000
nouveau:     0x3f800000
nouveau:     0x200308e0
nouveau:     0x00000100
nouveau:     0x00000000
nouveau:     0x003a0000
nouveau:     0xa00508e3
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x00000000
nouveau:     0x20030700
nouveau:     0x00001010
nouveau:     0x00000000
nouveau:     0x01943bc8
nouveau:     0x200207c0
nouveau:     0x00000000
nouveau:     0x0194ffff
nouveau:     0x20030708
nouveau:     0x00001010
nouveau:     0x00000000
nouveau:     0x01943bc0
nouveau:     0x200207c4
nouveau:     0x00000000
nouveau:     0x0194ffff
nouveau:     0x20050453
nouveau:     0x00074401
nouveau:     0x3f800000
nouveau:     0x3f800000
nouveau:     0x3f800000
nouveau:     0x3f800000
nouveau:     0x8000050b
nouveau:     0x20010586
nouveau:     0x00000005
nouveau:     0x2002035d
nouveau:     0x00000000
nouveau:     0x00000004
nouveau:     0x80000585
nouveau:     0x200406c0
nouveau:     0x00000000
nouveau:     0x00238000
nouveau:     0x000004e0
nouveau:     0x1000f010
./startqemu.sh: line 1:  2365 Segmentation fault      (core dumped)
./qemu-system-ppc -L pc-bios -boot c -M mac99 -prom-env "boot-args=-v"
-m 256 -drive file=~/Mac-disks/10.3Panther_6gb.img,format=raw,media=disk
-sdl

Best,
Howard
