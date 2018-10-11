Received: from eggs.gnu.org ([2001:4830:134:3::10]:44864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwZ-0006dX-FW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwJ-00036K-90
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:17 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwI-0002z2-N0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:11 -0400
Received: by mail-pg1-x529.google.com with SMTP id c10-v6so4737509pgq.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:46 -0700
Message-Id: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/20] target/arm: Convert some neon insns to
 gvec
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

The conversion to gvec is by no means complete, but it brings aa32
to parity with the work already done for aa64.  Plus some misc changes,
at least one of which has been sitting on a branch for 2 years.  ;-P

I've run the result through Alex's aarch32-all.tar.xz RISU tests.
There are no regressions, though there are pre-existing failures.
Our aa32 translator could use some additional work, no surprise.


r~


Richard Henderson (20):
  target/arm: Hoist address increment for vector memory ops
  target/arm: Don't call tcg_clear_temp_count
  target/arm: Use tcg_gen_gvec_dup_i64 for LD[1-4]R
  target/arm: Promote consecutive memory ops for aa64
  target/arm: Mark some arrays const
  target/arm: Use gvec for NEON VDUP
  target/arm: Use gvec for NEON VMOV, VMVN, VBIC & VORR (immediate)
  target/arm: Use gvec for NEON_3R_LOGIC insns
  target/arm: Use gvec for NEON_3R_VADD_VSUB insns
  target/arm: Use gvec for NEON_2RM_VMN, NEON_2RM_VNEG
  target/arm: Use gvec for NEON_3R_VMUL
  target/arm: Use gvec for VSHR, VSHL
  target/arm: Use gvec for VSRA
  target/arm: Use gvec for VSRI, VSLI
  target/arm: Use gvec for NEON_3R_VML
  target/arm: Use gvec for NEON_3R_VTST_VCEQ, NEON_3R_VCGT, NEON_3R_VCGE
  target/arm: Use gvec for NEON VLD all lanes
  target/arm: Reorg NEON VLD/VST all elements
  target/arm: Promote consecutive memory ops for aa32
  target/arm: Reorg NEON VLD/VST single element to one lane

 target/arm/translate.h     |   14 +-
 target/arm/translate-a64.c |  570 ++-------------
 target/arm/translate.c     | 1390 ++++++++++++++++++++++++------------
 3 files changed, 979 insertions(+), 995 deletions(-)

-- 
2.17.1
