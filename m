Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxTqA-0004p4-DY
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxTq6-00026g-JI
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:11:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:39432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxTq6-0001P1-Ak
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:11:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxTq2-000306-9i
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 09:11:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 42C502E80C7
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 09:11:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 08:58:53 -0000
From: Thomas Huth <1496384@bugs.launchpad.net>
Reply-To: Bug 1496384 <1496384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150916130241.19267.23402.malonedeb@soybean.canonical.com>
Message-Id: <153613793402.31496.4071134463256899253.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1496384] Re: Error 0x5D in Qemu for Windows
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
with the latest version of QEMU? Have you tried "-usb -device usb-
tablet" already?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1496384

Title:
  Error 0x5D in Qemu for Windows

Status in QEMU:
  Incomplete

Bug description:
  The reason to use qemu for Windows is that the mouse in emulated Windows =
works well while it is unusable in  qemu at Ubuntu. =

  Alternative solution/bug is mouse usability in qemu for Linux.
  Well-known issue of error 0x5D when booting Win 7 x64 on qemu without kvm=
, marked as resolved at Linux.

  Used qemu for Windows downloaded from http://qemu.weilnetz.de/
  Tested on  qemu 2.3.94 64-bit and  qemu 2.4.0 32-bit.

  Options :
  qemu-system-x86_64.exe  -m 1536 -cpu qemu64,+nx,+pae,+mce,+cx8,+apic,+sep=
,+mtrr,+pge,+mca,+cmov,+pat,+pse36,+clflush,+acpi,+mmx,+fxsr,+sse,+sse2,+ss=
,+fxsr,+sse,+sse2,+ss,+de,+mtrr,+mca,+clflush
   win_7_work.qcow2

  On qemu at Ubuntu with kvm Win7 x64 works ,but mouse is unusable as
  mentioned above.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1496384/+subscriptions
