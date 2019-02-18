Received: from eggs.gnu.org ([209.51.188.92]:54228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkun-00052T-ME
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuk-00020m-Ni
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37277 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gvkuk-0001Jq-1b
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:02 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 18 Feb 2019 16:31:33 +0100
Message-Id: <1550503897-31141-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/7] tests/tcg: target/mips: Change directory
 name 'bit-counting' to 'bit-count'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Change directory name 'bit-counting' to 'bit-count'. This is just for
cosmetic and consistency sake. This was the only subdirectory in MSA
test directory that uses ending 'ing'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_b.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_d.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_h.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_w.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_b.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_d.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_h.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_w.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_b.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_d.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_h.c | 0
 tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_w.c | 0
 12 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_b.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_d.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_h.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_w.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_b.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_d.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_h.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_w.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_b.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_d.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_h.c (100%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_w.c (100%)

diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
-- 
2.7.4
