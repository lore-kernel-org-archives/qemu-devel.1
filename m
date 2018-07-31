Received: from eggs.gnu.org ([2001:4830:134:3::10]:37590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQFB-0003PR-HG
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQF8-0006d7-Da
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:01 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkQF8-0006cQ-2m
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:42:58 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 31 Jul 2018 10:42:00 +0200
Message-Id: <20180731084203.29959-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request

for you to fetch changes up to 5d9f3ea0817215ad4baac5aa30414e9ebbaaf0d6:

  linux-user: ppc64: don't use volatile register during safe_syscall (2018-07-31 09:57:43 +0200)

----------------------------------------------------------------
Fix safe_syscall() on ppc64 host
Fix mmap() 0 length error case

----------------------------------------------------------------

Alex Bennée (2):
  linux-user/mmap.c: handle invalid len maps correctly
  tests: add check_invalid_maps to test-mmap

Shivaprasad G Bhat (1):
  linux-user: ppc64: don't use volatile register during safe_syscall

 linux-user/host/ppc64/safe-syscall.inc.S |  8 ++++++--
 linux-user/mmap.c                        | 15 ++++++++++++---
 tests/tcg/multiarch/test-mmap.c          | 22 +++++++++++++++++++++-
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.17.1
