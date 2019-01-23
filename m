Received: from eggs.gnu.org ([209.51.188.92]:54125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXK-00022I-AB
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXI-0007cL-T7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:38 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53344 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmGXD-0006uS-VK
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:34 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 23 Jan 2019 12:15:51 +0100
Message-Id: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/9] target/mips: Misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

A collection of misc fixes for MIPS.

v1->v2:

  - commit messages updated according to the reviewer's
    comments
  - other corrections of commit messages, mostly minor
  - added patches 7, 8, and 9
  - rebased to the latest code

Aleksandar Markovic (7):
  target/mips: nanoMIPS: Remove duplicate macro definitions
  target/mips: nanoMIPS: Remove an unused macro
  target/mips: nanoMIPS: Rename macros for extracting 3-bit-coded GPR
    numbers
  target/mips: Correct the second argument type of cpu_supports_isa()
  target/mips: Extend gen_scwp() functionality to support EVA
  disas: nanoMIPS: Amend DSP instructions related comments
  MAINTAINERS: Update MIPS sections

Stefan Markovic (1):
  target/mips: nanoMIPS: Fix branch handling

Yongbok Kim (1):
  target/mips: Add I6500 core configuration

 MAINTAINERS                      |   9 ---
 disas/nanomips.cpp               | 119 ++++++++++++++++++++++++---------=
------
 target/mips/cpu.h                |   2 +-
 target/mips/translate.c          |  61 ++++++++++----------
 target/mips/translate_init.inc.c |  40 +++++++++++++
 5 files changed, 148 insertions(+), 83 deletions(-)

--=20
2.7.4
