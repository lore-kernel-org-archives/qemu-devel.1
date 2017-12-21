Received: from eggs.gnu.org ([2001:4830:134:3::10]:50623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRq2L-0006kX-Sr
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRq2I-0001qu-Qi
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRq2I-0001qJ-KY
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:38 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 21 Dec 2017 09:52:32 +0800
Message-Id: <20171221015234.9912-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Docker and UUID patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe259:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-12-15-1' into staging (2017-12-17 15:27:41 +0000)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to bfab1aede07f864b8fbd749c3a0545b949b4cc84:

  util: add is_equal to UUID API (2017-12-20 22:01:24 +0800)

----------------------------------------------------------------

Patch 1 is also in Paolo's pull but it shouldn't be a problem.

----------------------------------------------------------------

Fam Zheng (1):
  Revert "docker: Enable features explicitly in test-full"

Roman Kagan (1):
  util: add is_equal to UUID API

 include/qemu/uuid.h    |  2 ++
 tests/docker/test-full | 79 +++-----------------------------------------------
 tests/test-uuid.c      |  8 ++++-
 util/uuid.c            |  7 ++++-
 4 files changed, 19 insertions(+), 77 deletions(-)

-- 
2.14.3
