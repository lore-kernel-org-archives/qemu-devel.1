Received: from eggs.gnu.org ([2001:4830:134:3::10]:59217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGZU-0001BE-G2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGZR-0003KW-7z
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqGZR-0003K7-2O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 16 Aug 2018 13:35:50 +0200
Message-Id: <1534419358-10932-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] Various qtest-related patches and a
 mc146818rtc fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

The basic idea for this patch series are the two patches that improve
the device-inrospection test: We now check that the qom-tree and the
qtree do not change during introspection, and the we also turn on the
device introspection test with all machines when running in SPEED=slow
mode. The other patches are a bug fix for the mc146818rtc device which
has been discovered with the improved device-introspection test, two
patches to shut up annoying messages during "make check", a patch to
speed up the tests that iterate over all machine types and an update
to the MAINTAINERS file.

v2:
 - Added Reviewed-bys from v1
 - Use g_test_message() instead of g_debug()
 - Improved the patch descriptions a little bit
 - Added patch to skip old versioned machine types in quick mode
 - Added Paolo's update to MAINTAINERS

Paolo Bonzini (1):
  MAINTAINERS: add maintainers for qtest

Thomas Huth (7):
  tests/migration-test: Silence the kvm_hv message by default
  net: Silence 'has no peer' messages in testing mode
  hw/timer/mc146818rtc: White space clean-up
  hw/timer/mc146818rtc: Fix introspection problem
  tests: Skip old versioned machine types in quick testing mode
  tests/device-introspection: Check that the qom-tree and qtree do not
    change
  tests/device-introspect: Test with all machines, not only with "none"

 MAINTAINERS                    | 10 ++++++++
 hw/ppc/prep.c                  |  3 +++
 hw/timer/mc146818rtc.c         | 20 ++++++---------
 tests/cpu-plug-test.c          |  6 ++---
 tests/device-introspect-test.c | 55 ++++++++++++++++++++++++++++++++++++------
 tests/libqtest.c               | 52 +++++++++++++++++++++++++++++++++++++--
 tests/libqtest.h               |  4 ++-
 tests/migration-test.c         | 20 ++++++++-------
 tests/qom-test.c               |  2 +-
 tests/test-hmp.c               |  2 +-
 vl.c                           |  3 +--
 11 files changed, 138 insertions(+), 39 deletions(-)

-- 
1.8.3.1
