Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs8d-0001mj-LJ
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs8a-0003p6-H0
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:55 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs8a-0003ow-BV
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:52 -0500
Received: by mail-pg0-x241.google.com with SMTP id 75so3591428pgf.3
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:14:52 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:14:36 -0800
Message-Id: <1484514878-11828-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] target/xtensa: implement MEMCTL SR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series implements MEMCTL special register and adds a test for it.

Max Filippov (2):
  target/xtensa: implement MEMCTL SR
  target/xtensa: tests: add memctl test

 target/xtensa/cpu.c          |  1 +
 target/xtensa/cpu.h          | 19 +++++++++++++++++++
 target/xtensa/helper.h       |  1 +
 target/xtensa/op_helper.c    | 24 ++++++++++++++++++++++++
 target/xtensa/overlay_tool.h | 15 +++++++++++++++
 target/xtensa/translate.c    |  8 ++++++++
 tests/tcg/xtensa/test_sr.S   |  1 +
 7 files changed, 69 insertions(+)

-- 
2.1.4
