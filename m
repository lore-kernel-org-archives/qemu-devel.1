Received: from eggs.gnu.org ([209.51.188.92]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gozhK-0002Be-NY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gozhK-0006uN-4c
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:14 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gozhJ-0006tx-TC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:55:14 -0500
Received: by mail-lj1-x241.google.com with SMTP id s5-v6so1032419ljd.12
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 15:55:13 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 30 Jan 2019 15:54:39 -0800
Message-Id: <20190130235442.2876-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] target/xtensa: add basic FLIX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds limited support for FLIX instructions.
FLIX (flexible length instruction extensions) allows bundling multiple
opcodes in a single instruction. Each opcode is executed as if it was
the only opcode in the instruction. Opcodes may not simultaneously
modify same resource (register or state). Multiple branches, even
non-taken, are also not allowed in one instruction. 
Instructions with opcodes that have circular dependencies between used
resources (e.g. opcode A uses resource U and modifies resource M, while
opcode B uses resource M and modifies resource U) are not supported in
this series.

Max Filippov (3):
  target/xtensa: sort FLIX instruction opcodes
  target/xtensa: add generic instruction post-processing
  target/xtensa: move WINDOW_BASE SR update to postprocessing

 target/xtensa/cpu.h        |   5 +
 target/xtensa/helper.h     |   3 +-
 target/xtensa/translate.c  | 265 +++++++++++++++++++++++++++++++++++++++++----
 target/xtensa/win_helper.c |  14 +--
 4 files changed, 251 insertions(+), 36 deletions(-)

-- 
2.11.0
