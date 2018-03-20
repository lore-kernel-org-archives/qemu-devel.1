Received: from eggs.gnu.org ([2001:4830:134:3::10]:44235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eyKnS-0006Qy-3v
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eyKnR-0006fz-7H
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:11:38 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:34285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eyKnR-0006f1-2P
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:11:37 -0400
Received: by mail-ot0-x22a.google.com with SMTP id m7-v6so2554768otd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 10:11:36 -0700 (PDT)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 20 Mar 2018 18:11:35 +0100
Message-ID: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Bug AioContext polling is not implemented on Windows
 with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Hi,

I just built qemu-system-ppc.exe for windows using a fully up-to-date Fedora 27.
Command line for build:

./configure --cross-prefix=x86_64-w64-mingw32-
--target-list="ppc-softmmu ppc64-softmmu" --enable-gtk
--with-gtkabi=3.0 --enable-sdl --with-sdlabi=2.0

Command line to invoke Qemu:
C:\qemu-master>qemu-system-ppc.exe -L pc-bios -boot c -m 256 -M mac99
-prom-env "boot-args=-v" -prom-env "auto-boot?=true" -prom-env
"vga-ndrv?=true"  -drive
file=c:\Mac-disks\9.1.img,format=raw,media=disk -netdev
user,id=network01 -device
sungem,netdev=network01,mac=52:54:00:12:34:66 -sdl -device usb-kbd
-device usb-mouse

Error:
Unexpected error in aio_context_set_poll_params() at util/aio-win32.c:413:
qemu-system-ppc.exe: AioContext polling is not implemented on Windows

Best,
Howard
