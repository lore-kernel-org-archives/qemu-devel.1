Received: from eggs.gnu.org ([2001:4830:134:3::10]:53247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ekGRf-0005Ad-UL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ekGRf-0003eQ-68
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:42:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1ekGRf-0003eC-1F
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:42:59 -0500
From: Wei Huang <wei@redhat.com>
Date: Fri,  9 Feb 2018 16:42:41 -0500
Message-Id: <1518212562-21606-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V2 0/1] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com

This is a new version of migration-test for aarch64. This version needs to
be applied on top of Dave Gilbert's recent patch "[v2] tests/migration: Add
source to PC boot block".

V1->V2:
 * Similar to Dave Gilbert's recent changes to migration-test, we
   provide the test source and a build script in V2.
 * aarch64 kernel blob is defined as "unsigned char" because the source
   is now provided in V2.
 * Add "-machine none" to test_deprecated() because aarch64 doesn't have
   a default machine type.

RFC->V1:
 * aarch64 kernel blob is defined as an uint32_t array
 * The test code is re-written to address a data caching issue under KVM.
   Tests passed under both x86 and aarch64.
 * Re-use init_bootfile_x86() for both x86 and aarch64
 * Other minor fixes


Thanks,
-Wei

Wei Huang (1):
  tests: Add migration test for aarch64

 tests/Makefile.include                    |  1 +
 tests/migration-test.c                    | 29 ++++++++++---
 tests/migration/aarch64-a-b-kernel.h      | 19 +++++++++
 tests/migration/aarch64-a-b-kernel.s      | 67 +++++++++++++++++++++++++++++++
 tests/migration/rebuild-aarch64-kernel.sh | 67 +++++++++++++++++++++++++++++++
 5 files changed, 177 insertions(+), 6 deletions(-)
 create mode 100644 tests/migration/aarch64-a-b-kernel.h
 create mode 100644 tests/migration/aarch64-a-b-kernel.s
 create mode 100755 tests/migration/rebuild-aarch64-kernel.sh

-- 
1.8.3.1
