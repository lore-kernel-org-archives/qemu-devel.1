Received: from eggs.gnu.org ([2001:4830:134:3::10]:52279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2xuR-00054q-6H
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2xuO-0007Ec-Kh
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:41:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2xuO-0007EH-FG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E1CD3DBC1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:41:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 25 Apr 2017 11:41:12 +0100
Message-Id: <20170425104116.31435-1-dgilbert@redhat.com>
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

The following changes since commit f4b5b021c847669b1c78050aea26fe9abceef6=
dd:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2017-04-25 09:21:54 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170425

for you to fetch changes up to 1eb8e78dd1cd4e0b4170fd42f6d8882c867f334b:

  tests: Add a tester for HMP commands (2017-04-25 11:26:52 +0100)

----------------------------------------------------------------
HMP pull with fixed test/strcmp case

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
