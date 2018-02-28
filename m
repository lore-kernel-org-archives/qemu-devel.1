Received: from eggs.gnu.org ([2001:4830:134:3::10]:55788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1er5Z2-0007dL-2p
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1er5Yy-0004AL-4c
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:30:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:58494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1er5Yx-000492-Rx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:30:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1er5Yu-0002AE-LS
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 17:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C2102E80CC
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 17:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2018 17:19:13 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1751494 <1751494@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151949814019.828.11043064332951500017.malonedeb@chaenomeles.canonical.com>
Message-Id: <151983835400.12304.10792429089946153626.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751494] Re: tag-target.inc.c:3495:no such
 instruction: `xgetbv'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The exact commit that causes this problem is this:

commit 770c2fc7bb70804ae9869995fd02dadd6d7656ac
tcg/i386: Add vector operations

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751494

Title:
  tag-target.inc.c:3495:no such instruction: `xgetbv'

Status in QEMU:
  New

Bug description:
  While building QEMU on Mac OS 10.6.8 I saw this error message:
  tag-target.inc.c:3495:no such instruction: `xgetbv'
  In the file tcg/i386/tcg-target.inc.c at line 3495 is where the issue is =
located. This is the problem code:
  asm ("xgetbv" : "=3Da" (xcrl), "=3Dd" (xcrh) : "c" (0));

  https://github.com/asmjit/asmjit/issues/78
  According to the above link, another project also experienced this proble=
m on Mac OS X. The fix was to replace the name of the instruction with the =
encoded form '.byte 0x0F, 0x01, 0xd0'. =


  Host info:
  Mac OS 10.6.8
  GCC 5.2.0

  Additional information:
  This may be a gcc issue. I have compiled QEMU on Mac OS 10.12 and didn't =
experience any issues. The compiler used was Apple's clang.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751494/+subscriptions
