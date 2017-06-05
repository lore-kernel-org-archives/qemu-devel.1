Received: from eggs.gnu.org ([2001:4830:134:3::10]:60043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dHvNw-0005qS-3v
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dHvNr-00012h-Fa
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:01:44 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1dHvNr-00010N-8H
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:01:39 -0400
Received: by mail-lf0-x244.google.com with SMTP id v20so7070945lfa.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 10:01:37 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  5 Jun 2017 10:01:17 -0700
Message-Id: <1496682077-32144-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/4] target/xtensa fixes
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

please pull my current target/xtensa queue:

The following changes since commit c6e84fbd447a51e1161d74d71566a5f67b47eac5:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-06-02 17:46:22 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20170605-xtensa

for you to fetch changes up to aa717e657f3ef2e676803676eaa268ec0108a453:

  target/xtensa: handle unknown registers in gdbstub (2017-06-03 02:16:18 -0700)

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
