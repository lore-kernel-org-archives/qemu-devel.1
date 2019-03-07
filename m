Received: from eggs.gnu.org ([209.51.188.92]:36508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBw-0001AZ-UJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBv-0002Kv-Vq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:28 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:38997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yBv-0002JE-KF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:27 -0500
Received: by mail-pg1-x52c.google.com with SMTP id h8so11971413pgp.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:26 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:10 -0800
Message-Id: <20190307185622.29026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/12] decodetree enhacements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes since v2:
  * Add some additional tests, based on actual uncaught exceptions
    I saw while using pattern groups in an ARM32 conversion.
  * Allow negative numbers in field=number.
  * Push extraction functions into the namespace of the decoder.

I'll probably give a PR for this on the weekend.


r~


Bastian Koppelmann (1):
  test/decode: Add tests for PatternGroups

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Add scripts/decodetree.py to the TCG section
  decodetree: Ensure build_tree does not include values outside insnmask

Richard Henderson (9):
  decodetree: Move documentation to docs/devel/decodetree.rst
  decodetree: Document the usefulness of argument sets
  decodetree: Do not unconditionaly return from Pattern.output_code
  decodetree: Allow grouping of overlapping patterns
  decodetree: Add --static-decode option
  decodetree: Produce clean output for an empty input file
  decodetree: Allow +- to begin a number initializing a field
  decodetree: Prefix extract function names with decode_function
  decodetree: Properly diagnose fields overflowing an insn

 MAINTAINERS                                   |   2 +
 docs/devel/decodetree.rst                     | 221 ++++++++++++
 docs/devel/index.rst                          |   2 +-
 scripts/decodetree.py                         | 330 +++++++++---------
 tests/decode/check.sh                         |   6 +
 tests/decode/err_pattern_group_empty.decode   |   6 +
 tests/decode/err_pattern_group_ident1.decode  |  10 +
 tests/decode/err_pattern_group_ident2.decode  |  11 +
 tests/decode/err_pattern_group_nest1.decode   |  13 +
 .../decode/err_pattern_group_overlap1.decode  |   6 +
 tests/decode/err_width1.decode                |   5 +
 tests/decode/err_width2.decode                |   5 +
 tests/decode/err_width3.decode                |   5 +
 tests/decode/err_width4.decode                |   5 +
 tests/decode/succ_pattern_group_nest1.decode  |  22 ++
 15 files changed, 480 insertions(+), 169 deletions(-)
 create mode 100644 docs/devel/decodetree.rst
 create mode 100644 tests/decode/err_pattern_group_empty.decode
 create mode 100644 tests/decode/err_pattern_group_ident1.decode
 create mode 100644 tests/decode/err_pattern_group_ident2.decode
 create mode 100644 tests/decode/err_pattern_group_nest1.decode
 create mode 100644 tests/decode/err_pattern_group_overlap1.decode
 create mode 100644 tests/decode/err_width1.decode
 create mode 100644 tests/decode/err_width2.decode
 create mode 100644 tests/decode/err_width3.decode
 create mode 100644 tests/decode/err_width4.decode
 create mode 100644 tests/decode/succ_pattern_group_nest1.decode

-- 
2.17.2
