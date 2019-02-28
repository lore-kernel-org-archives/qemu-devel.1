Received: from eggs.gnu.org ([209.51.188.92]:42817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFh-0000eA-0h
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFc-0007Qo-0c
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFb-0007Q0-Hq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id d17so23389617wre.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:51 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:31 +0000
Message-Id: <20190228202537.4638-11-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/16] tests/tcg: split cris tests into bare
 and libc directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Bare tests are standalone assembly tests that don't require linking to
any libc and hence can be built with kernel only compilers. The libc
tests need a compiler capable of building properly linked userspace
binaries. As we don't have such a cross compiler at the moment we
won't be building those tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - split between bare/libc instead of system/user
---
 tests/tcg/cris/{ => bare}/check_addcv17.s     |  0
 tests/tcg/cris/{ => bare}/check_addi.s        |  0
 tests/tcg/cris/{ => bare}/check_addiv32.s     |  0
 tests/tcg/cris/{ => bare}/check_addm.s        |  0
 tests/tcg/cris/{ => bare}/check_addq.s        |  0
 tests/tcg/cris/{ => bare}/check_addr.s        |  0
 tests/tcg/cris/{ => bare}/check_addxc.s       |  0
 tests/tcg/cris/{ => bare}/check_addxm.s       |  0
 tests/tcg/cris/{ => bare}/check_addxr.s       |  0
 tests/tcg/cris/{ => bare}/check_andc.s        |  0
 tests/tcg/cris/{ => bare}/check_andm.s        |  0
 tests/tcg/cris/{ => bare}/check_andq.s        |  0
 tests/tcg/cris/{ => bare}/check_andr.s        |  0
 tests/tcg/cris/{ => bare}/check_asr.s         |  0
 tests/tcg/cris/{ => bare}/check_ba.s          |  0
 tests/tcg/cris/{ => bare}/check_bas.s         |  0
 tests/tcg/cris/{ => bare}/check_bcc.s         |  0
 tests/tcg/cris/{ => bare}/check_boundc.s      |  0
 tests/tcg/cris/{ => bare}/check_boundr.s      |  0
 tests/tcg/cris/{ => bare}/check_btst.s        |  0
 tests/tcg/cris/{ => bare}/check_clearfv32.s   |  0
 tests/tcg/cris/{ => bare}/check_clrjmp1.s     |  0
 tests/tcg/cris/{ => bare}/check_cmp-2.s       |  0
 tests/tcg/cris/{ => bare}/check_cmpc.s        |  0
 tests/tcg/cris/{ => bare}/check_cmpm.s        |  0
 tests/tcg/cris/{ => bare}/check_cmpq.s        |  0
 tests/tcg/cris/{ => bare}/check_cmpr.s        |  0
 tests/tcg/cris/{ => bare}/check_cmpxc.s       |  0
 tests/tcg/cris/{ => bare}/check_cmpxm.s       |  0
 tests/tcg/cris/{ => bare}/check_dstep.s       |  0
 tests/tcg/cris/{ => bare}/check_jsr.s         |  0
 tests/tcg/cris/{ => bare}/check_lapc.s        |  0
 tests/tcg/cris/{ => bare}/check_lsl.s         |  0
 tests/tcg/cris/{ => bare}/check_lsr.s         |  0
 tests/tcg/cris/{ => bare}/check_mcp.s         |  0
 tests/tcg/cris/{ => bare}/check_movdelsr1.s   |  0
 tests/tcg/cris/{ => bare}/check_movecr.s      |  0
 tests/tcg/cris/{ => bare}/check_movei.s       |  0
 tests/tcg/cris/{ => bare}/check_movemr.s      |  0
 tests/tcg/cris/{ => bare}/check_movemrv32.s   |  0
 tests/tcg/cris/{ => bare}/check_mover.s       |  0
 tests/tcg/cris/{ => bare}/check_moverm.s      |  0
 tests/tcg/cris/{ => bare}/check_movmp.s       |  0
 tests/tcg/cris/{ => bare}/check_movpmv32.s    |  0
 tests/tcg/cris/{ => bare}/check_movpr.s       |  0
 tests/tcg/cris/{ => bare}/check_movprv32.s    |  0
 tests/tcg/cris/{ => bare}/check_movscr.s      |  0
 tests/tcg/cris/{ => bare}/check_movsm.s       |  0
 tests/tcg/cris/{ => bare}/check_movsr.s       |  0
 tests/tcg/cris/{ => bare}/check_movucr.s      |  0
 tests/tcg/cris/{ => bare}/check_movum.s       |  0
 tests/tcg/cris/{ => bare}/check_movur.s       |  0
 tests/tcg/cris/{ => bare}/check_mulv32.s      |  0
 tests/tcg/cris/{ => bare}/check_mulx.s        |  0
 tests/tcg/cris/{ => bare}/check_neg.s         |  0
 tests/tcg/cris/{ => bare}/check_not.s         |  0
 tests/tcg/cris/{ => bare}/check_orc.s         |  0
 tests/tcg/cris/{ => bare}/check_orm.s         |  0
 tests/tcg/cris/{ => bare}/check_orq.s         |  0
 tests/tcg/cris/{ => bare}/check_orr.s         |  0
 tests/tcg/cris/{ => bare}/check_ret.s         |  0
 tests/tcg/cris/{ => bare}/check_scc.s         |  0
 tests/tcg/cris/{ => bare}/check_subc.s        |  0
 tests/tcg/cris/{ => bare}/check_subm.s        |  0
 tests/tcg/cris/{ => bare}/check_subq.s        |  0
 tests/tcg/cris/{ => bare}/check_subr.s        |  0
 tests/tcg/cris/{ => bare}/check_xarith.s      |  0
 tests/tcg/cris/{ => bare}/crt.s               |  0
 tests/tcg/cris/{ => bare}/sys.c               |  0
 tests/tcg/cris/{ => bare}/testutils.inc       |  0
 tests/tcg/cris/{ => libc}/check_abs.c         |  0
 tests/tcg/cris/{ => libc}/check_addc.c        |  0
 tests/tcg/cris/{ => libc}/check_addcm.c       |  0
 tests/tcg/cris/{ => libc}/check_addo.c        |  0
 tests/tcg/cris/{ => libc}/check_addoq.c       |  0
 tests/tcg/cris/{ => libc}/check_bound.c       |  0
 tests/tcg/cris/{ => libc}/check_ftag.c        |  0
 .../{ => libc}/check_gcctorture_pr28634-1.c   |  0
 .../{ => libc}/check_gcctorture_pr28634.c     |  0
 .../{ => libc}/check_glibc_kernelversion.c    |  0
 tests/tcg/cris/{ => libc}/check_hello.c       |  0
 tests/tcg/cris/{ => libc}/check_int64.c       |  0
 tests/tcg/cris/{ => libc}/check_lz.c          |  0
 tests/tcg/cris/{ => libc}/check_mapbrk.c      |  0
 tests/tcg/cris/{ => libc}/check_mmap1.c       |  0
 tests/tcg/cris/{ => libc}/check_mmap2.c       |  0
 tests/tcg/cris/{ => libc}/check_mmap3.c       |  0
 tests/tcg/cris/{ => libc}/check_moveq.c       |  0
 tests/tcg/cris/{ => libc}/check_openpf1.c     |  0
 tests/tcg/cris/{ => libc}/check_openpf2.c     |  0
 tests/tcg/cris/{ => libc}/check_openpf3.c     |  0
 tests/tcg/cris/{ => libc}/check_openpf5.c     |  0
 tests/tcg/cris/{ => libc}/check_settls1.c     |  0
 tests/tcg/cris/{ => libc}/check_sigalrm.c     |  0
 tests/tcg/cris/{ => libc}/check_stat1.c       |  0
 tests/tcg/cris/{ => libc}/check_stat2.c       |  0
 tests/tcg/cris/{ => libc}/check_stat3.c       |  0
 tests/tcg/cris/{ => libc}/check_stat4.c       |  0
 tests/tcg/cris/{ => libc}/check_swap.c        |  0
 tests/tcg/cris/{ => libc}/check_time2.c       |  0
 tests/tcg/cris/{ => libc}/crisutils.h         |  0
 tests/tcg/cris/libc/sys.c                     | 58 +++++++++++++++++++
 tests/tcg/cris/{ => libc}/sys.h               |  0
 103 files changed, 58 insertions(+)
 rename tests/tcg/cris/{ => bare}/check_addcv17.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addi.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addiv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addxc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addxm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_addxr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_andr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_asr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_ba.s (100%)
 rename tests/tcg/cris/{ => bare}/check_bas.s (100%)
 rename tests/tcg/cris/{ => bare}/check_bcc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_boundc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_boundr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_btst.s (100%)
 rename tests/tcg/cris/{ => bare}/check_clearfv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_clrjmp1.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmp-2.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpxc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_cmpxm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_dstep.s (100%)
 rename tests/tcg/cris/{ => bare}/check_jsr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_lapc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_lsl.s (100%)
 rename tests/tcg/cris/{ => bare}/check_lsr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mcp.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movdelsr1.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movecr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movei.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movemr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movemrv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mover.s (100%)
 rename tests/tcg/cris/{ => bare}/check_moverm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movmp.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movpmv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movpr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movprv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movscr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movsm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movsr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movucr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movum.s (100%)
 rename tests/tcg/cris/{ => bare}/check_movur.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mulv32.s (100%)
 rename tests/tcg/cris/{ => bare}/check_mulx.s (100%)
 rename tests/tcg/cris/{ => bare}/check_neg.s (100%)
 rename tests/tcg/cris/{ => bare}/check_not.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_orr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_ret.s (100%)
 rename tests/tcg/cris/{ => bare}/check_scc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subc.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subm.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subq.s (100%)
 rename tests/tcg/cris/{ => bare}/check_subr.s (100%)
 rename tests/tcg/cris/{ => bare}/check_xarith.s (100%)
 rename tests/tcg/cris/{ => bare}/crt.s (100%)
 rename tests/tcg/cris/{ => bare}/sys.c (100%)
 rename tests/tcg/cris/{ => bare}/testutils.inc (100%)
 rename tests/tcg/cris/{ => libc}/check_abs.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addc.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addcm.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addo.c (100%)
 rename tests/tcg/cris/{ => libc}/check_addoq.c (100%)
 rename tests/tcg/cris/{ => libc}/check_bound.c (100%)
 rename tests/tcg/cris/{ => libc}/check_ftag.c (100%)
 rename tests/tcg/cris/{ => libc}/check_gcctorture_pr28634-1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_gcctorture_pr28634.c (100%)
 rename tests/tcg/cris/{ => libc}/check_glibc_kernelversion.c (100%)
 rename tests/tcg/cris/{ => libc}/check_hello.c (100%)
 rename tests/tcg/cris/{ => libc}/check_int64.c (100%)
 rename tests/tcg/cris/{ => libc}/check_lz.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mapbrk.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mmap1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mmap2.c (100%)
 rename tests/tcg/cris/{ => libc}/check_mmap3.c (100%)
 rename tests/tcg/cris/{ => libc}/check_moveq.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf2.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf3.c (100%)
 rename tests/tcg/cris/{ => libc}/check_openpf5.c (100%)
 rename tests/tcg/cris/{ => libc}/check_settls1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_sigalrm.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat1.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat2.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat3.c (100%)
 rename tests/tcg/cris/{ => libc}/check_stat4.c (100%)
 rename tests/tcg/cris/{ => libc}/check_swap.c (100%)
 rename tests/tcg/cris/{ => libc}/check_time2.c (100%)
 rename tests/tcg/cris/{ => libc}/crisutils.h (100%)
 create mode 100644 tests/tcg/cris/libc/sys.c
 rename tests/tcg/cris/{ => libc}/sys.h (100%)

