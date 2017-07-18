Received: from eggs.gnu.org ([2001:4830:134:3::10]:51559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKe-0000Vy-JZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKd-000118-V4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 17:26:30 +0100
Message-Id: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10 0/4] bsd-user: silence warnings on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

I've just managed to get an OpenBSD VM into my test set for processing
pull requests. There are a handful of minor compiler warnings in
bsd-user, which this patchset fixes, just to reduce the noise
in my logs.

thanks
-- PMM

Peter Maydell (4):
  bsd-user/mmap.c: Move __thread attribute to right place
  bsd-user/elfload.c: Fix set-but-not-used warnings
  bsd-user/bsdload.c: Remove write-only id_change variable
  bsd-user/main.c: Fix unused variable warning

 bsd-user/bsdload.c | 25 +------------------------
 bsd-user/elfload.c | 10 ++++------
 bsd-user/main.c    |  7 ++++---
 bsd-user/mmap.c    |  2 +-
 4 files changed, 10 insertions(+), 34 deletions(-)

-- 
2.7.4
