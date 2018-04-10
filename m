Received: from eggs.gnu.org ([2001:4830:134:3::10]:46187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Px-TO
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002yv-Ei
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:36 -0400
Message-Id: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 00/10] Avoid integer overflow in next_page_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Richard pointed out in another thread that when computing
next_page_start we can break checks for the last page in the
address space due to integer overflow. This affects several targets;
the appended fixes them.

You can fetch the patches from:
  https://github.com/cota/qemu/tree/next_page_overflow

Thanks,

		Emilio
---
 target/arm/translate.c        | 11 +++++------
 target/arm/translate.h        |  2 +-
 target/cris/translate.c       |  6 +++---
 target/lm32/translate.c       |  6 +++---
 target/microblaze/translate.c |  6 +++---
 target/mips/translate.c       |  6 +++---
 target/riscv/translate.c      |  6 +++---
 target/s390x/translate.c      |  6 +++---
 target/tilegx/translate.c     |  4 ++--
 target/unicore32/translate.c  |  6 +++---
 target/xtensa/translate.c     |  9 ++++-----
 11 files changed, 33 insertions(+), 35 deletions(-)
