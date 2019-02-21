Received: from eggs.gnu.org ([209.51.188.92]:53412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwtcA-0004fL-DK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwtc9-0001xM-Dq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:34 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwtc9-0001wu-5U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:02:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id v21so11176753pfm.12
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:02:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 11:02:27 -0800
Message-Id: <20190221190229.22599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/2] tcg patch queue
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

The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190221

for you to fetch changes up to 8c6edfdd90522caa4fc429144d393aba5b99f584:

  include/exec/helper-head.h: support "const void *" in helper calls (2019-02-21 10:22:24 -0800)

----------------------------------------------------------------
Allow const void * as argument to helpers.
Remove obsolete TODO file.

----------------------------------------------------------------
David Hildenbrand (1):
      include/exec/helper-head.h: support "const void *" in helper calls

Richard Henderson (1):
      tcg: Remove TODO file

 include/exec/helper-head.h |  5 +++++
 tcg/TODO                   | 14 --------------
 2 files changed, 5 insertions(+), 14 deletions(-)
 delete mode 100644 tcg/TODO
