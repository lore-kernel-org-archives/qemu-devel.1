Received: from eggs.gnu.org ([2001:4830:134:3::10]:52226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRU-0000E3-B7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRO-0006iA-Nz
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3NRO-0006hb-Hi
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C8DA23E6D0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:57:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 26 Apr 2017 14:57:02 +0100
Message-Id: <20170426135707.5261-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] hmp queue
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

The following changes since commit dcaed66cbe2803f9378f3a043c2e482bf8035d=
fd:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-2017042=
6' into staging (2017-04-26 13:17:11 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170426

for you to fetch changes up to 78f86a2b7c6b5c490a612729816473485d7ac570:

  tests: Add a tester for HMP commands (2017-04-26 14:42:31 +0100)

----------------------------------------------------------------
HMP pull, with tcg fix

----------------------------------------------------------------
Paolo Bonzini (1):
      hmp: gpa2hva and gpa2hpa hostaddr command

Thomas Huth (4):
      monitor: Check whether TCG is enabled before running the "info jit"=
 code
      libqtest: Ignore QMP events when parsing the response for HMP comma=
nds
      libqtest: Add a generic function to run a callback function for eve=
ry machine
      tests: Add a tester for HMP commands

 hmp-commands.hx        |  32 ++++++++++
 monitor.c              | 106 ++++++++++++++++++++++++++++++++
 tests/Makefile.include |   2 +
 tests/libqtest.c       |  36 +++++++++++
 tests/libqtest.h       |  12 +++-
 tests/pc-cpu-test.c    |  95 +++++++++++------------------
 tests/qom-test.c       |  36 ++---------
 tests/test-hmp.c       | 161 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 8 files changed, 390 insertions(+), 90 deletions(-)
 create mode 100644 tests/test-hmp.c
