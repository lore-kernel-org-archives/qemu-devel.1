Received: from eggs.gnu.org ([209.51.188.92]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBL9Q-00061f-NL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBL9P-0003FG-PE
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:16:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44557 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hBL9P-0001ck-Fn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:16:35 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue,  2 Apr 2019 17:15:19 +0200
Message-Id: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 0/2] target/mips: Optimize MSA
 <ILVEV|ILVOD>.<B|H|W|D> instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize MSA instructions ILVEV.<B|H|W|D> and ILVOD.<B|H|W|D>,
using directly tcg registers and performing logic on
them insted of using helpers.

v5:
 - Use tcg_gen_deposit function.
 - Added performance number for no-deposit and
   with-deposit cases of ILVEV.W.
 - Minor changes in commit messages and cover letter.

v4:
 - Clean up typing errors.
 - Change the commit message and the cover letter.
 - Fix bug for ILVEV.D, in case where the destination
   and one of the sources are the same register.

v3:
 - Reduce the number of logic operations to a
   minimum.
 - Add comments.

v2:
 - Minor changes in commit messages and cover letter.

Mateja Marjanovic (2):
  target/mips: Optimize ILVOD.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVEV.<B|H|W|D> MSA instructions

 target/mips/helper.h     |   2 -
 target/mips/msa_helper.c |  16 ----
 target/mips/translate.c  | 212 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 210 insertions(+), 20 deletions(-)

-- 
2.7.4
