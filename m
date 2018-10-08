Received: from eggs.gnu.org ([2001:4830:134:3::10]:34751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g9bhu-0005as-Rv
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g9bhr-00042m-L8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:00:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g9bhr-00042J-D0
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:00:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g9bhq-0004eS-B7
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 20:00:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 31FBC2E80C0
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 20:00:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Oct 2018 19:44:02 -0000
From: Ke Liu <1796754@bugs.launchpad.net>
Reply-To: Bug 1796754 <1796754@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153902784309.8245.8166003544722634075.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1796754] [NEW] ioctl SIOCGIFCONF causes
 qemu-aarch64-static to crash with "received signal outside vCPU context"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

To reproduce it, compile the attached crash.c under aarch64 to a.out and ex=
ecute on x86_64
qemu-aarch64-static ./a.out

It will print the following and crash:

socket=3D3
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x60038c=
d6
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x600015=
7a

The version of qemu-aarch64-static is

qemu-aarch64 version 3.0.0 (qemu-3.0.0-1.fc29)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

But it did also happen in previous versions so it is not a regression
but a bug existed ever since.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: aarch64 arm linux-user qemu

** Attachment added: "crash.c"
   https://bugs.launchpad.net/bugs/1796754/+attachment/5198861/+files/crash=
.c

** Tags added: aarch64

** Tags added: linux-user qemu

** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1796754

Title:
  ioctl SIOCGIFCONF causes qemu-aarch64-static to crash with "received
  signal outside vCPU context"

Status in QEMU:
  New

Bug description:
  To reproduce it, compile the attached crash.c under aarch64 to a.out and =
execute on x86_64
  qemu-aarch64-static ./a.out

  It will print the following and crash:

  socket=3D3
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6003=
8cd6
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6000=
157a

  The version of qemu-aarch64-static is

  qemu-aarch64 version 3.0.0 (qemu-3.0.0-1.fc29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  But it did also happen in previous versions so it is not a regression
  but a bug existed ever since.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1796754/+subscriptions
