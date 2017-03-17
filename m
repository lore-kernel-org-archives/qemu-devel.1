Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cowSi-000347-3b
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cowSe-00049p-Vk
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:18:52 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cowSe-00049M-PW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:18:48 -0400
Received: by mail-pg0-x243.google.com with SMTP id 81so3035012pgh.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 11:18:48 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 17 Mar 2017 11:18:31 -0700
Message-Id: <1489774711-27746-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL for 2.9 0/2] target/xtensa fixes
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

please pull the following two fixes for the target/xtensa.

The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20170317-xtensa

for you to fetch changes up to f289bb091e6876df2e0e3481cb414c277695a405:

  target/xtensa: fix semihosting argc/argv implementation (2017-03-11 14:59:03 -0800)

----------------------------------------------------------------
target/xtensa fixes for 2.9:

- fix build failure when FDT support is not enabled;
- correctly pass command line arguments to semihosting guests.

----------------------------------------------------------------
Max Filippov (2):
      target/xtensa: xtfpga: load DTB only when FDT support is enabled
      target/xtensa: fix semihosting argc/argv implementation

 hw/xtensa/xtfpga.c          |  9 +++++++++
 target/xtensa/xtensa-semi.c | 49 +++++++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 13 deletions(-)

-- 
Thanks.
-- Max
