Received: from eggs.gnu.org ([209.51.188.92]:39236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1vDv-0004RD-15
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1vDm-0005Zz-MD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:46:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:59556 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1vDl-0004pF-N6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:46:10 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  7 Mar 2019 16:44:46 +0100
Message-Id: <1551973487-7114-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551973487-7114-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551973487-7114-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/2] tests/tcg: target/mips: Correct preambles
 of test source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Correct preambles of test source files.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c     | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c     | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c     | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c     | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c      | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c      | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c      | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c      | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c    | 2 +-
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c        | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c         | 4 ++--
 114 files changed, 202 insertions(+), 202 deletions(-)

diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
index d629431..574fd75 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLOC.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
index fad220c..eec0bfe 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLOC.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
index 84cf974..b338266 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLOC.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
index a0ed202..e6f4546 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLOC.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
index 9906eae..430f30b 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLZC.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
index 21222e3..8dcd771 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLZC.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
index fbab9c3..b329432 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLZC.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
index dc33366..6cf28c3 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NLZC.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
index f9033c7..cf2c088 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCNT.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
index 132b4d0..26acf0c 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCNT.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
index f469c09..ab76914 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCNT.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
index d73eff7..2e6f290 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCNT.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
index 9dca167..8207b00 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADD_A.B
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
index 06a7a50..2cc0041 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADD_A.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
index 5e59142..24295bb 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADD_A.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
index a12f9b9..03f8fd2 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADD_A.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
index 61b8e6e..0c8004b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_A.B
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
index 8350f8f..c21346f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_A.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
index 952f9f8..2831580 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_A.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
index d058c64..b502c3b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_A.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
index 63e27da..e4846c4 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_S.B
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
index 2719cee..c733dba 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_S.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
index 5274096..ec4edb8 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_S.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
index c3a6292..b7385d6 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_S.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
index df5d85f..341c420 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_U.B
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
index 10c665b..414be70 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_U.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
index 1e32f00..b6ca9c9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_U.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
index 938d2da..af30676 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDS_U.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
index 5dba386..61aee3b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDV.B
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
index 339878c..0e1b76f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDV.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
index 3add379..35b79cf 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDV.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
index 41f86ab..b3c8e32 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction ADDV.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
index a6975e7..c455db5 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction HADD_S.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
index 3b95551..2b0e9d2 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction HADD_S.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
index 7a940b2..2c09066 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction HADD_S.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
index d4cbe44..5662050 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction HADD_U.D
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
index ca25057..e23ac0a 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction HADD_U.H
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
index b302727..c71d82a 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -1,7 +1,7 @@
 /*
  *  Test program for MSA instruction HADD_U.W
  *
- *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
  *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  *
  *  This program is free software: you can redistribute it and/or modify
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
index b47b42e..1c38460 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CEQ.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
index e169bdc..95c7c86 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CEQ.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
index 9f03cb0..c54ed95 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CEQ.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
index a927d96..387b15d 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CEQ.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
index 1c1cb3b..4c266cd 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_S.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
index b51907c..d35ff2a 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_S.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
index 20ebbfb..1dd23de 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_S.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
index 4a78cce..54c9696 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_S.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
index 9990a5b..b8cc844 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_U.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
index cde86d8..e10e35f 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_U.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
index 70e4b48..af151f4 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_U.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
index f38feac..3ff612e 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLE_U.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
index b81b569..32e6348 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_S.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
index 393457a..39796cb 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_S.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
index 56860d7..ab9f6bc 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_S.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
index 346b293..f7d0db4 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_S.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
index be79646..fc7a497 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_U.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
index afbe490..5072d09 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_U.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
index 126597a..face857 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_U.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
index b405929..bddda8a 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction CLT_U.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
index b7a9a61..c9e3bd5 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_A.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
index dfffaf5..efe4569 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_A.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
index e0c1bd4..e8cee19 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_A.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
index 40c30c5..6f1eb68 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_A.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
index ab50eee..c26ef59 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_S.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
index 2957db4..b5407b0 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_S.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
index e101764..8c3d58c 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_S.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
index 119f03f..aa22faf 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_S.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
index d18b6bf..5e648dc 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_U.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
index 1396e74..17067d3 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_U.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
index c7dff10..8bf11a0 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_U.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
index 910dbfc..6eecc46 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MAX_U.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
index c632fe9..48026a2 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_A.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
index 5f9a9d4..5f65fb4 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_A.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
index dc73927..a2eb7fa 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_A.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
index 67b33f3..ca1acfb 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_A.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
index 76bb133..ce56619 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_S.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
index 8ef57a9..d775889 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_S.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
index e206040..5a984d3 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_S.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
index 7532bce..9e6ee5a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_S.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
index 1f61145..57b702d 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_U.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
index 4626c62..f2f98ac 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_U.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
index 5eeb8d0..b89ba3b 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_U.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
index e70964a..20992b3 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction MIN_U.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
index 5cf8627..5690c5c 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVEV.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
index d3600e9..a8b1a0a 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVEV.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
index 9a80fac..5bd7189 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVEV.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
index 8f62d47..ecb3ded 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVEV.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
index f7e6dc0..acf0ebf 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVL.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
index 0f4c048..ef31f0d 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVL.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
index 6c1c6d9..dc4066b 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVL.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
index d22d965..68e5562 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVL.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
index c55f3a4..8923caf 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVOD.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
index d03e7b4..1580080 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVOD.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
index f64d8b5..32c2a4e 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVOD.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
index 4ae75f8..7f65239 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVOD.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
index f2cc7bf..ddf2eef 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVR.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
index f5ff947..898b4e3 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVR.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
index 5a2986d..3295ed8 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVR.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
index fa0d6ea..2c1ebc7 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction ILVR.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
index 51b256f..42479ef 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction AND.V
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
index 90ca198..a956e03 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction NOR.V
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
index 4ad5366..46ac112 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction OR.V
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
index 54effed..dd3668c 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction XOR.V
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index d98dd22..ee1aa5d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKEV.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index 543fb6a..5df658a 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKEV.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index 64a18c0..90a5123 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKEV.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index a0acacd..364b835 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKEV.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index 7bf86fc..e637237 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKOD.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index 3c4d55b..d0b17f4 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKOD.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index 5c3c529..034c9e8 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKOD.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index 9275890..2ff1c36 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction PCKOD.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index fcf857a..1f4853a 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction VSHF.B
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index 700c159..0c42d27 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction VSHF.D
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index 3d6c1dc..f3f0e93 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction VSHF.H
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index 6030762..c5f2026 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -1,8 +1,8 @@
 /*
  *  Test program for MSA instruction VSHF.W
  *
- *  Copyright (C) 2018  Wave Computing, Inc.
- *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
-- 
2.7.4
