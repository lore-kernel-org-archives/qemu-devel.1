Received: from eggs.gnu.org ([2001:4830:134:3::10]:51520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvrF-00050I-91
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvrB-0003pr-CY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:01 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvrB-0003pJ-5A
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:47:57 -0400
Received: by mail-pf0-x244.google.com with SMTP id p12so12389906pff.13
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:47:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 10:47:48 -0700
Message-Id: <20180502174753.16133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/5] TCG queued patches
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

The first tcg pull for 2.13/3.0.  Two of these are candidates
for cherry-picking into stable.


r~


The following changes since commit 26bd8d98c4b3284a4c6fe3b67c98b1edd00e9beb:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.13-pull-request' into staging (2018-05-01 15:26:06 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180502

for you to fetch changes up to 6001f7729e12dd1d810291e4cbf83cee8e07441d:

  tcg: workaround branch instruction overflow in tcg_out_qemu_ld/st (2018-05-01 11:56:55 -0700)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Henry Wertz (1):
      tcg/arm: Fix memory barrier encoding

Laurent Vivier (1):
      tcg: workaround branch instruction overflow in tcg_out_qemu_ld/st

Richard Henderson (3):
      tcg: Document INDEX_mul[us]h_*
      tcg: Allow wider vectors for cmp and mul
      tcg: Improve TCGv_ptr support

 tcg/tcg-op.h             | 91 +++++++++++++++++++++++++++++++++++++-----------
 tcg/tcg.h                | 88 +++++++++++++++++++++++++++++-----------------
 target/hppa/translate.c  | 16 ++-------
 tcg/arm/tcg-target.inc.c |  4 +--
 tcg/tcg-ldst.inc.c       |  8 ++---
 tcg/tcg-op-vec.c         |  8 ++---
 tcg/tcg.c                | 33 ++----------------
 tcg/README               |  8 +++++
 8 files changed, 150 insertions(+), 106 deletions(-)
