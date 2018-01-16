Received: from eggs.gnu.org ([2001:4830:134:3::10]:52062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebUNF-0000Tr-Ld
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebUNB-0008Lb-F3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:09 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebUNB-0008JK-6r
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:05 -0500
Received: by mail-pf0-x242.google.com with SMTP id k19so9989458pfj.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:46:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Jan 2018 08:45:56 -0800
Message-Id: <20180116164600.7480-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 0/4] tcg queued patches
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

With comments addressed from v1.


r~



The following changes since commit aae39d24a387a273deab3eb930dbf730aa379e22:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180116' into staging (2018-01-16 14:18:20 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180116

for you to fetch changes up to 030ffe39dd4128eb90483af82a5b23b23054a466:

  tcg/ppc: Allow a 32-bit offset to the constant pool (2018-01-16 08:21:56 -0800)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Richard Henderson (4):
      tcg/arm: Fix double-word comparisons
      tcg/arm: Support tlb offsets larger than 64k
      tcg/ppc: Support tlb offsets larger than 64k
      tcg/ppc: Allow a 32-bit offset to the constant pool

 tcg/arm/tcg-target.inc.c | 116 +++++++++++++++++++++++++++++++----------------
 tcg/ppc/tcg-target.inc.c |  84 +++++++++++++++++++---------------
 2 files changed, 124 insertions(+), 76 deletions(-)
