Received: from eggs.gnu.org ([2001:4830:134:3::10]:35063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dIC79-0007vj-Iw
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dIC76-0006Aj-Hs
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:31 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:35949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1dIC76-0006AW-9k
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:28 -0400
Received: by mail-lf0-x231.google.com with SMTP id o83so36552340lff.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 03:53:28 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  6 Jun 2017 03:52:09 -0700
Message-Id: <1496746329-32047-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL v2 0/4] target/xtensa fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull my current target/xtensa queue.
Changes v1->v2:
- re-base series to the latest mainline, fixing breakage caused by chardev
  code rearrangement.

The following changes since commit a0d4aac7467dd02e5657b79e867f067330266a24:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170605' into staging (2017-06-05 18:03:43 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20170606-xtensa

for you to fetch changes up to dd7b952b793e341c905355581a21cdbaa8b13c31:

  target/xtensa: handle unknown registers in gdbstub (2017-06-06 02:40:48 -0700)

----------------------------------------------------------------
target/xtensa fixes:

- fix read/write simcall mapping flags and return value;
- use -serial option to direct console output of sim machine to QEMU chardev;
- fix handling of unknown registers in the gdbstub.

----------------------------------------------------------------
Max Filippov (4):
      target/xtensa: fix mapping direction in read/write simcalls
      target/xtensa: fix return value of read/write simcalls
      target/xtensa: support output to chardev console
      target/xtensa: handle unknown registers in gdbstub

 hw/xtensa/sim.c             |  4 ++
 target/xtensa/cpu.h         |  1 +
 target/xtensa/gdbstub.c     | 13 +++++--
 target/xtensa/xtensa-semi.c | 91 +++++++++++++++++++++++++++++++++++----------
 4 files changed, 87 insertions(+), 22 deletions(-)

-- 
Thanks.
-- Max
