Received: from eggs.gnu.org ([2001:4830:134:3::10]:37539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD8-00072u-1m
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD3-0003cC-1q
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54520 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1famD2-0003NZ-Q4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:08:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 20:08:20 +0200
Message-Id: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/8] target/mips: Maintenance and misc fixes
 and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, aleksandar.markovic@wavecomp.com, petar.jovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Maintenance issues, fixes, and improvements collected during recent
development. Some of them are related to the upcoming nanoMIPS changes.

Note: These patches are, of course, supposed to be applied AFTER soft
freeze.

Aleksandar Markovic (4):
  target/mips: Update maintainer's email addresses
  target/mips: Workaround for checkpatch.pl hanging on msa_helper.c
  target/mips: Update some CP0 registers bit definitions
  target/mips: Avoid case statements formulated by ranges

Stefan Markovic (1):
  target/mips: Add CP0 BadInstrX register

Yongbok Kim (3):
  target/mips: Amend CP0 WatchHi register implementation
  target/mips: Don't update BadVAddr register in Debug Mode
  target/mips: Check ELPA flag only in some cases of MFHC0 and MTHC0

 .mailmap                 |   7 +-
 MAINTAINERS              |   9 +-
 target/mips/cpu.h        |  44 ++++---
 target/mips/helper.c     |   4 +-
 target/mips/helper.h     |   3 +
 target/mips/machine.c    |   7 +-
 target/mips/msa_helper.c |   4 +-
 target/mips/op_helper.c  |  35 +++++-
 target/mips/translate.c  | 311 ++++++++++++++++++++++++++++++++++++++---=
------
 9 files changed, 338 insertions(+), 86 deletions(-)

--=20
2.7.4
