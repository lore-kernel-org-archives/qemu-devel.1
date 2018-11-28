Received: from eggs.gnu.org ([2001:4830:134:3::10]:47812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYc-0003kB-LA
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYY-0004Hp-LV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:42 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:39154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYY-0004GP-Fs
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:38 -0500
Received: by mail-pg1-x530.google.com with SMTP id w6so8978407pgl.6
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:22 -0800
Message-Id: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

The intent here is to remove several move insns putting the
function arguments into the proper place.  I'm hoping that
this will solve the skylake regression with spec2006, as
seen with the ool softmmu patch set.

Emilio, all of this is present on my tcg-next-for-4.0 branch.


r~


Richard Henderson (12):
  tcg: Add preferred_reg argument to tcg_reg_alloc
  tcg: Add preferred_reg argument to temp_load
  tcg: Add preferred_reg argument to temp_sync
  tcg: Add preferred_reg argument to tcg_reg_alloc_do_movi
  tcg: Add output_pref to TCGOp
  tcg: Improve register allocation for matching constraints
  tcg: Dump register preference info with liveness
  tcg: Reindent parts of liveness_pass_1
  tcg: Rename and adjust liveness_pass_1 helpers
  tcg: Split out more subroutines from liveness_pass_1
  tcg: Add TCG_OPF_BB_EXIT
  tcg: Record register preferences during liveness

 tcg/tcg-opc.h |   7 +-
 tcg/tcg.h     |  20 +-
 tcg/tcg.c     | 527 +++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 405 insertions(+), 149 deletions(-)

-- 
2.17.2
