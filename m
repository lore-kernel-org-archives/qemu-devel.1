Received: from eggs.gnu.org ([209.51.188.92]:59682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBi-0005gQ-9Q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEBg-0003o6-7r
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:54 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzEBe-0003hA-7P
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:24:50 -0500
Received: by mail-pf1-x429.google.com with SMTP id q17so9127919pfh.10
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:24:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 21:24:24 -0800
Message-Id: <20190228052432.32571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/8] decodetree enhancements
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

Changes since v1:
  * Move documentation to docs/devel/; fix some typos;
    add a description of when you might use argument sets.
  * Include test cases for pattern groups.
  * Add --static-decode.


r~


Bastian Koppelmann (1):
  test/decode: Add tests for PatternGroups

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Add scripts/decodetree.py to the TCG section
  decodetree: Ensure build_tree does not include values outside insnmask

Richard Henderson (5):
  decodetree: Move documentation to docs/devel/decodetree.rst
  decodetree: Document the usefulness of argument sets
  decodetree: Do not unconditionaly return from Pattern.output_code
  decodetree: Allow grouping of overlapping patterns
  decodetree: Add --static-decode option

 MAINTAINERS                                  |   2 +
 docs/devel/decodetree.rst                    | 221 ++++++++++++++
 scripts/decodetree.py                        | 292 +++++++++----------
 tests/decode/check.sh                        |   6 +
 tests/decode/err_pattern_group_empty.decode  |   6 +
 tests/decode/err_pattern_group_ident1.decode |  10 +
 tests/decode/err_pattern_group_ident2.decode |  11 +
 tests/decode/err_pattern_group_nest1.decode  |  13 +
 tests/decode/succ_pattern_group_nest1.decode |  22 ++
 9 files changed, 434 insertions(+), 149 deletions(-)
 create mode 100644 docs/devel/decodetree.rst
 create mode 100644 tests/decode/err_pattern_group_empty.decode
 create mode 100644 tests/decode/err_pattern_group_ident1.decode
 create mode 100644 tests/decode/err_pattern_group_ident2.decode
 create mode 100644 tests/decode/err_pattern_group_nest1.decode
 create mode 100644 tests/decode/succ_pattern_group_nest1.decode

-- 
2.17.2
