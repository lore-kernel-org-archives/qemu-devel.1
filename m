Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2fyv-0007Er-E4
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2fyp-000819-J6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2fyp-00080x-Cz
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:32:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23A92C05AA52
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 15:32:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 24 Apr 2017 16:32:40 +0100
Message-Id: <20170424153244.2600-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 4c55b1d0bad8a703f0499fe62e3761a0cd288d=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2017-04-24=
' into staging (2017-04-24 14:49:48 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170424

for you to fetch changes up to e4e3992e626c4cc7514b271807c90f587771c646:

  tests: Add a tester for HMP commands (2017-04-24 15:55:35 +0100)

----------------------------------------------------------------
HMP pull

----------------------------------------------------------------
Paolo Bonzini (1):
      hmp: gpa2hva and gpa2hpa hostaddr command

Thomas Huth (3):
      libqtest: Ignore QMP events when parsing the response for HMP comma=
nds
      libqtest: Add a generic function to run a callback function for eve=
ry machine
      tests: Add a tester for HMP commands

 hmp-commands.hx        |  32 ++++++++++
 monitor.c              | 101 +++++++++++++++++++++++++++++++
 tests/Makefile.include |   2 +
 tests/libqtest.c       |  36 +++++++++++
 tests/libqtest.h       |  12 +++-
 tests/pc-cpu-test.c    |  95 +++++++++++------------------
 tests/qom-test.c       |  36 ++---------
 tests/test-hmp.c       | 161 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 8 files changed, 385 insertions(+), 90 deletions(-)
 create mode 100644 tests/test-hmp.c
