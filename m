Received: from eggs.gnu.org ([209.51.188.92]:58905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBLw-0004Rb-IE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBLu-0005Y0-NV
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBLs-0005Un-No
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBLq-0008O7-BR
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:25:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F68D2E80CC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:25:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:15:00 -0000
From: Thomas Huth <1577937@bugs.launchpad.net>
Reply-To: Bug 1577937 <1577937@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160503205253.23902.44163.malonedeb@gac.canonical.com>
Message-Id: <155608650028.13778.2698226466764645998.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1577937] Re: netbeans not working with std
 graphic driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1577937

Title:
  netbeans not working with std graphic driver

Status in QEMU:
  Incomplete

Bug description:
  Qemu Version:
  QEMU emulator version 2.5.1, Copyright (c) 2003-2008 Fabrice Bellard

  Launching VM with:
  sudo qemu-system-x86_64 -enable-kvm -m 1024M ~/guest.vm -usb -vga std

  Guest:
  Kali Linux 2016.1
  Kernel:
  4.4.0-kali1-amd64
  Affected Arch:
  64bit & 32bit

  Netbeans failing to start after netbeans splash comes up. No netbeans win=
dow is being drawn.
  Problem can be reproduced.
  It IS working with -vga qxl, so maybe there's a bug in std emulation.

  output from netbeans log (more in attachement):

  SEVERE [global]
  java.lang.RuntimeException: failed to load system cursor: DnD.Cursor.Copy=
Drop : cannot load system cursor: CopyDrop.32x32

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1577937/+subscriptions
