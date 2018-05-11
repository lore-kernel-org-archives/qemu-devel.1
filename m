Received: from eggs.gnu.org ([2001:4830:134:3::10]:55551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGzad-0000Wt-CV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGzaa-00084y-9U
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:31 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGzaa-00084u-3m
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:28 -0400
Received: by mail-pf0-x243.google.com with SMTP id x9-v6so2099088pfm.2
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 21:23:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 21:23:11 -0700
Message-Id: <20180511042324.5070-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 00/13] openrisc: Covert to decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org

Stafford Horne has acked and asked that I send the pull-request.


r~


The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/tgt-openrisc-pull-request

for you to fetch changes up to cf88ad60531a5b06834f6bf373a5f7fa91f2c3a8:

  target/openrisc: Merge disas_openrisc_insn (2018-05-10 21:19:13 -0700)

----------------------------------------------------------------
Convert OpenRISC to decodetree.py

----------------------------------------------------------------

Richard Henderson (13):
  target-openrisc: Write back result before FPE exception
  target/openrisc: Start conversion to decodetree.py
  target/openrisc: Convert branch insns
  target/openrisc: Convert memory insns
  target/openrisc: Convert remainder of dec_misc insns
  target/openrisc: Convert dec_calc
  target/openrisc: Convert dec_mac
  target/openrisc: Convert dec_logic
  target/openrisc: Convert dec_M
  target/openrisc: Convert dec_comp
  target/openrisc: Convert dec_compi
  target/openrisc: Convert dec_float
  target/openrisc: Merge disas_openrisc_insn

 target/openrisc/helper.h      |   25 +-
 target/openrisc/fpu_helper.c  |  250 +----
 target/openrisc/translate.c   | 1847 +++++++++++++++------------------
 target/openrisc/Makefile.objs |    9 +
 target/openrisc/insns.decode  |  189 ++++
 5 files changed, 1110 insertions(+), 1210 deletions(-)
 create mode 100644 target/openrisc/insns.decode

-- 
2.17.0
