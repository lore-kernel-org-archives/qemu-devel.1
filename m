Received: from eggs.gnu.org ([2001:4830:134:3::10]:50915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epeyy-0003ay-3s
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 13:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epeyt-0001r4-7K
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 13:55:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:41102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1epeys-0001pf-Sp
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 13:55:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1epeyq-0003Oa-Gs
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 18:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 61C8A2E80C9
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 18:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Feb 2018 18:49:00 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1751494 <1751494@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151949814019.828.11043064332951500017.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751494] [NEW] tag-target.inc.c:3495:no such
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

Public bug reported:

While building QEMU on Mac OS 10.6.8 I saw this error message:
tag-target.inc.c:3495:no such instruction: `xgetbv'
In the file tcg/i386/tcg-target.inc.c at line 3495 is where the issue is lo=
cated. This is the problem code:
asm ("xgetbv" : "=3Da" (xcrl), "=3Dd" (xcrh) : "c" (0));

https://github.com/asmjit/asmjit/issues/78
According to the above link, another project also experienced this problem =
on Mac OS X. The fix was to replace the name of the instruction with the en=
coded form '.byte 0x0F, 0x01, 0xd0'. =


Host info:
Mac OS 10.6.8
GCC 5.2.0

Additional information:
This may be a gcc issue. I have compiled QEMU on Mac OS 10.12 and didn't ex=
perience any issues. The compiler used was Apple's clang.

** Affects: qemu
     Importance: Undecided
         Status: New

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
