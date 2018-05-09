Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGRKq-0000u6-Jn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGRKn-0006uQ-FR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:56 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGRKn-0006sY-4R
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:53 -0400
Received: by mail-pf0-x244.google.com with SMTP id a22so11740019pfn.6
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 08:48:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 08:48:47 -0700
Message-Id: <20180509154849.27979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] tcg-next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org

The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/tcg-next-pull-request

for you to fetch changes up to abebf92597186be2bc48d487235da28b1127860f:

  tcg: Limit the number of ops in a TB (2018-05-09 08:30:57 -0700)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------

Peter Maydell (1):
  tcg/i386: Fix dup_vec in non-AVX2 codepath

Richard Henderson (1):
  tcg: Limit the number of ops in a TB

 tcg/tcg.h                 | 8 +++++++-
 tcg/i386/tcg-target.inc.c | 6 +++---
 tcg/tcg.c                 | 3 +++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.17.0
