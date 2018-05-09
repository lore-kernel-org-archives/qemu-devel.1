Received: from eggs.gnu.org ([2001:4830:134:3::10]:47561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTIw-0004Lm-Lv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTIs-000510-H2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:06 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTIs-0004zM-C2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:02 -0400
Received: by mail-pf0-x244.google.com with SMTP id a14so26018573pfi.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:30 -0700
Message-Id: <20180509175458.15642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/28] Bulk target patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This contains two related patch sets from Emilio Cota, both
touching the translation loop for these 13 targets.

I promised Emilio that we'd get these merged early in this
next development cycle to avoid conflicts.


r~


The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/cota-target-pull-request

for you to fetch changes up to 5b4f1d2db9fb0e24549054ee58c7a7d8f84ddd6e:

  target/riscv: convert to TranslatorOps (2018-05-09 10:12:21 -0700)

----------------------------------------------------------------
* Fix all next_page checks for overflow.
* Convert six targets to the translator loop.

----------------------------------------------------------------

Emilio G. Cota (28):
  target/riscv: avoid integer overflow in next_page PC check
  target/cris: avoid integer overflow in next_page PC check
  target/lm32: avoid integer overflow in next_page PC check
  target/xtensa: avoid integer overflow in next_page PC check
  target/unicore32: avoid integer overflow in next_page PC check
  target/tilegx: avoid integer overflow in next_page PC check
  target/microblaze: avoid integer overflow in next_page PC check
  target/arm: avoid integer overflow in next_page PC check
  target/s390x: avoid integer overflow in next_page PC check
  target/mips: avoid integer overflow in next_page PC check
  translator: merge max_insns into DisasContextBase
  target/sh4: convert to TranslatorOps
  target/sparc: convert to DisasJumpType
  target/sparc: convert to DisasContextBase
  target/sparc: convert to TranslatorOps
  target/mips: use lookup_and_goto_ptr on BS_STOP
  target/mips: convert to DisasJumpType
  target/mips: convert to DisasContextBase
  target/mips: use *ctx for DisasContext
  target/mips: convert to TranslatorOps
  target/s390x: convert to DisasJumpType
  target/s390x: convert to DisasContextBase
  target/s390x: convert to TranslatorOps
  target/openrisc: convert to DisasContextBase
  target/openrisc: convert to TranslatorOps
  target/riscv: convert to DisasJumpType
  target/riscv: convert to DisasContextBase
  target/riscv: convert to TranslatorOps

 include/exec/translator.h     |    8 +-
 target/arm/translate.h        |    2 +-
 accel/tcg/translator.c        |   21 +-
 target/alpha/translate.c      |    6 +-
 target/arm/translate-a64.c    |    8 +-
 target/arm/translate.c        |   20 +-
 target/cris/translate.c       |    6 +-
 target/hppa/translate.c       |    7 +-
 target/i386/translate.c       |    5 +-
 target/lm32/translate.c       |    6 +-
 target/microblaze/translate.c |    6 +-
 target/mips/translate.c       |  637 +++++++-------
 target/openrisc/translate.c   |  226 +++--
 target/ppc/translate.c        |    5 +-
 target/riscv/translate.c      |  255 +++---
 target/s390x/translate.c      | 1533 ++++++++++++++++-----------------
 target/sh4/translate.c        |  169 ++--
 target/sparc/translate.c      |  207 +++--
 target/tilegx/translate.c     |    4 +-
 target/unicore32/translate.c  |    6 +-
 target/xtensa/translate.c     |    9 +-
 21 files changed, 1554 insertions(+), 1592 deletions(-)

-- 
2.17.0
