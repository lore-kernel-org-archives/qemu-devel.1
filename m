Received: from eggs.gnu.org ([2001:4830:134:3::10]:36334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332A-0004Cp-3e
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f3329-0004ZB-AZ
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:18 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:34756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f3329-0004Yy-2w
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:17 -0400
Received: by mail-wm0-x235.google.com with SMTP id w2so7109577wmw.1
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:17 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:46 -0700
Message-Id: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/8] xtensa-specific and generic fixes for
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Hi Peter,

please pull the following batch of linux-user fixes for 2.12.

The following changes since commit dfe732fb68ef9195517f4f380a477d58a054edc1:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2018-03-27 16:25:12 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180402-xtensa

for you to fetch changes up to 64a563dd8dd6ca2661d96a2e4b69f0a5465cab94:

  target/xtensa: linux-user: fix fadvise64 call (2018-04-02 04:15:35 -0700)

----------------------------------------------------------------
xtensa-specific fixes for linux-user:

- fix flushing registers for signal processing in call8 and call12 frames;
- fix PC value for restarted syscalls;
- fix sysv IPC structures;
- fix fadvise64 syscall;

generic fixes for linux-user:

- fix QEMU assertion in multithreaded application by calling cpu_copy
  under clone_lock;
- fix mq_getsetattr implementation;
- fix error propagation in clock_gettime;
- implement clock_settime.

----------------------------------------------------------------
Max Filippov (8):
      target/xtensa: fix flush_window_regs
      target/xtensa: linux-user: rewind pc for restarted syscall
      linux-user: call cpu_copy under clone_lock
      linux-user: fix mq_getsetattr implementation
      target/xtensa: linux-user: fix sysv IPC structures
      linux-user: fix error propagation in clock_gettime
      linux-user: implement clock_settime
      target/xtensa: linux-user: fix fadvise64 call

 linux-user/main.c                  |  3 +++
 linux-user/signal.c                | 55 +++++++++++++++++---------------------
 linux-user/syscall.c               | 36 +++++++++++++++++--------
 linux-user/xtensa/target_structs.h | 37 ++++++++++++++++++++-----
 4 files changed, 82 insertions(+), 49 deletions(-)

-- 
Thanks.
-- Max
