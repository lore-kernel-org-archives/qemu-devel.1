Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CFC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F319A20692
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F319A20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mAO-0005IK-Ut
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8m8q-0004Iv-I1
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8m8o-0006vY-Kk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:01:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:36812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8m8o-0006vJ-Ea
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:01:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8m8m-0002mh-Hp
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 14:01:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 015FA2E8085
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 14:01:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2019 13:49:34 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: ppc64 testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc ajbennee rth
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156691209320.18814.746226319480624520.malonedeb@soybean.canonical.com>
Message-Id: <20190913134935.29696-1-alex.bennee@linaro.org>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 72da8b54eb9d611225977e353d0044ad0079d5f5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1841592] [PATCH] tests/tcg: add float_madds test
 to multiarch
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1841592 <1841592@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190913134934.RFEHZssXZdNUU2Sf30gZFHA_jvr2V24vHBTVjCjv2n4@z>

This is a generic floating point multiply and accumulate test for
single precision floating point values. I've split of the common float
functions into a helper library so additional tests can use the same
common code.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/Makefile.target |   7 +-
 tests/tcg/multiarch/float_helpers.c | 208 ++++++++++++++++++++++++++++
 tests/tcg/multiarch/float_helpers.h |  26 ++++
 tests/tcg/multiarch/float_madds.c   |  78 +++++++++++
 4 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/float_helpers.c
 create mode 100644 tests/tcg/multiarch/float_helpers.h
 create mode 100644 tests/tcg/multiarch/float_madds.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Make=
file.target
index 657a04f802d..0446b75c456 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -10,12 +10,17 @@ MULTIARCH_SRC=3D$(SRC_PATH)/tests/tcg/multiarch
 # Set search path for all sources
 VPATH 		+=3D $(MULTIARCH_SRC)
 MULTIARCH_SRCS   =3D$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
-MULTIARCH_TESTS  =3D$(MULTIARCH_SRCS:.c=3D)
+MULTIARCH_TESTS  =3D$(filter-out float_helpers, $(MULTIARCH_SRCS:.c=3D))
 =

 #
 # The following are any additional rules needed to build things
 #
 =

+
+float_madds: LDFLAGS+=3D-lm
+float_madds: float_madds.c float_helpers.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -O2 $< $(MULTIARCH_SRC)/float_helpers.c -=
o $@ $(LDFLAGS)
+
 testthread: LDFLAGS+=3D-lpthread
 =

 # We define the runner for test-mmap after the individual
diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/floa=
t_helpers.c
new file mode 100644
index 00000000000..481d8d33317
--- /dev/null
+++ b/tests/tcg/multiarch/float_helpers.c
@@ -0,0 +1,208 @@
+/*
+ * Common Float Helpers
+ *
+ * This contains a series of useful utility routines and a set of
+ * floating point constants useful for exercising the edge cases in
+ * floating point tests.
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+/* we want additional float type definitions */
+#define __STDC_WANT_IEC_60559_BFP_EXT__
+#define __STDC_WANT_IEC_60559_TYPES_EXT__
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <inttypes.h>
+#include <math.h>
+#include <float.h>
+#include <fenv.h>
+
+#include "float_helpers.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+/*
+ * Half Precision Numbers
+ *
+ * Not yet well standardised so we return a plain uint16_t for now.
+ */
+
+/* no handy defines for these numbers */
+static uint16_t f16_numbers[] =3D {
+    0xffff, /* -NaN / AHP -Max */
+    0xfcff, /* -NaN / AHP */
+    0xfc01, /* -NaN / AHP */
+    0xfc00, /* -Inf */
+    0xfbff, /* -Max */
+    0xc000, /* -2 */
+    0xbc00, /* -1 */
+    0x8001, /* -MIN subnormal */
+    0x8000, /* -0 */
+    0x0000, /* +0 */
+    0x0001, /* MIN subnormal */
+    0x3c00, /* 1 */
+    0x7bff, /* Max */
+    0x7c00, /* Inf */
+    0x7c01, /* NaN / AHP */
+    0x7cff, /* NaN / AHP */
+    0x7fff, /* NaN / AHP +Max*/
+};
+
+const int num_f16 =3D ARRAY_SIZE(f16_numbers);
+
+uint16_t get_f16(int i) {
+    return f16_numbers[i % num_f16];
+}
+
+/* only display as hex */
+char *fmt_16(uint16_t num) {
+    char *fmt;
+    asprintf(&fmt, "f16 %#04x", num);
+    return fmt;
+}
+
+/*
+ * Single Precision Numbers
+ */
+
+#ifndef SNANF
+/* Signaling NaN macros, if supported.  */
+# if __GNUC_PREREQ(3, 3)
+#  define SNANF (__builtin_nansf (""))
+#  define SNAN (__builtin_nans (""))
+#  define SNANL (__builtin_nansl (""))
+# endif
+#endif
+
+static float f32_numbers[] =3D {
+    -SNANF,
+    -NAN,
+    -INFINITY,
+    -FLT_MAX,
+    -1.111E+31,
+    -1.111E+30,
+    -1.08700982e-12,
+    -1.78051176e-20,
+    -FLT_MIN,
+    0.0,
+    FLT_MIN,
+    2.98023224e-08,
+    5.96046E-8, /* min positive FP16 subnormal */
+    6.09756E-5, /* max subnormal FP16 */
+    6.10352E-5, /* min positive normal FP16 */
+    1.0,
+    1.0009765625, /* smallest float after 1.0 FP16 */
+    2.0,
+    M_E, M_PI,
+    65503.0,
+    65504.0, /* max FP16 */
+    65505.0,
+    131007.0,
+    131008.0, /* max AFP */
+    131009.0,
+    1.111E+30,
+    FLT_MAX,
+    INFINITY,
+    NAN,
+    SNANF
+};
+
+const int num_f32 =3D ARRAY_SIZE(f32_numbers);
+
+float get_f32(int i) {
+    return f32_numbers[i % num_f32];
+}
+
+char *fmt_f32(float num) {
+    uint32_t single_as_hex =3D *(uint32_t *) &num;
+    char *fmt;
+    asprintf(&fmt, "f32 %02.20e / %#010x", num, single_as_hex);
+    return fmt;
+}
+
+
+/* This allows us to initialise some doubles as pure hex */
+typedef union {
+    double d;
+    uint64_t h;
+} test_doubles;
+
+static test_doubles f64_numbers[] =3D {
+    {SNAN},
+    {-NAN},
+    {-INFINITY},
+    {-DBL_MAX},
+    {-FLT_MAX-1.0},
+    {-FLT_MAX},
+    {-1.111E+31},
+    {-1.111E+30}, /* half prec */
+    {-2.0}, {-1.0},
+    {-DBL_MIN},
+    {-FLT_MIN},
+    {0.0},
+    {FLT_MIN},
+    {2.98023224e-08},
+    {5.96046E-8}, /* min positive FP16 subnormal */
+    {6.09756E-5}, /* max subnormal FP16 */
+    {6.10352E-5}, /* min positive normal FP16 */
+    {1.0},
+    {1.0009765625}, /* smallest float after 1.0 FP16 */
+    {DBL_MIN},
+    {1.3789972848607228e-308},
+    {1.4914738736681624e-308},
+    {1.0}, {2.0},
+    {M_E}, {M_PI},
+    {65503.0},
+    {65504.0}, /* max FP16 */
+    {65505.0},
+    {131007.0},
+    {131008.0}, /* max AFP */
+    {131009.0},
+    {.h =3D 0x41dfffffffc00000 }, /* to int =3D 0x7fffffff */
+    {FLT_MAX},
+    {FLT_MAX + 1.0},
+    {DBL_MAX},
+    {INFINITY},
+    {NAN},
+    {.h =3D 0x7ff0000000000001}, /* SNAN */
+    {SNAN},
+};
+
+const int num_f64 =3D ARRAY_SIZE(f64_numbers);
+
+double get_f64(int i) {
+    return f64_numbers[i % num_f64].d;
+}
+
+char *fmt_f64(double num) {
+    uint64_t double_as_hex =3D *(uint64_t *) &num;
+    char *fmt;
+    asprintf(&fmt, "f64 %02.20e / %#020" PRIx64, num, double_as_hex);
+    return fmt;
+}
+
+/*
+ * Float flags
+ */
+char *fmt_flags(void)
+{
+    int flags =3D fetestexcept(FE_ALL_EXCEPT);
+    char *fmt;
+
+    if (flags) {
+        asprintf(&fmt, "%s%s%s%s%s",
+                 flags & FE_OVERFLOW ? "OVERFLOW " : "",
+                 flags & FE_UNDERFLOW ? "UNDERFLOW " : "",
+                 flags & FE_DIVBYZERO ? "DIV0 " : "",
+                 flags & FE_INEXACT ? "INEXACT " : "",
+                 flags & FE_INVALID ? "INVALID" : "");
+    } else {
+        asprintf(&fmt, "OK");
+    }
+
+    return fmt;
+}
diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/floa=
t_helpers.h
new file mode 100644
index 00000000000..4a1e2f3853a
--- /dev/null
+++ b/tests/tcg/multiarch/float_helpers.h
@@ -0,0 +1,26 @@
+/*
+ * Common Float Helpers
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <inttypes.h>
+
+/* Number of constants in each table */
+extern const int num_f16;
+extern const int num_f32;
+extern const int num_f64;
+
+/* Accessor helpers */
+uint16_t get_f16(int i); /* use _Float16 when we can */
+float    get_f32(int i);
+double   get_f64(int i);
+
+/* Return format strings, free after use */
+char * fmt_f16(uint16_t);
+char * fmt_f32(float);
+char * fmt_f64(double);
+/* exception flags */
+char * fmt_flags(void);
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_=
madds.c
new file mode 100644
index 00000000000..bc11eea9084
--- /dev/null
+++ b/tests/tcg/multiarch/float_madds.c
@@ -0,0 +1,78 @@
+/*
+ * Fused Multiply Add (Single)
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <math.h>
+#include <float.h>
+#include <fenv.h>
+
+#include "float_helpers.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef struct {
+    int flag;
+    char *desc;
+} float_mapping;
+
+float_mapping round_flags[] =3D {
+    { FE_TONEAREST, "to nearest" },
+    { FE_UPWARD, "upwards" },
+    { FE_DOWNWARD, "downwards" },
+    { FE_TOWARDZERO, "to zero" }
+};
+
+void print_result(float a, float b, float c, float r)
+{
+    char *a_fmt, *b_fmt, *c_fmt, *r_fmt, *flag_fmt;
+
+    a_fmt =3D fmt_f32(a);
+    b_fmt =3D fmt_f32(b);
+    c_fmt =3D fmt_f32(c);
+    r_fmt =3D fmt_f32(r);
+    flag_fmt =3D fmt_flags();
+
+    printf("%s * %s + %s =3D %s  (%s)\n",
+           a_fmt, b_fmt, c_fmt, r_fmt, flag_fmt);
+
+    free(a_fmt);
+    free(b_fmt);
+    free(c_fmt);
+    free(r_fmt);
+    free(flag_fmt);
+}
+
+
+int main(int argc, char *argv[argc])
+{
+    int i, j, k, l;
+    float a, b, c, r;
+
+    for (i =3D 0; i < ARRAY_SIZE(round_flags); ++i) {
+        fesetround(round_flags[i].flag);
+        printf("### Rounding %s\n", round_flags[i].desc);
+        for (j =3D 0; j < num_f32; j +=3D 3) {
+            for (k =3D 1; k < num_f32; k +=3D 3 ) {
+                for (l =3D 2; l < num_f32; l +=3D 3) {
+                    a =3D get_f32(j);
+                    b =3D get_f32(k);
+                    c =3D get_f32(l);
+                    feclearexcept(FE_ALL_EXCEPT);
+
+                    /* must be built with -O2 to generate fused op */
+                    r =3D a * b + c;
+
+                    print_result(a, b, c, r);
+                }
+            }
+        }
+    }
+
+    return 0;
+}
-- =

2.20.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841592

Title:
  ppc: softfloat float implementation issues

Status in QEMU:
  Incomplete

Bug description:
  Per bug #1841491, Richard Henderson (rth) said:
  > The float test failure is part of a larger problem for target/powerpc
  > in which all float routines are implemented incorrectly. They are all
  > implemented as double operations with rounding to float as a second
  > step. Which not only produces incorrect exceptions, as in this case,
  > but incorrect numerical results from the double rounding.
  >
  > This should probably be split to a separate bug...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1841592/+subscriptions

