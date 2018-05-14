Received: from eggs.gnu.org ([2001:4830:134:3::10]:55279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILw9-00044w-7N
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILw6-0008HQ-I6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:21 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILw6-0008Fy-BR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:18 -0400
Received: by mail-pg0-x242.google.com with SMTP id x145-v6so6070449pgx.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:27:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:27:01 -0700
Message-Id: <20180514222714.7982-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 00/13] target/openrisc: Covert to
 decodetree.py
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

Rebased on master to resolve conflicts with Emilio Cota's
TranslatorOps patch set.


r~


The following changes since commit bbd87423ea0c436c55bbc3f9c23d4f811d1f3f29:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-05-14 11:08:16 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/tgt-openrisc-pull-request

for you to fetch changes up to c7b6f54bf8d6d0e847230998d09495c73eeac9aa:

  target/openrisc: Merge disas_openrisc_insn (2018-05-14 14:58:08 -0700)

----------------------------------------------------------------
Convert openrisc to decodetree.py

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
 target/openrisc/translate.c   | 1800 +++++++++++++++------------------
 target/openrisc/Makefile.objs |    9 +
 target/openrisc/insns.decode  |  189 ++++
 5 files changed, 1086 insertions(+), 1187 deletions(-)
 create mode 100644 target/openrisc/insns.decode

-- 
2.17.0
