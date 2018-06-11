Received: from eggs.gnu.org ([2001:4830:134:3::10]:56256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOd-0002TI-33
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOY-0000hS-6C
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:49:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOX-0000gU-Px
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:49:54 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:26 +0200
Message-Id: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/9] M68k for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed4582:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180608' into staging (2018-06-08 16:26:51 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-3.0-pull-request

for you to fetch changes up to a56f36c1d2bccbc50a53fa8093b93d205607f1b8:

  target/m68k: Merge disas_m68k_insn into m68k_tr_translate_insn (2018-06-11 12:43:42 +0200)

----------------------------------------------------------------
Convert to TranslatorOps

I've updated the series to fix conflicts with:

21528149eb target/m68k: Add trailing '\n' to qemu_log() call
07ea28b418 tcg: Pass tb and index to tcg_gen_exit_tb separately

----------------------------------------------------------------

Richard Henderson (9):
  target/m68k: Use DISAS_NORETURN for exceptions
  target/m68k: Replace DISAS_TB_JUMP with DISAS_NORETURN
  target/m68k: Remove DISAS_JUMP_NEXT as unused
  target/m68k: Use lookup_and_goto_tb for DISAS_JUMP
  target/m68k: Rename DISAS_UPDATE and gen_lookup_tb
  target/m68k: Convert to DisasContextBase
  target/m68k: Convert to TranslatorOps
  target/m68k: Improve ending TB at page boundaries
  target/m68k: Merge disas_m68k_insn into m68k_tr_translate_insn

 target/m68k/translate.c | 356 ++++++++++++++++++++++++------------------------
 1 file changed, 180 insertions(+), 176 deletions(-)

-- 
2.14.4
