Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eFFHN-0001or-LQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eFFHJ-0007tI-Kf
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:12:09 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:37217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1eFFHJ-0007s1-Bj
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:12:05 -0500
Received: by mail-it0-x231.google.com with SMTP id m191so4941063itg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 00:12:04 -0800 (PST)
MIME-Version: 1.0
Sender: vase@selfip.ru
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Thu, 16 Nov 2017 11:11:43 +0300
Message-ID: <CACaajQsXUMwo-bLF4q+pRjjUDn=Eo9xQ=SB9ucDX8cuP9VQzNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] sheepdog block driver and read write error policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi. I'm try to write own sheepdog compatible daemon and test it with qemu.
Sometimes ago in qemu added read write error policy to allow to stop
domain or continue or something else. As i see in case of sheepdog
this policy is ignored and qemu try to reconnect to sheepdog daemon.
If nobody wants i can try to fix this, and if policy is not specified
work like now.
Where i need to start to easy understand how this works in case of file raw ?

Also i'm fedora user with virt-preview repo and see, that if sheepdog
daemon is unavailable 2 or more minutes and started after that qemu
crashed. Does i need to retest with latest qemu version?
b2587932582333197c88bf663785b19f441989d7
f1af3251f885f3b8adf73ba078500f2eeefbedae
5eceb01adfbe513c0309528293b0b86e32a6e27d


qemu-system-x86_64 -machine q35 -accel kvm -m 512M -vnc 0.0.0.0:1
-device virtio-scsi-pci,id=scsi0 -drive
aio=native,rerror=stop,werror=stop,if=none,format=raw,id=drive-scsi-disk0,cache=none,file=sheepdog:test,discard=unmap,detect-zeroes=off
 -device scsi-hd,bus=scsi0.0,drive=drive-scsi-disk0,id=device-scsi-disk0
qemu-system-x86_64: failed to get the header, Invalid argument
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: failed to send a req, Bad file descriptor
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused
qemu-system-x86_64: Failed to connect socket: Connection refused



qemu-system-x86_64: /builddir/build/BUILD/qemu-2.9.0/util/iov.c:167:
iov_send_recv: Assertion `niov < iov_cnt' failed.
Makefile:5: recipe for target 'test' failed
make: *** [test] Aborted (core dumped)

And if someone from fedora/redhat team is present - when new qemu
version available in virt preview repo for fedora 25 or it EOL?

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
