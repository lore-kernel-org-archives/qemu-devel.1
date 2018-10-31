Received: from eggs.gnu.org ([2001:4830:134:3::10]:56328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtkY-0005Y0-8e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtkV-0008Og-Hr
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHtkV-0008De-64
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id y16so17288249wrw.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:53:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 16:53:18 +0000
Message-Id: <20181031165321.4422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] decodetree improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-dt-20181031

for you to fetch changes up to 6699ae6a8e74381583622502db8bd47fac381c9e:

  decodetree: Allow multiple input files (2018-10-31 16:48:58 +0000)

----------------------------------------------------------------
Updates to decodetree.py for risc-v.

----------------------------------------------------------------
Richard Henderson (3):
      decodetree: Add !extern flag to argument sets
      decodetree: Remove "insn" argument from trans_* expanders
      decodetree: Allow multiple input files

 target/arm/translate-sve.c  | 507 +++++++++++++++++++++-----------------------
 target/openrisc/disas.c     |  23 +-
 target/openrisc/translate.c | 200 ++++++++---------
 scripts/decodetree.py       |  64 +++---
 4 files changed, 395 insertions(+), 399 deletions(-)
