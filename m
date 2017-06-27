Received: from eggs.gnu.org ([2001:4830:134:3::10]:40856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPuMK-0000bk-0x
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPuMJ-0002Za-82
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:33:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dPuMJ-0002VF-10
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:33:03 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 18:32:47 +0100
Message-Id: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/2] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This patchset removes the useless return value from
main_loop_wait().

Changes v2->v3:
 * add initial patch which removes the use of the return value
   from the version of main_loop in test-char.c -- it didn't
   really need it anyway.
 * removed unnecessary 'return;' at end of function

NB: I've just also noticed that there is exactly one use in the
tree of the argument to main_loop_wait() now which doesn't
pass 'false' -- that is in a function in hw/display/xenfb.c
that was added 8 years ago with a comment claiming it was
strictly temporary ;-)


Peter Maydell (2):
  tests/test-char.c: Don't use main_loop_wait()'s return value
  main_loop: Make main_loop_wait() return void

 include/qemu/main-loop.h | 2 +-
 tests/test-char.c        | 6 +-----
 util/main-loop.c         | 8 +-------
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.7.4
