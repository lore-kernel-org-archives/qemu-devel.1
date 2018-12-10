Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNUD-0008IU-A2
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU9-0000Y7-QF
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU9-0000Xj-89
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id 96so10928614wrb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:25 +0000
Message-Id: <20181210152829.29271-10-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 09/13] tests/tcg: split cris tests into
 system and user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This will help with the make system as we build a different set of
tests for each qemu binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/cris/{ => system}/check_addcv17.s           | 0
 tests/tcg/cris/{ => system}/check_addi.s              | 0
 tests/tcg/cris/{ => system}/check_addiv32.s           | 0
 tests/tcg/cris/{ => system}/check_addm.s              | 0
 tests/tcg/cris/{ => system}/check_addq.s              | 0
 tests/tcg/cris/{ => system}/check_addr.s              | 0
 tests/tcg/cris/{ => system}/check_addxc.s             | 0
 tests/tcg/cris/{ => system}/check_addxm.s             | 0
 tests/tcg/cris/{ => system}/check_addxr.s             | 0
 tests/tcg/cris/{ => system}/check_andc.s              | 0
 tests/tcg/cris/{ => system}/check_andm.s              | 0
 tests/tcg/cris/{ => system}/check_andq.s              | 0
 tests/tcg/cris/{ => system}/check_andr.s              | 0
 tests/tcg/cris/{ => system}/check_asr.s               | 0
 tests/tcg/cris/{ => system}/check_ba.s                | 0
 tests/tcg/cris/{ => system}/check_bas.s               | 0
 tests/tcg/cris/{ => system}/check_bcc.s               | 0
 tests/tcg/cris/{ => system}/check_boundc.s            | 0
 tests/tcg/cris/{ => system}/check_boundr.s            | 0
 tests/tcg/cris/{ => system}/check_btst.s              | 0
 tests/tcg/cris/{ => system}/check_clearfv32.s         | 0
 tests/tcg/cris/{ => system}/check_clrjmp1.s           | 0
 tests/tcg/cris/{ => system}/check_cmp-2.s             | 0
 tests/tcg/cris/{ => system}/check_cmpc.s              | 0
 tests/tcg/cris/{ => system}/check_cmpm.s              | 0
 tests/tcg/cris/{ => system}/check_cmpq.s              | 0
 tests/tcg/cris/{ => system}/check_cmpr.s              | 0
 tests/tcg/cris/{ => system}/check_cmpxc.s             | 0
 tests/tcg/cris/{ => system}/check_cmpxm.s             | 0
 tests/tcg/cris/{ => system}/check_dstep.s             | 0
 tests/tcg/cris/{ => system}/check_jsr.s               | 0
 tests/tcg/cris/{ => system}/check_lapc.s              | 0
 tests/tcg/cris/{ => system}/check_lsl.s               | 0
 tests/tcg/cris/{ => system}/check_lsr.s               | 0
 tests/tcg/cris/{ => system}/check_mcp.s               | 0
 tests/tcg/cris/{ => system}/check_movdelsr1.s         | 0
 tests/tcg/cris/{ => system}/check_movecr.s            | 0
 tests/tcg/cris/{ => system}/check_movei.s             | 0
 tests/tcg/cris/{ => system}/check_movemr.s            | 0
 tests/tcg/cris/{ => system}/check_movemrv32.s         | 0
 tests/tcg/cris/{ => system}/check_mover.s             | 0
 tests/tcg/cris/{ => system}/check_moverm.s            | 0
 tests/tcg/cris/{ => system}/check_movmp.s             | 0
 tests/tcg/cris/{ => system}/check_movpmv32.s          | 0
 tests/tcg/cris/{ => system}/check_movpr.s             | 0
 tests/tcg/cris/{ => system}/check_movprv32.s          | 0
 tests/tcg/cris/{ => system}/check_movscr.s            | 0
 tests/tcg/cris/{ => system}/check_movsm.s             | 0
 tests/tcg/cris/{ => system}/check_movsr.s             | 0
 tests/tcg/cris/{ => system}/check_movucr.s            | 0
 tests/tcg/cris/{ => system}/check_movum.s             | 0
 tests/tcg/cris/{ => system}/check_movur.s             | 0
 tests/tcg/cris/{ => system}/check_mulv32.s            | 0
 tests/tcg/cris/{ => system}/check_mulx.s              | 0
 tests/tcg/cris/{ => system}/check_neg.s               | 0
 tests/tcg/cris/{ => system}/check_not.s               | 0
 tests/tcg/cris/{ => system}/check_orc.s               | 0
 tests/tcg/cris/{ => system}/check_orm.s               | 0
 tests/tcg/cris/{ => system}/check_orq.s               | 0
 tests/tcg/cris/{ => system}/check_orr.s               | 0
 tests/tcg/cris/{ => system}/check_ret.s               | 0
 tests/tcg/cris/{ => system}/check_scc.s               | 0
 tests/tcg/cris/{ => system}/check_subc.s              | 0
 tests/tcg/cris/{ => system}/check_subm.s              | 0
 tests/tcg/cris/{ => system}/check_subq.s              | 0
 tests/tcg/cris/{ => system}/check_subr.s              | 0
 tests/tcg/cris/{ => system}/check_xarith.s            | 0
 tests/tcg/cris/{ => system}/crt.s                     | 0
 tests/tcg/cris/{ => system}/sys.c                     | 0
 tests/tcg/cris/{ => system}/testutils.inc             | 0
 tests/tcg/cris/{ => user}/check_abs.c                 | 0
 tests/tcg/cris/{ => user}/check_addc.c                | 0
 tests/tcg/cris/{ => user}/check_addcm.c               | 0
 tests/tcg/cris/{ => user}/check_addo.c                | 0
 tests/tcg/cris/{ => user}/check_addoq.c               | 0
 tests/tcg/cris/{ => user}/check_bound.c               | 0
 tests/tcg/cris/{ => user}/check_ftag.c                | 0
 tests/tcg/cris/{ => user}/check_glibc_kernelversion.c | 0
 tests/tcg/cris/{ => user}/check_hello.c               | 0
 tests/tcg/cris/{ => user}/check_int64.c               | 0
 tests/tcg/cris/{ => user}/check_lz.c                  | 0
 tests/tcg/cris/{ => user}/check_mapbrk.c              | 0
 tests/tcg/cris/{ => user}/check_mmap1.c               | 0
 tests/tcg/cris/{ => user}/check_mmap2.c               | 0
 tests/tcg/cris/{ => user}/check_mmap3.c               | 0
 tests/tcg/cris/{ => user}/check_moveq.c               | 0
 tests/tcg/cris/{ => user}/check_openpf1.c             | 0
 tests/tcg/cris/{ => user}/check_openpf2.c             | 0
 tests/tcg/cris/{ => user}/check_openpf3.c             | 0
 tests/tcg/cris/{ => user}/check_openpf5.c             | 0
 tests/tcg/cris/{ => user}/check_settls1.c             | 0
 tests/tcg/cris/{ => user}/check_sigalrm.c             | 0
 tests/tcg/cris/{ => user}/check_stat1.c               | 0
 tests/tcg/cris/{ => user}/check_stat2.c               | 0
 tests/tcg/cris/{ => user}/check_stat3.c               | 0
 tests/tcg/cris/{ => user}/check_stat4.c               | 0
 tests/tcg/cris/{ => user}/check_swap.c                | 0
 tests/tcg/cris/{ => user}/check_time2.c               | 0
 tests/tcg/cris/{ => user}/crisutils.h                 | 0
 tests/tcg/cris/{ => user}/sys.h                       | 0
 100 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/cris/{ => system}/check_addcv17.s (100%)
 rename tests/tcg/cris/{ => system}/check_addi.s (100%)
 rename tests/tcg/cris/{ => system}/check_addiv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_addm.s (100%)
 rename tests/tcg/cris/{ => system}/check_addq.s (100%)
 rename tests/tcg/cris/{ => system}/check_addr.s (100%)
 rename tests/tcg/cris/{ => system}/check_addxc.s (100%)
 rename tests/tcg/cris/{ => system}/check_addxm.s (100%)
 rename tests/tcg/cris/{ => system}/check_addxr.s (100%)
 rename tests/tcg/cris/{ => system}/check_andc.s (100%)
 rename tests/tcg/cris/{ => system}/check_andm.s (100%)
 rename tests/tcg/cris/{ => system}/check_andq.s (100%)
 rename tests/tcg/cris/{ => system}/check_andr.s (100%)
 rename tests/tcg/cris/{ => system}/check_asr.s (100%)
 rename tests/tcg/cris/{ => system}/check_ba.s (100%)
 rename tests/tcg/cris/{ => system}/check_bas.s (100%)
 rename tests/tcg/cris/{ => system}/check_bcc.s (100%)
 rename tests/tcg/cris/{ => system}/check_boundc.s (100%)
 rename tests/tcg/cris/{ => system}/check_boundr.s (100%)
 rename tests/tcg/cris/{ => system}/check_btst.s (100%)
 rename tests/tcg/cris/{ => system}/check_clearfv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_clrjmp1.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmp-2.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpc.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpm.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpq.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpr.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpxc.s (100%)
 rename tests/tcg/cris/{ => system}/check_cmpxm.s (100%)
 rename tests/tcg/cris/{ => system}/check_dstep.s (100%)
 rename tests/tcg/cris/{ => system}/check_jsr.s (100%)
 rename tests/tcg/cris/{ => system}/check_lapc.s (100%)
 rename tests/tcg/cris/{ => system}/check_lsl.s (100%)
 rename tests/tcg/cris/{ => system}/check_lsr.s (100%)
 rename tests/tcg/cris/{ => system}/check_mcp.s (100%)
 rename tests/tcg/cris/{ => system}/check_movdelsr1.s (100%)
 rename tests/tcg/cris/{ => system}/check_movecr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movei.s (100%)
 rename tests/tcg/cris/{ => system}/check_movemr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movemrv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_mover.s (100%)
 rename tests/tcg/cris/{ => system}/check_moverm.s (100%)
 rename tests/tcg/cris/{ => system}/check_movmp.s (100%)
 rename tests/tcg/cris/{ => system}/check_movpmv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_movpr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movprv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_movscr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movsm.s (100%)
 rename tests/tcg/cris/{ => system}/check_movsr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movucr.s (100%)
 rename tests/tcg/cris/{ => system}/check_movum.s (100%)
 rename tests/tcg/cris/{ => system}/check_movur.s (100%)
 rename tests/tcg/cris/{ => system}/check_mulv32.s (100%)
 rename tests/tcg/cris/{ => system}/check_mulx.s (100%)
 rename tests/tcg/cris/{ => system}/check_neg.s (100%)
 rename tests/tcg/cris/{ => system}/check_not.s (100%)
 rename tests/tcg/cris/{ => system}/check_orc.s (100%)
 rename tests/tcg/cris/{ => system}/check_orm.s (100%)
 rename tests/tcg/cris/{ => system}/check_orq.s (100%)
 rename tests/tcg/cris/{ => system}/check_orr.s (100%)
 rename tests/tcg/cris/{ => system}/check_ret.s (100%)
 rename tests/tcg/cris/{ => system}/check_scc.s (100%)
 rename tests/tcg/cris/{ => system}/check_subc.s (100%)
 rename tests/tcg/cris/{ => system}/check_subm.s (100%)
 rename tests/tcg/cris/{ => system}/check_subq.s (100%)
 rename tests/tcg/cris/{ => system}/check_subr.s (100%)
 rename tests/tcg/cris/{ => system}/check_xarith.s (100%)
 rename tests/tcg/cris/{ => system}/crt.s (100%)
 rename tests/tcg/cris/{ => system}/sys.c (100%)
 rename tests/tcg/cris/{ => system}/testutils.inc (100%)
 rename tests/tcg/cris/{ => user}/check_abs.c (100%)
 rename tests/tcg/cris/{ => user}/check_addc.c (100%)
 rename tests/tcg/cris/{ => user}/check_addcm.c (100%)
 rename tests/tcg/cris/{ => user}/check_addo.c (100%)
 rename tests/tcg/cris/{ => user}/check_addoq.c (100%)
 rename tests/tcg/cris/{ => user}/check_bound.c (100%)
 rename tests/tcg/cris/{ => user}/check_ftag.c (100%)
 rename tests/tcg/cris/{ => user}/check_glibc_kernelversion.c (100%)
 rename tests/tcg/cris/{ => user}/check_hello.c (100%)
 rename tests/tcg/cris/{ => user}/check_int64.c (100%)
 rename tests/tcg/cris/{ => user}/check_lz.c (100%)
 rename tests/tcg/cris/{ => user}/check_mapbrk.c (100%)
 rename tests/tcg/cris/{ => user}/check_mmap1.c (100%)
 rename tests/tcg/cris/{ => user}/check_mmap2.c (100%)
 rename tests/tcg/cris/{ => user}/check_mmap3.c (100%)
 rename tests/tcg/cris/{ => user}/check_moveq.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf1.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf2.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf3.c (100%)
 rename tests/tcg/cris/{ => user}/check_openpf5.c (100%)
 rename tests/tcg/cris/{ => user}/check_settls1.c (100%)
 rename tests/tcg/cris/{ => user}/check_sigalrm.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat1.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat2.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat3.c (100%)
 rename tests/tcg/cris/{ => user}/check_stat4.c (100%)
 rename tests/tcg/cris/{ => user}/check_swap.c (100%)
 rename tests/tcg/cris/{ => user}/check_time2.c (100%)
 rename tests/tcg/cris/{ => user}/crisutils.h (100%)
 rename tests/tcg/cris/{ => user}/sys.h (100%)

