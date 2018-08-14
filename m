Received: from eggs.gnu.org ([2001:4830:134:3::10]:49268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabG-0000ku-Ij
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabD-0005CS-Eq
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpabD-0005CB-8b
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:07 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 14 Aug 2018 16:46:52 +0200
Message-Id: <1534258018-22859-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Various qtest-related patches and a
 mc146818rtc fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The basic idea for this patch series are the two patches that improve
the device-inrospection test: We now check that the qom-tree and the
qtree do not change during introspection, and the final patch also turns
on testing device introspection with all machines. The other patches are
a bug fix for the mc146818rtc device which has been discovered with the
improved device-introspection test, and two patches to shut up annoying
messages during "make check".

Thomas Huth (6):
  tests/migration-test: Silence the kvm_hv message by default
  tests/device-introspection: Check that the qom-tree and qtree do not
    change
  hw/timer/mc146818rtc: White space clean-up
  hw/timer/mc146818rtc: Fix introspection problem
  net: Silence 'has no peer' messages in testing mode
  tests/device-introspect: Test with all machines, not only with "none"

 hw/ppc/prep.c                  |  3 +++
 hw/timer/mc146818rtc.c         | 20 ++++++---------
 tests/device-introspect-test.c | 55 ++++++++++++++++++++++++++++++++++++------
 tests/migration-test.c         | 20 ++++++++-------
 vl.c                           |  3 +--
 5 files changed, 70 insertions(+), 31 deletions(-)

-- 
1.8.3.1
