Received: from eggs.gnu.org ([2001:4830:134:3::10]:41451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTFoh-0004gb-N4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTFoe-0001Qw-Jn
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:31:55 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:49334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cTFoe-0001Q2-DO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:31:52 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 23:31:39 +0100
Message-Id: <20170116223140.18634-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: Update sh4 syscall definitions to
 match Linux 4.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Hi!

While setting up a fresh Debian unstable sh4 chroot with qemu-sh4-user, I
noticed the syscall definition table for sh4 is not up to date:

Setting up dh-strip-nondeterminism (0.029-2) ...
Setting up libgdk-pixbuf2.0-dev (2.36.3-1) ...
Setting up systemd (232-8) ...
qemu: Unsupported syscall: 373
Created symlink /etc/systemd/system/getty.target.wants/getty@tty1.service → /lib/systemd/system/getty@.service.
qemu: Unsupported syscall: 373
Created symlink /etc/systemd/system/multi-user.target.wants/remote-fs.target → /lib/systemd/system/remote-fs.target.
qemu: Unsupported syscall: 373
Created symlink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service → /lib/systemd/system/systemd-timesyncd.service.
Initializing machine ID from D-Bus machine ID.
addgroup: The group `systemd-journal' already exists as a system group. Exiting.
qemu: Unsupported syscall: 373
Setting up libgnome-keyring-dev (3.12.0-1) ...
Setting up libharfbuzz-dev:sh4 (1.2.7-1+b1) ...
Setting up dh-python (2.20160818) ...

This patch updates the syscall definition table to match kernel 4.8 which
had syscalls 369 through 382 added.

Cheers,
Adrian
