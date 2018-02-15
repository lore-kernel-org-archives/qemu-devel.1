Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1emChd-0005Jz-TI
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1emCha-0007cS-Oq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:07:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1emCha-0007c8-Jt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:07:26 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu, 15 Feb 2018 01:07:23 -0500
Message-Id: <1518674845-6517-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V3 0/2] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, drjones@redhat.com

This is a new version of migration-test for aarch64. This version needs to
be applied on top of Dave Gilbert's recent patch "[v4] tests/migration: Add
source to PC boot block".

V2->V3:
 * Convert build script to Makefile
 * Add cross-compilation support
 * Fix CPU type for "tcg" machine type
 * Revise asm code and the compilation process from asm to header file

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

Wei Huang (2):
  tests/migration: Convert the boot block compilation script into
    Makefile
  tests: Add migration test for aarch64

 tests/Makefile.include                   |  1 +
 tests/migration-test.c                   | 39 ++++++++++++++---
 tests/migration/Makefile                 | 46 ++++++++++++++++++++
 tests/migration/aarch64-a-b-kernel.h     | 19 ++++++++
 tests/migration/aarch64-a-b-kernel.s     | 74 ++++++++++++++++++++++++++++++++
 tests/migration/rebuild-x86-bootblock.sh | 34 ---------------
 tests/migration/x86-a-b-bootblock.h      |  2 +-
 7 files changed, 174 insertions(+), 41 deletions(-)
 create mode 100644 tests/migration/Makefile
 create mode 100644 tests/migration/aarch64-a-b-kernel.h
 create mode 100644 tests/migration/aarch64-a-b-kernel.s
 delete mode 100755 tests/migration/rebuild-x86-bootblock.sh

-- 
1.8.3.1
