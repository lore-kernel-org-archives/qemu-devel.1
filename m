Received: from eggs.gnu.org ([209.51.188.92]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgkA-0000P4-CX
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgk9-0007ML-Fa
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:06 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:44511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxgk9-0007CF-2d
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:05 -0500
Received: by mail-pg1-x530.google.com with SMTP id j3so2757316pgm.11
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:29:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 23 Feb 2019 15:29:47 -0800
Message-Id: <20190223232954.7185-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] decodetree enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

Two of these have been sitting around on a branch for too long.
Then, split out the documentation to a new file.

Finally, support overlapping patterns.  To demonstrate, I convert two
decodetree users: hppa and riscv, rfc patches appended to the series.


r~


Philippe Mathieu-Daudé (2):
  MAINTAINERS: Add scripts/decodetree.py to the TCG section
  decodetree: Ensure build_tree does not include values outside insnmask

Richard Henderson (3):
  decodetree: Move documentation to docs/decodetree.rst
  decodetree: Do not unconditionaly return from Pattern.output_code
  decodetree: Allow grouping of overlapping patterns

 MAINTAINERS           |   2 +
 docs/decodetree.rst   | 214 +++++++++++++++++++++++++++++++
 scripts/decodetree.py | 287 ++++++++++++++++++++----------------------
 3 files changed, 355 insertions(+), 148 deletions(-)
 create mode 100644 docs/decodetree.rst

-- 
2.17.2
