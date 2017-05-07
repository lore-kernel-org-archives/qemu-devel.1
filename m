Received: from eggs.gnu.org ([2001:4830:134:3::10]:46791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7EyG-0001vw-7O
	for qemu-devel@nongnu.org; Sun, 07 May 2017 01:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7EyF-00066L-84
	for qemu-devel@nongnu.org; Sun, 07 May 2017 01:43:04 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:34317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7EyF-00065G-1h
	for qemu-devel@nongnu.org; Sun, 07 May 2017 01:43:03 -0400
Received: by mail-qt0-x22d.google.com with SMTP id j29so30427290qtj.1
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 22:43:02 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
From: Carl Karsten <carl@personnelware.com>
Date: Sun, 7 May 2017 00:42:31 -0500
Message-ID: <CADmzSSjY4n7bBBUVk45=_SRSj74AkSpN3O1d61Cik1q-eDiHKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] boot order=d bug?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the real world I will have a machine with a sata hd and boot the
installer from a usb stick. I want to test this with 2 disk image files.

The usb stick will be built like so:
https://github.com/CarlFK/video-stack-deploy/blob/usbstick/scripts/mk_usb_installer.sh

but this will demo the problem I have run into with qemu:  how do I boot
from boot.img without using boot=menu?

# make a blank disk to install to
qemu-img create -f qcow2 disk.cow 8G

# get an installer image
wget
http://ftp.debian.org/debian/dists/stretch/main/installer-amd64/current/images/hd-media/boot.img.gz
gunzip boot.img.gz

qemu-system-x86_64 -m 256 -display curses  \
    -drive file=disk.cow,index=0 \
    -drive file=boot.img,index=1 \
    -boot menu=on

# Hit esc and then #2 to boot the installer.

Press ESC for boot menu.
Select boot device:
1. ata0-0: QEMU HARDDISK ATA-7 Hard-Disk (8192 MiBytes)
2. ata0-1: QEMU HARDDISK ATA-7 Hard-Disk (953 MiBytes)
3. Legacy option rom
4. Floppy [drive A]
5. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
6. iPXE (PCI 00:03.0)


juser@gator:~/temp/video-stack-deploy/scripts$ qemu-system-x86_64 -version
QEMU emulator version 2.8.1(Debian 1:2.8+dfsg-4+b1)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers


-- 
Carl K
