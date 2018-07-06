Received: from eggs.gnu.org ([2001:4830:134:3::10]:38551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fbPnl-0007X9-6Y
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fbPnD-0001cP-Aq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:25:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45992 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fbPnC-0001ah-TJ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:24:55 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  6 Jul 2018 13:48:44 +0200
Message-Id: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/8] Maintenance and misc fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

v3->v4:

  - accepted suggestion on better format of bit definitions in patch 3
  - fixed build errors caused by a mistake in patch 4
  - removed spurious comments in patch 4
  - added setting lower 16 bits to 0 in patch 5
  - used proper email address for a reviewer in patch 7 commit message

v2->v3:

  - replaced invalid @imgtec.com and @mips.com in "From:",,
    "Signed-off-by:", "Reviewed-by:" lines with the most current
    email addresses for a particular person
  - fixed build errors that appeared because of a mistake during
    integration

v1->v2:

  - fixed recipient's email addresses

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
 target/mips/cpu.h        |  41 +++---
 target/mips/helper.c     |   4 +-
 target/mips/helper.h     |   3 +
 target/mips/machine.c    |   7 +-
 target/mips/msa_helper.c |   4 +-
 target/mips/op_helper.c  |  35 +++++-
 target/mips/translate.c  | 315 ++++++++++++++++++++++++++++++++++++++---=
------
 9 files changed, 339 insertions(+), 86 deletions(-)

--=20
2.7.4
