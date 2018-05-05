Received: from eggs.gnu.org ([2001:4830:134:3::10]:38089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fF26x-0001wv-GC
	for qemu-devel@nongnu.org; Sat, 05 May 2018 14:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fF26u-0000wY-Do
	for qemu-devel@nongnu.org; Sat, 05 May 2018 14:40:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:57752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fF26u-0000tL-6v
	for qemu-devel@nongnu.org; Sat, 05 May 2018 14:40:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fF26s-000598-8h
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 18:40:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3B72E2E8007
	for <qemu-devel@nongnu.org>; Sat,  5 May 2018 18:40:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 May 2018 18:31:11 -0000
From: Adee <adikurthy@gmail.com>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Message-Id: <152554507157.6994.10428100184346107001.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + UEFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm seeing the same Win10 I/O stall problem with qemu 2.12, but with a vm w=
ith BIOS, not UEFI.
The solution for me is only dowgrading for now.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769189

Title:
  Issue with qemu 2.12.0 + UEFI

Status in QEMU:
  New

Bug description:
  (first reported here:
  https://bugzilla.tianocore.org/show_bug.cgi?id=3D949 )

  I had a Windows 10 VM running perfectly fine with OVMF UEFI, since I
  upgraded to qemu 2.12, the guests hangs for a couple of minutes, works
  for a few seconds, and hangs again, etc. By "hang" I mean it doesn't
  freeze, but it looks like it's waiting on IO or something, I can move
  the mouse but everything needing disk access is unresponsive.

  What doesn't work: qemu 2.12 with OVMF
  What works: using BIOS or downgrading qemu to 2.11.1.

  Platform is arch linux 4.16.7 on skylake, I have attached the vm xml
  file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769189/+subscriptions