diff --git a/tests/tcg/cris/check_addcv17.s b/tests/tcg/cris/bare/check_addcv17.s
similarity index 100%
rename from tests/tcg/cris/check_addcv17.s
rename to tests/tcg/cris/bare/check_addcv17.s
diff --git a/tests/tcg/cris/check_addi.s b/tests/tcg/cris/bare/check_addi.s
similarity index 100%
rename from tests/tcg/cris/check_addi.s
rename to tests/tcg/cris/bare/check_addi.s
diff --git a/tests/tcg/cris/check_addiv32.s b/tests/tcg/cris/bare/check_addiv32.s
similarity index 100%
rename from tests/tcg/cris/check_addiv32.s
rename to tests/tcg/cris/bare/check_addiv32.s
diff --git a/tests/tcg/cris/check_addm.s b/tests/tcg/cris/bare/check_addm.s
similarity index 100%
rename from tests/tcg/cris/check_addm.s
rename to tests/tcg/cris/bare/check_addm.s
diff --git a/tests/tcg/cris/check_addq.s b/tests/tcg/cris/bare/check_addq.s
similarity index 100%
rename from tests/tcg/cris/check_addq.s
rename to tests/tcg/cris/bare/check_addq.s
diff --git a/tests/tcg/cris/check_addr.s b/tests/tcg/cris/bare/check_addr.s
similarity index 100%
rename from tests/tcg/cris/check_addr.s
rename to tests/tcg/cris/bare/check_addr.s
diff --git a/tests/tcg/cris/check_addxc.s b/tests/tcg/cris/bare/check_addxc.s
similarity index 100%
rename from tests/tcg/cris/check_addxc.s
rename to tests/tcg/cris/bare/check_addxc.s
diff --git a/tests/tcg/cris/check_addxm.s b/tests/tcg/cris/bare/check_addxm.s
similarity index 100%
rename from tests/tcg/cris/check_addxm.s
rename to tests/tcg/cris/bare/check_addxm.s
diff --git a/tests/tcg/cris/check_addxr.s b/tests/tcg/cris/bare/check_addxr.s
similarity index 100%
rename from tests/tcg/cris/check_addxr.s
rename to tests/tcg/cris/bare/check_addxr.s
diff --git a/tests/tcg/cris/check_andc.s b/tests/tcg/cris/bare/check_andc.s
similarity index 100%
rename from tests/tcg/cris/check_andc.s
rename to tests/tcg/cris/bare/check_andc.s
diff --git a/tests/tcg/cris/check_andm.s b/tests/tcg/cris/bare/check_andm.s
similarity index 100%
rename from tests/tcg/cris/check_andm.s
rename to tests/tcg/cris/bare/check_andm.s
diff --git a/tests/tcg/cris/check_andq.s b/tests/tcg/cris/bare/check_andq.s
similarity index 100%
rename from tests/tcg/cris/check_andq.s
rename to tests/tcg/cris/bare/check_andq.s
diff --git a/tests/tcg/cris/check_andr.s b/tests/tcg/cris/bare/check_andr.s
similarity index 100%
rename from tests/tcg/cris/check_andr.s
rename to tests/tcg/cris/bare/check_andr.s
diff --git a/tests/tcg/cris/check_asr.s b/tests/tcg/cris/bare/check_asr.s
similarity index 100%
rename from tests/tcg/cris/check_asr.s
rename to tests/tcg/cris/bare/check_asr.s
diff --git a/tests/tcg/cris/check_ba.s b/tests/tcg/cris/bare/check_ba.s
similarity index 100%
rename from tests/tcg/cris/check_ba.s
rename to tests/tcg/cris/bare/check_ba.s
diff --git a/tests/tcg/cris/check_bas.s b/tests/tcg/cris/bare/check_bas.s
similarity index 100%
rename from tests/tcg/cris/check_bas.s
rename to tests/tcg/cris/bare/check_bas.s
diff --git a/tests/tcg/cris/check_bcc.s b/tests/tcg/cris/bare/check_bcc.s
similarity index 100%
rename from tests/tcg/cris/check_bcc.s
rename to tests/tcg/cris/bare/check_bcc.s
diff --git a/tests/tcg/cris/check_boundc.s b/tests/tcg/cris/bare/check_boundc.s
similarity index 100%
rename from tests/tcg/cris/check_boundc.s
rename to tests/tcg/cris/bare/check_boundc.s
diff --git a/tests/tcg/cris/check_boundr.s b/tests/tcg/cris/bare/check_boundr.s
similarity index 100%
rename from tests/tcg/cris/check_boundr.s
rename to tests/tcg/cris/bare/check_boundr.s
diff --git a/tests/tcg/cris/check_btst.s b/tests/tcg/cris/bare/check_btst.s
similarity index 100%
rename from tests/tcg/cris/check_btst.s
rename to tests/tcg/cris/bare/check_btst.s
diff --git a/tests/tcg/cris/check_clearfv32.s b/tests/tcg/cris/bare/check_clearfv32.s
similarity index 100%
rename from tests/tcg/cris/check_clearfv32.s
rename to tests/tcg/cris/bare/check_clearfv32.s
diff --git a/tests/tcg/cris/check_clrjmp1.s b/tests/tcg/cris/bare/check_clrjmp1.s
similarity index 100%
rename from tests/tcg/cris/check_clrjmp1.s
rename to tests/tcg/cris/bare/check_clrjmp1.s
diff --git a/tests/tcg/cris/check_cmp-2.s b/tests/tcg/cris/bare/check_cmp-2.s
similarity index 100%
rename from tests/tcg/cris/check_cmp-2.s
rename to tests/tcg/cris/bare/check_cmp-2.s
diff --git a/tests/tcg/cris/check_cmpc.s b/tests/tcg/cris/bare/check_cmpc.s
similarity index 100%
rename from tests/tcg/cris/check_cmpc.s
rename to tests/tcg/cris/bare/check_cmpc.s
diff --git a/tests/tcg/cris/check_cmpm.s b/tests/tcg/cris/bare/check_cmpm.s
similarity index 100%
rename from tests/tcg/cris/check_cmpm.s
rename to tests/tcg/cris/bare/check_cmpm.s
diff --git a/tests/tcg/cris/check_cmpq.s b/tests/tcg/cris/bare/check_cmpq.s
similarity index 100%
rename from tests/tcg/cris/check_cmpq.s
rename to tests/tcg/cris/bare/check_cmpq.s
diff --git a/tests/tcg/cris/check_cmpr.s b/tests/tcg/cris/bare/check_cmpr.s
similarity index 100%
rename from tests/tcg/cris/check_cmpr.s
rename to tests/tcg/cris/bare/check_cmpr.s
diff --git a/tests/tcg/cris/check_cmpxc.s b/tests/tcg/cris/bare/check_cmpxc.s
similarity index 100%
rename from tests/tcg/cris/check_cmpxc.s
rename to tests/tcg/cris/bare/check_cmpxc.s
diff --git a/tests/tcg/cris/check_cmpxm.s b/tests/tcg/cris/bare/check_cmpxm.s
similarity index 100%
rename from tests/tcg/cris/check_cmpxm.s
rename to tests/tcg/cris/bare/check_cmpxm.s
diff --git a/tests/tcg/cris/check_dstep.s b/tests/tcg/cris/bare/check_dstep.s
similarity index 100%
rename from tests/tcg/cris/check_dstep.s
rename to tests/tcg/cris/bare/check_dstep.s
diff --git a/tests/tcg/cris/check_jsr.s b/tests/tcg/cris/bare/check_jsr.s
similarity index 100%
rename from tests/tcg/cris/check_jsr.s
rename to tests/tcg/cris/bare/check_jsr.s
diff --git a/tests/tcg/cris/check_lapc.s b/tests/tcg/cris/bare/check_lapc.s
similarity index 100%
rename from tests/tcg/cris/check_lapc.s
rename to tests/tcg/cris/bare/check_lapc.s
diff --git a/tests/tcg/cris/check_lsl.s b/tests/tcg/cris/bare/check_lsl.s
similarity index 100%
rename from tests/tcg/cris/check_lsl.s
rename to tests/tcg/cris/bare/check_lsl.s
diff --git a/tests/tcg/cris/check_lsr.s b/tests/tcg/cris/bare/check_lsr.s
similarity index 100%
rename from tests/tcg/cris/check_lsr.s
rename to tests/tcg/cris/bare/check_lsr.s
diff --git a/tests/tcg/cris/check_mcp.s b/tests/tcg/cris/bare/check_mcp.s
similarity index 100%
rename from tests/tcg/cris/check_mcp.s
rename to tests/tcg/cris/bare/check_mcp.s
diff --git a/tests/tcg/cris/check_movdelsr1.s b/tests/tcg/cris/bare/check_movdelsr1.s
similarity index 100%
rename from tests/tcg/cris/check_movdelsr1.s
rename to tests/tcg/cris/bare/check_movdelsr1.s
diff --git a/tests/tcg/cris/check_movecr.s b/tests/tcg/cris/bare/check_movecr.s
similarity index 100%
rename from tests/tcg/cris/check_movecr.s
rename to tests/tcg/cris/bare/check_movecr.s
diff --git a/tests/tcg/cris/check_movei.s b/tests/tcg/cris/bare/check_movei.s
similarity index 100%
rename from tests/tcg/cris/check_movei.s
rename to tests/tcg/cris/bare/check_movei.s
diff --git a/tests/tcg/cris/check_movemr.s b/tests/tcg/cris/bare/check_movemr.s
similarity index 100%
rename from tests/tcg/cris/check_movemr.s
rename to tests/tcg/cris/bare/check_movemr.s
diff --git a/tests/tcg/cris/check_movemrv32.s b/tests/tcg/cris/bare/check_movemrv32.s
similarity index 100%
rename from tests/tcg/cris/check_movemrv32.s
rename to tests/tcg/cris/bare/check_movemrv32.s
diff --git a/tests/tcg/cris/check_mover.s b/tests/tcg/cris/bare/check_mover.s
similarity index 100%
rename from tests/tcg/cris/check_mover.s
rename to tests/tcg/cris/bare/check_mover.s
diff --git a/tests/tcg/cris/check_moverm.s b/tests/tcg/cris/bare/check_moverm.s
similarity index 100%
rename from tests/tcg/cris/check_moverm.s
rename to tests/tcg/cris/bare/check_moverm.s
diff --git a/tests/tcg/cris/check_movmp.s b/tests/tcg/cris/bare/check_movmp.s
similarity index 100%
rename from tests/tcg/cris/check_movmp.s
rename to tests/tcg/cris/bare/check_movmp.s
diff --git a/tests/tcg/cris/check_movpmv32.s b/tests/tcg/cris/bare/check_movpmv32.s
similarity index 100%
rename from tests/tcg/cris/check_movpmv32.s
rename to tests/tcg/cris/bare/check_movpmv32.s
diff --git a/tests/tcg/cris/check_movpr.s b/tests/tcg/cris/bare/check_movpr.s
similarity index 100%
rename from tests/tcg/cris/check_movpr.s
rename to tests/tcg/cris/bare/check_movpr.s
diff --git a/tests/tcg/cris/check_movprv32.s b/tests/tcg/cris/bare/check_movprv32.s
similarity index 100%
rename from tests/tcg/cris/check_movprv32.s
rename to tests/tcg/cris/bare/check_movprv32.s
diff --git a/tests/tcg/cris/check_movscr.s b/tests/tcg/cris/bare/check_movscr.s
similarity index 100%
rename from tests/tcg/cris/check_movscr.s
rename to tests/tcg/cris/bare/check_movscr.s
diff --git a/tests/tcg/cris/check_movsm.s b/tests/tcg/cris/bare/check_movsm.s
similarity index 100%
rename from tests/tcg/cris/check_movsm.s
rename to tests/tcg/cris/bare/check_movsm.s
diff --git a/tests/tcg/cris/check_movsr.s b/tests/tcg/cris/bare/check_movsr.s
similarity index 100%
rename from tests/tcg/cris/check_movsr.s
rename to tests/tcg/cris/bare/check_movsr.s
diff --git a/tests/tcg/cris/check_movucr.s b/tests/tcg/cris/bare/check_movucr.s
similarity index 100%
rename from tests/tcg/cris/check_movucr.s
rename to tests/tcg/cris/bare/check_movucr.s
diff --git a/tests/tcg/cris/check_movum.s b/tests/tcg/cris/bare/check_movum.s
similarity index 100%
rename from tests/tcg/cris/check_movum.s
rename to tests/tcg/cris/bare/check_movum.s
diff --git a/tests/tcg/cris/check_movur.s b/tests/tcg/cris/bare/check_movur.s
similarity index 100%
rename from tests/tcg/cris/check_movur.s
rename to tests/tcg/cris/bare/check_movur.s
diff --git a/tests/tcg/cris/check_mulv32.s b/tests/tcg/cris/bare/check_mulv32.s
similarity index 100%
rename from tests/tcg/cris/check_mulv32.s
rename to tests/tcg/cris/bare/check_mulv32.s
diff --git a/tests/tcg/cris/check_mulx.s b/tests/tcg/cris/bare/check_mulx.s
similarity index 100%
rename from tests/tcg/cris/check_mulx.s
rename to tests/tcg/cris/bare/check_mulx.s
diff --git a/tests/tcg/cris/check_neg.s b/tests/tcg/cris/bare/check_neg.s
similarity index 100%
rename from tests/tcg/cris/check_neg.s
rename to tests/tcg/cris/bare/check_neg.s
diff --git a/tests/tcg/cris/check_not.s b/tests/tcg/cris/bare/check_not.s
similarity index 100%
rename from tests/tcg/cris/check_not.s
rename to tests/tcg/cris/bare/check_not.s
diff --git a/tests/tcg/cris/check_orc.s b/tests/tcg/cris/bare/check_orc.s
similarity index 100%
rename from tests/tcg/cris/check_orc.s
rename to tests/tcg/cris/bare/check_orc.s
diff --git a/tests/tcg/cris/check_orm.s b/tests/tcg/cris/bare/check_orm.s
similarity index 100%
rename from tests/tcg/cris/check_orm.s
rename to tests/tcg/cris/bare/check_orm.s
diff --git a/tests/tcg/cris/check_orq.s b/tests/tcg/cris/bare/check_orq.s
similarity index 100%
rename from tests/tcg/cris/check_orq.s
rename to tests/tcg/cris/bare/check_orq.s
diff --git a/tests/tcg/cris/check_orr.s b/tests/tcg/cris/bare/check_orr.s
similarity index 100%
rename from tests/tcg/cris/check_orr.s
rename to tests/tcg/cris/bare/check_orr.s
diff --git a/tests/tcg/cris/check_ret.s b/tests/tcg/cris/bare/check_ret.s
similarity index 100%
rename from tests/tcg/cris/check_ret.s
rename to tests/tcg/cris/bare/check_ret.s
diff --git a/tests/tcg/cris/check_scc.s b/tests/tcg/cris/bare/check_scc.s
similarity index 100%
rename from tests/tcg/cris/check_scc.s
rename to tests/tcg/cris/bare/check_scc.s
diff --git a/tests/tcg/cris/check_subc.s b/tests/tcg/cris/bare/check_subc.s
similarity index 100%
rename from tests/tcg/cris/check_subc.s
rename to tests/tcg/cris/bare/check_subc.s
diff --git a/tests/tcg/cris/check_subm.s b/tests/tcg/cris/bare/check_subm.s
similarity index 100%
rename from tests/tcg/cris/check_subm.s
rename to tests/tcg/cris/bare/check_subm.s
diff --git a/tests/tcg/cris/check_subq.s b/tests/tcg/cris/bare/check_subq.s
similarity index 100%
rename from tests/tcg/cris/check_subq.s
rename to tests/tcg/cris/bare/check_subq.s
diff --git a/tests/tcg/cris/check_subr.s b/tests/tcg/cris/bare/check_subr.s
similarity index 100%
rename from tests/tcg/cris/check_subr.s
rename to tests/tcg/cris/bare/check_subr.s
diff --git a/tests/tcg/cris/check_xarith.s b/tests/tcg/cris/bare/check_xarith.s
similarity index 100%
rename from tests/tcg/cris/check_xarith.s
rename to tests/tcg/cris/bare/check_xarith.s
diff --git a/tests/tcg/cris/crt.s b/tests/tcg/cris/bare/crt.s
similarity index 100%
rename from tests/tcg/cris/crt.s
rename to tests/tcg/cris/bare/crt.s
diff --git a/tests/tcg/cris/sys.c b/tests/tcg/cris/bare/sys.c
similarity index 100%
rename from tests/tcg/cris/sys.c
rename to tests/tcg/cris/bare/sys.c
diff --git a/tests/tcg/cris/testutils.inc b/tests/tcg/cris/bare/testutils.inc
similarity index 100%
rename from tests/tcg/cris/testutils.inc
rename to tests/tcg/cris/bare/testutils.inc
diff --git a/tests/tcg/cris/check_abs.c b/tests/tcg/cris/libc/check_abs.c
similarity index 100%
rename from tests/tcg/cris/check_abs.c
rename to tests/tcg/cris/libc/check_abs.c
diff --git a/tests/tcg/cris/check_addc.c b/tests/tcg/cris/libc/check_addc.c
similarity index 100%
rename from tests/tcg/cris/check_addc.c
rename to tests/tcg/cris/libc/check_addc.c
diff --git a/tests/tcg/cris/check_addcm.c b/tests/tcg/cris/libc/check_addcm.c
similarity index 100%
rename from tests/tcg/cris/check_addcm.c
rename to tests/tcg/cris/libc/check_addcm.c
diff --git a/tests/tcg/cris/check_addo.c b/tests/tcg/cris/libc/check_addo.c
similarity index 100%
rename from tests/tcg/cris/check_addo.c
rename to tests/tcg/cris/libc/check_addo.c
diff --git a/tests/tcg/cris/check_addoq.c b/tests/tcg/cris/libc/check_addoq.c
similarity index 100%
rename from tests/tcg/cris/check_addoq.c
rename to tests/tcg/cris/libc/check_addoq.c
diff --git a/tests/tcg/cris/check_bound.c b/tests/tcg/cris/libc/check_bound.c
similarity index 100%
rename from tests/tcg/cris/check_bound.c
rename to tests/tcg/cris/libc/check_bound.c
diff --git a/tests/tcg/cris/check_ftag.c b/tests/tcg/cris/libc/check_ftag.c
similarity index 100%
rename from tests/tcg/cris/check_ftag.c
rename to tests/tcg/cris/libc/check_ftag.c
diff --git a/tests/tcg/cris/check_gcctorture_pr28634-1.c b/tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
similarity index 100%
rename from tests/tcg/cris/check_gcctorture_pr28634-1.c
rename to tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
diff --git a/tests/tcg/cris/check_gcctorture_pr28634.c b/tests/tcg/cris/libc/check_gcctorture_pr28634.c
similarity index 100%
rename from tests/tcg/cris/check_gcctorture_pr28634.c
rename to tests/tcg/cris/libc/check_gcctorture_pr28634.c
diff --git a/tests/tcg/cris/check_glibc_kernelversion.c b/tests/tcg/cris/libc/check_glibc_kernelversion.c
similarity index 100%
rename from tests/tcg/cris/check_glibc_kernelversion.c
rename to tests/tcg/cris/libc/check_glibc_kernelversion.c
diff --git a/tests/tcg/cris/check_hello.c b/tests/tcg/cris/libc/check_hello.c
similarity index 100%
rename from tests/tcg/cris/check_hello.c
rename to tests/tcg/cris/libc/check_hello.c
diff --git a/tests/tcg/cris/check_int64.c b/tests/tcg/cris/libc/check_int64.c
similarity index 100%
rename from tests/tcg/cris/check_int64.c
rename to tests/tcg/cris/libc/check_int64.c
diff --git a/tests/tcg/cris/check_lz.c b/tests/tcg/cris/libc/check_lz.c
similarity index 100%
rename from tests/tcg/cris/check_lz.c
rename to tests/tcg/cris/libc/check_lz.c
diff --git a/tests/tcg/cris/check_mapbrk.c b/tests/tcg/cris/libc/check_mapbrk.c
similarity index 100%
rename from tests/tcg/cris/check_mapbrk.c
rename to tests/tcg/cris/libc/check_mapbrk.c
diff --git a/tests/tcg/cris/check_mmap1.c b/tests/tcg/cris/libc/check_mmap1.c
similarity index 100%
rename from tests/tcg/cris/check_mmap1.c
rename to tests/tcg/cris/libc/check_mmap1.c
diff --git a/tests/tcg/cris/check_mmap2.c b/tests/tcg/cris/libc/check_mmap2.c
similarity index 100%
rename from tests/tcg/cris/check_mmap2.c
rename to tests/tcg/cris/libc/check_mmap2.c
diff --git a/tests/tcg/cris/check_mmap3.c b/tests/tcg/cris/libc/check_mmap3.c
similarity index 100%
rename from tests/tcg/cris/check_mmap3.c
rename to tests/tcg/cris/libc/check_mmap3.c
diff --git a/tests/tcg/cris/check_moveq.c b/tests/tcg/cris/libc/check_moveq.c
similarity index 100%
rename from tests/tcg/cris/check_moveq.c
rename to tests/tcg/cris/libc/check_moveq.c
diff --git a/tests/tcg/cris/check_openpf1.c b/tests/tcg/cris/libc/check_openpf1.c
similarity index 100%
rename from tests/tcg/cris/check_openpf1.c
rename to tests/tcg/cris/libc/check_openpf1.c
diff --git a/tests/tcg/cris/check_openpf2.c b/tests/tcg/cris/libc/check_openpf2.c
similarity index 100%
rename from tests/tcg/cris/check_openpf2.c
rename to tests/tcg/cris/libc/check_openpf2.c
diff --git a/tests/tcg/cris/check_openpf3.c b/tests/tcg/cris/libc/check_openpf3.c
similarity index 100%
rename from tests/tcg/cris/check_openpf3.c
rename to tests/tcg/cris/libc/check_openpf3.c
diff --git a/tests/tcg/cris/check_openpf5.c b/tests/tcg/cris/libc/check_openpf5.c
similarity index 100%
rename from tests/tcg/cris/check_openpf5.c
rename to tests/tcg/cris/libc/check_openpf5.c
diff --git a/tests/tcg/cris/check_settls1.c b/tests/tcg/cris/libc/check_settls1.c
similarity index 100%
rename from tests/tcg/cris/check_settls1.c
rename to tests/tcg/cris/libc/check_settls1.c
diff --git a/tests/tcg/cris/check_sigalrm.c b/tests/tcg/cris/libc/check_sigalrm.c
similarity index 100%
rename from tests/tcg/cris/check_sigalrm.c
rename to tests/tcg/cris/libc/check_sigalrm.c
diff --git a/tests/tcg/cris/check_stat1.c b/tests/tcg/cris/libc/check_stat1.c
similarity index 100%
rename from tests/tcg/cris/check_stat1.c
rename to tests/tcg/cris/libc/check_stat1.c
diff --git a/tests/tcg/cris/check_stat2.c b/tests/tcg/cris/libc/check_stat2.c
similarity index 100%
rename from tests/tcg/cris/check_stat2.c
rename to tests/tcg/cris/libc/check_stat2.c
diff --git a/tests/tcg/cris/check_stat3.c b/tests/tcg/cris/libc/check_stat3.c
similarity index 100%
rename from tests/tcg/cris/check_stat3.c
rename to tests/tcg/cris/libc/check_stat3.c
diff --git a/tests/tcg/cris/check_stat4.c b/tests/tcg/cris/libc/check_stat4.c
similarity index 100%
rename from tests/tcg/cris/check_stat4.c
rename to tests/tcg/cris/libc/check_stat4.c
diff --git a/tests/tcg/cris/check_swap.c b/tests/tcg/cris/libc/check_swap.c
similarity index 100%
rename from tests/tcg/cris/check_swap.c
rename to tests/tcg/cris/libc/check_swap.c
diff --git a/tests/tcg/cris/check_time2.c b/tests/tcg/cris/libc/check_time2.c
similarity index 100%
rename from tests/tcg/cris/check_time2.c
rename to tests/tcg/cris/libc/check_time2.c
diff --git a/tests/tcg/cris/crisutils.h b/tests/tcg/cris/libc/crisutils.h
similarity index 100%
rename from tests/tcg/cris/crisutils.h
rename to tests/tcg/cris/libc/crisutils.h
diff --git a/tests/tcg/cris/libc/sys.c b/tests/tcg/cris/libc/sys.c
new file mode 100644
index 0000000000..b8e759eee3
--- /dev/null
+++ b/tests/tcg/cris/libc/sys.c
@@ -0,0 +1,58 @@
+/*
+ * Minilib helpers functions for system test
+ */
+
+
+void exit (int status) {
+	register unsigned int callno asm ("r9") = 1; /* NR_exit */
+	asm volatile ("break 13\n"
+		      :
+		      : "r" (callno)
+		      : "memory" );
+	while(1);
+}
+
+ssize_t write (int fd, const void *buf, size_t count) {
+	register unsigned int callno asm ("r9") = 4; /* NR_write */
+	register unsigned int r10 asm ("r10") = fd;
+	register const void *r11 asm ("r11") = buf;
+	register size_t r12 asm ("r12") = count;
+	register unsigned int r asm ("r10");
+
+	asm volatile ("break 13\n"
+	     : "=r" (r)
+	     : "r" (callno), "0" (r10), "r" (r11), "r" (r12)
+	     : "memory");
+
+	return r;
+}
+
+static inline int mystrlen(char *s) {
+	int i = 0;
+	while (s[i])
+		i++;
+	return i;
+}
+
+void pass(void) {
+	char s[] = "passed.\n";
+	write (1, s, sizeof (s) - 1);
+	exit (0);
+}
+
+void _fail(char *reason) {
+	char s[] = "\nfailed: ";
+	int len = mystrlen(reason);
+	write (1, s, sizeof (s) - 1);
+	write (1, reason, len);
+	write (1, "\n", 1);
+//	exit (1);
+}
+
+void *memset (void *s, int c, size_t n) {
+	char *p = s;
+	int i;
+	for (i = 0; i < n; i++)
+		p[i] = c;
+	return p;
+}
diff --git a/tests/tcg/cris/sys.h b/tests/tcg/cris/libc/sys.h
similarity index 100%
rename from tests/tcg/cris/sys.h
rename to tests/tcg/cris/libc/sys.h
-- 
2.20.1
