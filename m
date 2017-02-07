Received: from eggs.gnu.org ([2001:4830:134:3::10]:48270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavaP-0003Ih-7m
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavaM-0005Ng-L6
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:32:53 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cavaM-0005NJ-Fw
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:32:50 -0500
Received: by mail-it0-x243.google.com with SMTP id 203so10996445ith.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:32:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  6 Feb 2017 18:32:24 -0800
Message-Id: <20170207023229.29431-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/5] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Nothing complicated here.  Two bugs from Laurent, two noticed
by Coverity (through multiple channels).


r~



The following changes since commit 7d2c6c95511e42dffe2b263275e09957723d0ff4:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170206-1' into staging (2017-02-06 11:44:08 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20170206

for you to fetch changes up to 6836a8fb96963a29f309d49873062bbca9ab0e28:

  target/hppa: Fix gdb_write_register (2017-02-06 18:25:31 -0800)

----------------------------------------------------------------
Misc hppa fixes.

----------------------------------------------------------------
Laurent Vivier (3):
      linux-user: add hppa magic numbers in qemu-binfmt-conf.sh
      linux-user: fix "apt-get update" on linux-user hppa
      linux-user: define correct UTS machine name for hppa

Richard Henderson (2):
      target/hppa: Tidy do_cbranch
      target/hppa: Fix gdb_write_register

 linux-user/hppa/target_syscall.h |  2 +-
 linux-user/syscall.c             |  1 -
 scripts/qemu-binfmt-conf.sh      |  9 +++++++--
 target/hppa/gdbstub.c            |  1 +
 target/hppa/translate.c          | 17 +++++------------
 5 files changed, 14 insertions(+), 16 deletions(-)
