Received: from eggs.gnu.org ([2001:4830:134:3::10]:46838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpOn-00034F-94
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpOj-0002gB-FS
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:15:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpOh-0002OE-Bz
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:14:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id y140-v6so1098226wmd.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:14:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:14:40 +0000
Message-Id: <20181031121443.605-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/3] decodetree improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de

All three patches have appeared on list before, though not all
at once in the same series.  This is all cleanup suggested by
the ongoing risc-v work.


r~


Richard Henderson (3):
  decodetree: Add !extern flag to argument sets
  decodetree: Remove "insn" argument from trans_* expanders
  decodetree: Allow multiple input files

 target/arm/translate-sve.c  | 507 +++++++++++++++++-------------------
 target/openrisc/disas.c     |  23 +-
 target/openrisc/translate.c | 200 +++++++-------
 scripts/decodetree.py       |  64 +++--
 4 files changed, 395 insertions(+), 399 deletions(-)

-- 
2.17.2
