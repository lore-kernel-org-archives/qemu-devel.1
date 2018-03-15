Received: from eggs.gnu.org ([2001:4830:134:3::10]:33225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewVEQ-0004F3-5t
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewVEN-00037p-Kg
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:55:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:42964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewVEN-00034j-F8
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:55:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewVEJ-0000Zu-Fr
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 15:55:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B5E392E80E5
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 15:55:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 15:42:52 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1756080 <1756080@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152112215198.15095.6439554295431781559.malonedeb@chaenomeles.canonical.com>
Message-Id: <152112857204.3625.17450275113242525009.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756080] Re: QEMU does not provide non-Linux
 kernels with ATAGS structure on ARM targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU doesn't care whether the kernel you provide it is Linux or
something else. If you pass -kernel something that's not an ELF file,
we'll load and boot it using the Linux boot protocol (including ATAGS,
potentially). If you pass an ELF file or pass -bios a binary blob, we'll
just start it in the way the CPU usually resets, on the assumption it
can deal with whatever that is.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756080

Title:
  QEMU does not provide non-Linux kernels with ATAGS structure on ARM
  targets

Status in QEMU:
  New

Bug description:
  This would be a useful feature. Many kernels, particularly hobbyist
  kernels, have support for ATAGS.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756080/+subscriptions
