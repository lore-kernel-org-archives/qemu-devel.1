Received: from eggs.gnu.org ([2001:4830:134:3::10]:35377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UIb-00011f-3e
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UIX-00038Q-1R
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:00 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:47081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UIW-000382-SK
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:53:56 -0400
Received: by mail-ot1-x335.google.com with SMTP id o21so13220823otb.13
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 10:53:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 12:53:35 -0500
Message-Id: <20181005175350.30752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/15] target/arm: sve system mode patches
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

For v3, the only change is to patch 4, which is also the only
patch without a reviewed-by tag.

I now check for aa64 state before checking for sve length, and
added a comment about why it is important to play with sve when
transitioning into aa32 state.


r~


Richard Henderson (15):
  target/arm: Define ID_AA64ZFR0_EL1
  target/arm: Adjust sve_exception_el
  target/arm: Pass in current_el to fp and sve_exception_el
  target/arm: Handle SVE vector length changes in system mode
  target/arm: Adjust aarch64_cpu_dump_state for system mode SVE
  target/arm: Clear unused predicate bits for LD1RQ
  target/arm: Rewrite helper_sve_ld1*_r using pages
  target/arm: Rewrite helper_sve_ld[234]*_r
  target/arm: Rewrite helper_sve_st[1234]*_r
  target/arm: Split contiguous loads for endianness
  target/arm: Split contiguous stores for endianness
  target/arm: Rewrite vector gather loads
  target/arm: Rewrite vector gather stores
  target/arm: Rewrite vector gather first-fault loads
  target/arm: Pass TCGMemOpIdx to sve memory helpers

 target/arm/cpu.h           |    8 +
 target/arm/helper-sve.h    |  385 +++++--
 target/arm/internals.h     |    5 +
 target/arm/cpu64.c         |   42 -
 target/arm/helper.c        |  243 +++--
 target/arm/op_helper.c     |    1 +
 target/arm/sve_helper.c    | 1961 ++++++++++++++++++++++++------------
 target/arm/translate-a64.c |    8 +-
 target/arm/translate-sve.c |  670 ++++++++----
 9 files changed, 2273 insertions(+), 1050 deletions(-)

-- 
2.17.1