diff --git a/tests/tcg/cris/check_addcv17.s b/tests/tcg/cris/system/check_addcv17.s
similarity index 100%
rename from tests/tcg/cris/check_addcv17.s
rename to tests/tcg/cris/system/check_addcv17.s
diff --git a/tests/tcg/cris/check_addi.s b/tests/tcg/cris/system/check_addi.s
similarity index 100%
rename from tests/tcg/cris/check_addi.s
rename to tests/tcg/cris/system/check_addi.s
diff --git a/tests/tcg/cris/check_addiv32.s b/tests/tcg/cris/system/check_addiv32.s
similarity index 100%
rename from tests/tcg/cris/check_addiv32.s
rename to tests/tcg/cris/system/check_addiv32.s
diff --git a/tests/tcg/cris/check_addm.s b/tests/tcg/cris/system/check_addm.s
similarity index 100%
rename from tests/tcg/cris/check_addm.s
rename to tests/tcg/cris/system/check_addm.s
diff --git a/tests/tcg/cris/check_addq.s b/tests/tcg/cris/system/check_addq.s
similarity index 100%
rename from tests/tcg/cris/check_addq.s
rename to tests/tcg/cris/system/check_addq.s
diff --git a/tests/tcg/cris/check_addr.s b/tests/tcg/cris/system/check_addr.s
similarity index 100%
rename from tests/tcg/cris/check_addr.s
rename to tests/tcg/cris/system/check_addr.s
diff --git a/tests/tcg/cris/check_addxc.s b/tests/tcg/cris/system/check_addxc.s
similarity index 100%
rename from tests/tcg/cris/check_addxc.s
rename to tests/tcg/cris/system/check_addxc.s
diff --git a/tests/tcg/cris/check_addxm.s b/tests/tcg/cris/system/check_addxm.s
similarity index 100%
rename from tests/tcg/cris/check_addxm.s
rename to tests/tcg/cris/system/check_addxm.s
diff --git a/tests/tcg/cris/check_addxr.s b/tests/tcg/cris/system/check_addxr.s
similarity index 100%
rename from tests/tcg/cris/check_addxr.s
rename to tests/tcg/cris/system/check_addxr.s
diff --git a/tests/tcg/cris/check_andc.s b/tests/tcg/cris/system/check_andc.s
similarity index 100%
rename from tests/tcg/cris/check_andc.s
rename to tests/tcg/cris/system/check_andc.s
diff --git a/tests/tcg/cris/check_andm.s b/tests/tcg/cris/system/check_andm.s
similarity index 100%
rename from tests/tcg/cris/check_andm.s
rename to tests/tcg/cris/system/check_andm.s
diff --git a/tests/tcg/cris/check_andq.s b/tests/tcg/cris/system/check_andq.s
similarity index 100%
rename from tests/tcg/cris/check_andq.s
rename to tests/tcg/cris/system/check_andq.s
diff --git a/tests/tcg/cris/check_andr.s b/tests/tcg/cris/system/check_andr.s
similarity index 100%
rename from tests/tcg/cris/check_andr.s
rename to tests/tcg/cris/system/check_andr.s
diff --git a/tests/tcg/cris/check_asr.s b/tests/tcg/cris/system/check_asr.s
similarity index 100%
rename from tests/tcg/cris/check_asr.s
rename to tests/tcg/cris/system/check_asr.s
diff --git a/tests/tcg/cris/check_ba.s b/tests/tcg/cris/system/check_ba.s
similarity index 100%
rename from tests/tcg/cris/check_ba.s
rename to tests/tcg/cris/system/check_ba.s
diff --git a/tests/tcg/cris/check_bas.s b/tests/tcg/cris/system/check_bas.s
similarity index 100%
rename from tests/tcg/cris/check_bas.s
rename to tests/tcg/cris/system/check_bas.s
diff --git a/tests/tcg/cris/check_bcc.s b/tests/tcg/cris/system/check_bcc.s
similarity index 100%
rename from tests/tcg/cris/check_bcc.s
rename to tests/tcg/cris/system/check_bcc.s
diff --git a/tests/tcg/cris/check_boundc.s b/tests/tcg/cris/system/check_boundc.s
similarity index 100%
rename from tests/tcg/cris/check_boundc.s
rename to tests/tcg/cris/system/check_boundc.s
diff --git a/tests/tcg/cris/check_boundr.s b/tests/tcg/cris/system/check_boundr.s
similarity index 100%
rename from tests/tcg/cris/check_boundr.s
rename to tests/tcg/cris/system/check_boundr.s
diff --git a/tests/tcg/cris/check_btst.s b/tests/tcg/cris/system/check_btst.s
similarity index 100%
rename from tests/tcg/cris/check_btst.s
rename to tests/tcg/cris/system/check_btst.s
diff --git a/tests/tcg/cris/check_clearfv32.s b/tests/tcg/cris/system/check_clearfv32.s
similarity index 100%
rename from tests/tcg/cris/check_clearfv32.s
rename to tests/tcg/cris/system/check_clearfv32.s
diff --git a/tests/tcg/cris/check_clrjmp1.s b/tests/tcg/cris/system/check_clrjmp1.s
similarity index 100%
rename from tests/tcg/cris/check_clrjmp1.s
rename to tests/tcg/cris/system/check_clrjmp1.s
diff --git a/tests/tcg/cris/check_cmp-2.s b/tests/tcg/cris/system/check_cmp-2.s
similarity index 100%
rename from tests/tcg/cris/check_cmp-2.s
rename to tests/tcg/cris/system/check_cmp-2.s
diff --git a/tests/tcg/cris/check_cmpc.s b/tests/tcg/cris/system/check_cmpc.s
similarity index 100%
rename from tests/tcg/cris/check_cmpc.s
rename to tests/tcg/cris/system/check_cmpc.s
diff --git a/tests/tcg/cris/check_cmpm.s b/tests/tcg/cris/system/check_cmpm.s
similarity index 100%
rename from tests/tcg/cris/check_cmpm.s
rename to tests/tcg/cris/system/check_cmpm.s
diff --git a/tests/tcg/cris/check_cmpq.s b/tests/tcg/cris/system/check_cmpq.s
similarity index 100%
rename from tests/tcg/cris/check_cmpq.s
rename to tests/tcg/cris/system/check_cmpq.s
diff --git a/tests/tcg/cris/check_cmpr.s b/tests/tcg/cris/system/check_cmpr.s
similarity index 100%
rename from tests/tcg/cris/check_cmpr.s
rename to tests/tcg/cris/system/check_cmpr.s
diff --git a/tests/tcg/cris/check_cmpxc.s b/tests/tcg/cris/system/check_cmpxc.s
similarity index 100%
rename from tests/tcg/cris/check_cmpxc.s
rename to tests/tcg/cris/system/check_cmpxc.s
diff --git a/tests/tcg/cris/check_cmpxm.s b/tests/tcg/cris/system/check_cmpxm.s
similarity index 100%
rename from tests/tcg/cris/check_cmpxm.s
rename to tests/tcg/cris/system/check_cmpxm.s
diff --git a/tests/tcg/cris/check_dstep.s b/tests/tcg/cris/system/check_dstep.s
similarity index 100%
rename from tests/tcg/cris/check_dstep.s
rename to tests/tcg/cris/system/check_dstep.s
diff --git a/tests/tcg/cris/check_jsr.s b/tests/tcg/cris/system/check_jsr.s
similarity index 100%
rename from tests/tcg/cris/check_jsr.s
rename to tests/tcg/cris/system/check_jsr.s
diff --git a/tests/tcg/cris/check_lapc.s b/tests/tcg/cris/system/check_lapc.s
similarity index 100%
rename from tests/tcg/cris/check_lapc.s
rename to tests/tcg/cris/system/check_lapc.s
diff --git a/tests/tcg/cris/check_lsl.s b/tests/tcg/cris/system/check_lsl.s
similarity index 100%
rename from tests/tcg/cris/check_lsl.s
rename to tests/tcg/cris/system/check_lsl.s
diff --git a/tests/tcg/cris/check_lsr.s b/tests/tcg/cris/system/check_lsr.s
similarity index 100%
rename from tests/tcg/cris/check_lsr.s
rename to tests/tcg/cris/system/check_lsr.s
diff --git a/tests/tcg/cris/check_mcp.s b/tests/tcg/cris/system/check_mcp.s
similarity index 100%
rename from tests/tcg/cris/check_mcp.s
rename to tests/tcg/cris/system/check_mcp.s
diff --git a/tests/tcg/cris/check_movdelsr1.s b/tests/tcg/cris/system/check_movdelsr1.s
similarity index 100%
rename from tests/tcg/cris/check_movdelsr1.s
rename to tests/tcg/cris/system/check_movdelsr1.s
diff --git a/tests/tcg/cris/check_movecr.s b/tests/tcg/cris/system/check_movecr.s
similarity index 100%
rename from tests/tcg/cris/check_movecr.s
rename to tests/tcg/cris/system/check_movecr.s
diff --git a/tests/tcg/cris/check_movei.s b/tests/tcg/cris/system/check_movei.s
similarity index 100%
rename from tests/tcg/cris/check_movei.s
rename to tests/tcg/cris/system/check_movei.s
diff --git a/tests/tcg/cris/check_movemr.s b/tests/tcg/cris/system/check_movemr.s
similarity index 100%
rename from tests/tcg/cris/check_movemr.s
rename to tests/tcg/cris/system/check_movemr.s
diff --git a/tests/tcg/cris/check_movemrv32.s b/tests/tcg/cris/system/check_movemrv32.s
similarity index 100%
rename from tests/tcg/cris/check_movemrv32.s
rename to tests/tcg/cris/system/check_movemrv32.s
diff --git a/tests/tcg/cris/check_mover.s b/tests/tcg/cris/system/check_mover.s
similarity index 100%
rename from tests/tcg/cris/check_mover.s
rename to tests/tcg/cris/system/check_mover.s
diff --git a/tests/tcg/cris/check_moverm.s b/tests/tcg/cris/system/check_moverm.s
similarity index 100%
rename from tests/tcg/cris/check_moverm.s
rename to tests/tcg/cris/system/check_moverm.s
diff --git a/tests/tcg/cris/check_movmp.s b/tests/tcg/cris/system/check_movmp.s
similarity index 100%
rename from tests/tcg/cris/check_movmp.s
rename to tests/tcg/cris/system/check_movmp.s
diff --git a/tests/tcg/cris/check_movpmv32.s b/tests/tcg/cris/system/check_movpmv32.s
similarity index 100%
rename from tests/tcg/cris/check_movpmv32.s
rename to tests/tcg/cris/system/check_movpmv32.s
diff --git a/tests/tcg/cris/check_movpr.s b/tests/tcg/cris/system/check_movpr.s
similarity index 100%
rename from tests/tcg/cris/check_movpr.s
rename to tests/tcg/cris/system/check_movpr.s
diff --git a/tests/tcg/cris/check_movprv32.s b/tests/tcg/cris/system/check_movprv32.s
similarity index 100%
rename from tests/tcg/cris/check_movprv32.s
rename to tests/tcg/cris/system/check_movprv32.s
diff --git a/tests/tcg/cris/check_movscr.s b/tests/tcg/cris/system/check_movscr.s
similarity index 100%
rename from tests/tcg/cris/check_movscr.s
rename to tests/tcg/cris/system/check_movscr.s
diff --git a/tests/tcg/cris/check_movsm.s b/tests/tcg/cris/system/check_movsm.s
similarity index 100%
rename from tests/tcg/cris/check_movsm.s
rename to tests/tcg/cris/system/check_movsm.s
diff --git a/tests/tcg/cris/check_movsr.s b/tests/tcg/cris/system/check_movsr.s
similarity index 100%
rename from tests/tcg/cris/check_movsr.s
rename to tests/tcg/cris/system/check_movsr.s
diff --git a/tests/tcg/cris/check_movucr.s b/tests/tcg/cris/system/check_movucr.s
similarity index 100%
rename from tests/tcg/cris/check_movucr.s
rename to tests/tcg/cris/system/check_movucr.s
diff --git a/tests/tcg/cris/check_movum.s b/tests/tcg/cris/system/check_movum.s
similarity index 100%
rename from tests/tcg/cris/check_movum.s
rename to tests/tcg/cris/system/check_movum.s
diff --git a/tests/tcg/cris/check_movur.s b/tests/tcg/cris/system/check_movur.s
similarity index 100%
rename from tests/tcg/cris/check_movur.s
rename to tests/tcg/cris/system/check_movur.s
diff --git a/tests/tcg/cris/check_mulv32.s b/tests/tcg/cris/system/check_mulv32.s
similarity index 100%
rename from tests/tcg/cris/check_mulv32.s
rename to tests/tcg/cris/system/check_mulv32.s
diff --git a/tests/tcg/cris/check_mulx.s b/tests/tcg/cris/system/check_mulx.s
similarity index 100%
rename from tests/tcg/cris/check_mulx.s
rename to tests/tcg/cris/system/check_mulx.s
diff --git a/tests/tcg/cris/check_neg.s b/tests/tcg/cris/system/check_neg.s
similarity index 100%
rename from tests/tcg/cris/check_neg.s
rename to tests/tcg/cris/system/check_neg.s
diff --git a/tests/tcg/cris/check_not.s b/tests/tcg/cris/system/check_not.s
similarity index 100%
rename from tests/tcg/cris/check_not.s
rename to tests/tcg/cris/system/check_not.s
diff --git a/tests/tcg/cris/check_orc.s b/tests/tcg/cris/system/check_orc.s
similarity index 100%
rename from tests/tcg/cris/check_orc.s
rename to tests/tcg/cris/system/check_orc.s
diff --git a/tests/tcg/cris/check_orm.s b/tests/tcg/cris/system/check_orm.s
similarity index 100%
rename from tests/tcg/cris/check_orm.s
rename to tests/tcg/cris/system/check_orm.s
diff --git a/tests/tcg/cris/check_orq.s b/tests/tcg/cris/system/check_orq.s
similarity index 100%
rename from tests/tcg/cris/check_orq.s
rename to tests/tcg/cris/system/check_orq.s
diff --git a/tests/tcg/cris/check_orr.s b/tests/tcg/cris/system/check_orr.s
similarity index 100%
rename from tests/tcg/cris/check_orr.s
rename to tests/tcg/cris/system/check_orr.s
diff --git a/tests/tcg/cris/check_ret.s b/tests/tcg/cris/system/check_ret.s
similarity index 100%
rename from tests/tcg/cris/check_ret.s
rename to tests/tcg/cris/system/check_ret.s
diff --git a/tests/tcg/cris/check_scc.s b/tests/tcg/cris/system/check_scc.s
similarity index 100%
rename from tests/tcg/cris/check_scc.s
rename to tests/tcg/cris/system/check_scc.s
diff --git a/tests/tcg/cris/check_subc.s b/tests/tcg/cris/system/check_subc.s
similarity index 100%
rename from tests/tcg/cris/check_subc.s
rename to tests/tcg/cris/system/check_subc.s
diff --git a/tests/tcg/cris/check_subm.s b/tests/tcg/cris/system/check_subm.s
similarity index 100%
rename from tests/tcg/cris/check_subm.s
rename to tests/tcg/cris/system/check_subm.s
diff --git a/tests/tcg/cris/check_subq.s b/tests/tcg/cris/system/check_subq.s
similarity index 100%
rename from tests/tcg/cris/check_subq.s
rename to tests/tcg/cris/system/check_subq.s
diff --git a/tests/tcg/cris/check_subr.s b/tests/tcg/cris/system/check_subr.s
similarity index 100%
rename from tests/tcg/cris/check_subr.s
rename to tests/tcg/cris/system/check_subr.s
diff --git a/tests/tcg/cris/check_xarith.s b/tests/tcg/cris/system/check_xarith.s
similarity index 100%
rename from tests/tcg/cris/check_xarith.s
rename to tests/tcg/cris/system/check_xarith.s
diff --git a/tests/tcg/cris/crt.s b/tests/tcg/cris/system/crt.s
similarity index 100%
rename from tests/tcg/cris/crt.s
rename to tests/tcg/cris/system/crt.s
diff --git a/tests/tcg/cris/sys.c b/tests/tcg/cris/system/sys.c
similarity index 100%
rename from tests/tcg/cris/sys.c
rename to tests/tcg/cris/system/sys.c
diff --git a/tests/tcg/cris/testutils.inc b/tests/tcg/cris/system/testutils.inc
similarity index 100%
rename from tests/tcg/cris/testutils.inc
rename to tests/tcg/cris/system/testutils.inc
diff --git a/tests/tcg/cris/check_abs.c b/tests/tcg/cris/user/check_abs.c
similarity index 100%
rename from tests/tcg/cris/check_abs.c
rename to tests/tcg/cris/user/check_abs.c
diff --git a/tests/tcg/cris/check_addc.c b/tests/tcg/cris/user/check_addc.c
similarity index 100%
rename from tests/tcg/cris/check_addc.c
rename to tests/tcg/cris/user/check_addc.c
diff --git a/tests/tcg/cris/check_addcm.c b/tests/tcg/cris/user/check_addcm.c
similarity index 100%
rename from tests/tcg/cris/check_addcm.c
rename to tests/tcg/cris/user/check_addcm.c
diff --git a/tests/tcg/cris/check_addo.c b/tests/tcg/cris/user/check_addo.c
similarity index 100%
rename from tests/tcg/cris/check_addo.c
rename to tests/tcg/cris/user/check_addo.c
diff --git a/tests/tcg/cris/check_addoq.c b/tests/tcg/cris/user/check_addoq.c
similarity index 100%
rename from tests/tcg/cris/check_addoq.c
rename to tests/tcg/cris/user/check_addoq.c
diff --git a/tests/tcg/cris/check_bound.c b/tests/tcg/cris/user/check_bound.c
similarity index 100%
rename from tests/tcg/cris/check_bound.c
rename to tests/tcg/cris/user/check_bound.c
diff --git a/tests/tcg/cris/check_ftag.c b/tests/tcg/cris/user/check_ftag.c
similarity index 100%
rename from tests/tcg/cris/check_ftag.c
rename to tests/tcg/cris/user/check_ftag.c
diff --git a/tests/tcg/cris/check_glibc_kernelversion.c b/tests/tcg/cris/user/check_glibc_kernelversion.c
similarity index 100%
rename from tests/tcg/cris/check_glibc_kernelversion.c
rename to tests/tcg/cris/user/check_glibc_kernelversion.c
diff --git a/tests/tcg/cris/check_hello.c b/tests/tcg/cris/user/check_hello.c
similarity index 100%
rename from tests/tcg/cris/check_hello.c
rename to tests/tcg/cris/user/check_hello.c
diff --git a/tests/tcg/cris/check_int64.c b/tests/tcg/cris/user/check_int64.c
similarity index 100%
rename from tests/tcg/cris/check_int64.c
rename to tests/tcg/cris/user/check_int64.c
diff --git a/tests/tcg/cris/check_lz.c b/tests/tcg/cris/user/check_lz.c
similarity index 100%
rename from tests/tcg/cris/check_lz.c
rename to tests/tcg/cris/user/check_lz.c
diff --git a/tests/tcg/cris/check_mapbrk.c b/tests/tcg/cris/user/check_mapbrk.c
similarity index 100%
rename from tests/tcg/cris/check_mapbrk.c
rename to tests/tcg/cris/user/check_mapbrk.c
diff --git a/tests/tcg/cris/check_mmap1.c b/tests/tcg/cris/user/check_mmap1.c
similarity index 100%
rename from tests/tcg/cris/check_mmap1.c
rename to tests/tcg/cris/user/check_mmap1.c
diff --git a/tests/tcg/cris/check_mmap2.c b/tests/tcg/cris/user/check_mmap2.c
similarity index 100%
rename from tests/tcg/cris/check_mmap2.c
rename to tests/tcg/cris/user/check_mmap2.c
diff --git a/tests/tcg/cris/check_mmap3.c b/tests/tcg/cris/user/check_mmap3.c
similarity index 100%
rename from tests/tcg/cris/check_mmap3.c
rename to tests/tcg/cris/user/check_mmap3.c
diff --git a/tests/tcg/cris/check_moveq.c b/tests/tcg/cris/user/check_moveq.c
similarity index 100%
rename from tests/tcg/cris/check_moveq.c
rename to tests/tcg/cris/user/check_moveq.c
diff --git a/tests/tcg/cris/check_openpf1.c b/tests/tcg/cris/user/check_openpf1.c
similarity index 100%
rename from tests/tcg/cris/check_openpf1.c
rename to tests/tcg/cris/user/check_openpf1.c
diff --git a/tests/tcg/cris/check_openpf2.c b/tests/tcg/cris/user/check_openpf2.c
similarity index 100%
rename from tests/tcg/cris/check_openpf2.c
rename to tests/tcg/cris/user/check_openpf2.c
diff --git a/tests/tcg/cris/check_openpf3.c b/tests/tcg/cris/user/check_openpf3.c
similarity index 100%
rename from tests/tcg/cris/check_openpf3.c
rename to tests/tcg/cris/user/check_openpf3.c
diff --git a/tests/tcg/cris/check_openpf5.c b/tests/tcg/cris/user/check_openpf5.c
similarity index 100%
rename from tests/tcg/cris/check_openpf5.c
rename to tests/tcg/cris/user/check_openpf5.c
diff --git a/tests/tcg/cris/check_settls1.c b/tests/tcg/cris/user/check_settls1.c
similarity index 100%
rename from tests/tcg/cris/check_settls1.c
rename to tests/tcg/cris/user/check_settls1.c
diff --git a/tests/tcg/cris/check_sigalrm.c b/tests/tcg/cris/user/check_sigalrm.c
similarity index 100%
rename from tests/tcg/cris/check_sigalrm.c
rename to tests/tcg/cris/user/check_sigalrm.c
diff --git a/tests/tcg/cris/check_stat1.c b/tests/tcg/cris/user/check_stat1.c
similarity index 100%
rename from tests/tcg/cris/check_stat1.c
rename to tests/tcg/cris/user/check_stat1.c
diff --git a/tests/tcg/cris/check_stat2.c b/tests/tcg/cris/user/check_stat2.c
similarity index 100%
rename from tests/tcg/cris/check_stat2.c
rename to tests/tcg/cris/user/check_stat2.c
diff --git a/tests/tcg/cris/check_stat3.c b/tests/tcg/cris/user/check_stat3.c
similarity index 100%
rename from tests/tcg/cris/check_stat3.c
rename to tests/tcg/cris/user/check_stat3.c
diff --git a/tests/tcg/cris/check_stat4.c b/tests/tcg/cris/user/check_stat4.c
similarity index 100%
rename from tests/tcg/cris/check_stat4.c
rename to tests/tcg/cris/user/check_stat4.c
diff --git a/tests/tcg/cris/check_swap.c b/tests/tcg/cris/user/check_swap.c
similarity index 100%
rename from tests/tcg/cris/check_swap.c
rename to tests/tcg/cris/user/check_swap.c
diff --git a/tests/tcg/cris/check_time2.c b/tests/tcg/cris/user/check_time2.c
similarity index 100%
rename from tests/tcg/cris/check_time2.c
rename to tests/tcg/cris/user/check_time2.c
diff --git a/tests/tcg/cris/crisutils.h b/tests/tcg/cris/user/crisutils.h
similarity index 100%
rename from tests/tcg/cris/crisutils.h
rename to tests/tcg/cris/user/crisutils.h
diff --git a/tests/tcg/cris/sys.h b/tests/tcg/cris/user/sys.h
similarity index 100%
rename from tests/tcg/cris/sys.h
rename to tests/tcg/cris/user/sys.h
-- 
2.17.1
