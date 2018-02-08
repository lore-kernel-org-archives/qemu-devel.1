Received: from eggs.gnu.org ([2001:4830:134:3::10]:45449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejr1q-0008ST-Kl
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejr1n-0001XL-FH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:34:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:60598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejr1n-0001Vr-99
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:34:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejr1m-00067r-E0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 18:34:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 617C32E8042
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 18:34:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 18:20:35 -0000
From: Thomas Huth <1225187@bugs.launchpad.net>
Reply-To: Bug 1225187 <1225187@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130913204828.19236.78809.malonedeb@soybean.canonical.com>
Message-Id: <151811403558.10064.758412549389367792.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1225187] Re: qemu hangs in windows 7 host with
 -serial pipe:windbg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1225187

Title:
  qemu hangs in windows 7 host with -serial pipe:windbg

Status in QEMU:
  Incomplete

Bug description:
  Execution line:
  qemu-system-i386.exe -m 512 c:\Disks\Qemu_XP_en.vhd  -serial pipe:windbg

  It waits for the pipe.
  Execute windbg
  c:\WINDDK\7600.16385.1\Debuggers\windbg.exe -k com:pipe,port=3D\\.\pipe\w=
indbg,resets=3D0,reconnect

  GUI black screen shown. QEMU hangs.

  qemu v1.5.3 (c0b1a7e207094dba0b37a892b41fe4cab3195e44). MinGW built.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1225187/+subscriptions
