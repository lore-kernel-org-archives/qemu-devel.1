Received: from eggs.gnu.org ([2001:4830:134:3::10]:53735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0o-0004mV-3Y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0M-0007ok-DJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:10 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0L-0007oI-LQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:42 -0400
Received: by mail-wm0-x22f.google.com with SMTP id g127so29682040wmd.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:07 +0100
Message-Id: <20170720150426.12393-5-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 04/23] softfloat3c: fixup include
 paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

So far we:
   - fixup include paths to use explicit softfloat3c
     #include "fpu/softfloat3c/softfloat-internals.h"
     #include "fpu/softfloat3c/softfloat.h"
     #include "fpu/softfloat3c/primitives.h"
     #include "fpu/softfloat3c/specialize.h"
   - include platform.h from absolute path
     - this means 8086/8086-SSE do #include "../platform.h"

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c | 4 ++--
 fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c   | 6 +++---
 fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c   | 6 +++---
 fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c  | 6 +++---
 fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c     | 6 +++---
 fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c    | 6 +++---
 fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c     | 4 ++--
 fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c     | 4 ++--
 fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c     | 4 ++--
 fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c   | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c  | 6 +++---
 fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c     | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c    | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c     | 6 +++---
 fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c     | 6 +++---
 fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c     | 6 +++---
 fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c  | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c    | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c   | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c    | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c    | 8 ++++----
 fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c    | 8 ++++----
 fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c   | 4 ++--
 fpu/softfloat3c/8086/extF80M_isSignalingNaN.c     | 4 ++--
 fpu/softfloat3c/8086/f128M_isSignalingNaN.c       | 6 +++---
 fpu/softfloat3c/8086/s_commonNaNToExtF80M.c       | 6 +++---
 fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c      | 6 +++---
 fpu/softfloat3c/8086/s_commonNaNToF128M.c         | 6 +++---
 fpu/softfloat3c/8086/s_commonNaNToF128UI.c        | 6 +++---
 fpu/softfloat3c/8086/s_commonNaNToF16UI.c         | 4 ++--
 fpu/softfloat3c/8086/s_commonNaNToF32UI.c         | 4 ++--
 fpu/softfloat3c/8086/s_commonNaNToF64UI.c         | 4 ++--
 fpu/softfloat3c/8086/s_extF80MToCommonNaN.c       | 8 ++++----
 fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c      | 6 +++---
 fpu/softfloat3c/8086/s_f128MToCommonNaN.c         | 8 ++++----
 fpu/softfloat3c/8086/s_f128UIToCommonNaN.c        | 8 ++++----
 fpu/softfloat3c/8086/s_f16UIToCommonNaN.c         | 6 +++---
 fpu/softfloat3c/8086/s_f32UIToCommonNaN.c         | 6 +++---
 fpu/softfloat3c/8086/s_f64UIToCommonNaN.c         | 6 +++---
 fpu/softfloat3c/8086/s_propagateNaNExtF80M.c      | 8 ++++----
 fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c     | 8 ++++----
 fpu/softfloat3c/8086/s_propagateNaNF128M.c        | 8 ++++----
 fpu/softfloat3c/8086/s_propagateNaNF128UI.c       | 8 ++++----
 fpu/softfloat3c/8086/s_propagateNaNF16UI.c        | 8 ++++----
 fpu/softfloat3c/8086/s_propagateNaNF32UI.c        | 8 ++++----
 fpu/softfloat3c/8086/s_propagateNaNF64UI.c        | 8 ++++----
 fpu/softfloat3c/8086/softfloat_raiseFlags.c       | 4 ++--
 fpu/softfloat3c/extF80M_add.c                     | 4 ++--
 fpu/softfloat3c/extF80M_div.c                     | 4 ++--
 fpu/softfloat3c/extF80M_eq.c                      | 4 ++--
 fpu/softfloat3c/extF80M_eq_signaling.c            | 4 ++--
 fpu/softfloat3c/extF80M_le.c                      | 4 ++--
 fpu/softfloat3c/extF80M_le_quiet.c                | 4 ++--
 fpu/softfloat3c/extF80M_lt.c                      | 4 ++--
 fpu/softfloat3c/extF80M_lt_quiet.c                | 4 ++--
 fpu/softfloat3c/extF80M_mul.c                     | 4 ++--
 fpu/softfloat3c/extF80M_rem.c                     | 4 ++--
 fpu/softfloat3c/extF80M_roundToInt.c              | 4 ++--
 fpu/softfloat3c/extF80M_sqrt.c                    | 4 ++--
 fpu/softfloat3c/extF80M_sub.c                     | 4 ++--
 fpu/softfloat3c/extF80M_to_f128M.c                | 4 ++--
 fpu/softfloat3c/extF80M_to_f16.c                  | 4 ++--
 fpu/softfloat3c/extF80M_to_f32.c                  | 4 ++--
 fpu/softfloat3c/extF80M_to_f64.c                  | 4 ++--
 fpu/softfloat3c/extF80M_to_i32.c                  | 4 ++--
 fpu/softfloat3c/extF80M_to_i32_r_minMag.c         | 4 ++--
 fpu/softfloat3c/extF80M_to_i64.c                  | 4 ++--
 fpu/softfloat3c/extF80M_to_i64_r_minMag.c         | 4 ++--
 fpu/softfloat3c/extF80M_to_ui32.c                 | 4 ++--
 fpu/softfloat3c/extF80M_to_ui32_r_minMag.c        | 4 ++--
 fpu/softfloat3c/extF80M_to_ui64.c                 | 4 ++--
 fpu/softfloat3c/extF80M_to_ui64_r_minMag.c        | 4 ++--
 fpu/softfloat3c/extF80_add.c                      | 4 ++--
 fpu/softfloat3c/extF80_div.c                      | 4 ++--
 fpu/softfloat3c/extF80_eq.c                       | 4 ++--
 fpu/softfloat3c/extF80_eq_signaling.c             | 4 ++--
 fpu/softfloat3c/extF80_isSignalingNaN.c           | 4 ++--
 fpu/softfloat3c/extF80_le.c                       | 4 ++--
 fpu/softfloat3c/extF80_le_quiet.c                 | 4 ++--
 fpu/softfloat3c/extF80_lt.c                       | 4 ++--
 fpu/softfloat3c/extF80_lt_quiet.c                 | 4 ++--
 fpu/softfloat3c/extF80_mul.c                      | 4 ++--
 fpu/softfloat3c/extF80_rem.c                      | 4 ++--
 fpu/softfloat3c/extF80_roundToInt.c               | 4 ++--
 fpu/softfloat3c/extF80_sqrt.c                     | 4 ++--
 fpu/softfloat3c/extF80_sub.c                      | 4 ++--
 fpu/softfloat3c/extF80_to_f128.c                  | 4 ++--
 fpu/softfloat3c/extF80_to_f16.c                   | 4 ++--
 fpu/softfloat3c/extF80_to_f32.c                   | 4 ++--
 fpu/softfloat3c/extF80_to_f64.c                   | 4 ++--
 fpu/softfloat3c/extF80_to_i32.c                   | 4 ++--
 fpu/softfloat3c/extF80_to_i32_r_minMag.c          | 4 ++--
 fpu/softfloat3c/extF80_to_i64.c                   | 4 ++--
 fpu/softfloat3c/extF80_to_i64_r_minMag.c          | 4 ++--
 fpu/softfloat3c/extF80_to_ui32.c                  | 4 ++--
 fpu/softfloat3c/extF80_to_ui32_r_minMag.c         | 4 ++--
 fpu/softfloat3c/extF80_to_ui64.c                  | 4 ++--
 fpu/softfloat3c/extF80_to_ui64_r_minMag.c         | 4 ++--
 fpu/softfloat3c/f128M_add.c                       | 4 ++--
 fpu/softfloat3c/f128M_div.c                       | 4 ++--
 fpu/softfloat3c/f128M_eq.c                        | 4 ++--
 fpu/softfloat3c/f128M_eq_signaling.c              | 4 ++--
 fpu/softfloat3c/f128M_le.c                        | 4 ++--
 fpu/softfloat3c/f128M_le_quiet.c                  | 4 ++--
 fpu/softfloat3c/f128M_lt.c                        | 4 ++--
 fpu/softfloat3c/f128M_lt_quiet.c                  | 4 ++--
 fpu/softfloat3c/f128M_mul.c                       | 4 ++--
 fpu/softfloat3c/f128M_mulAdd.c                    | 4 ++--
 fpu/softfloat3c/f128M_rem.c                       | 4 ++--
 fpu/softfloat3c/f128M_roundToInt.c                | 4 ++--
 fpu/softfloat3c/f128M_sqrt.c                      | 4 ++--
 fpu/softfloat3c/f128M_sub.c                       | 4 ++--
 fpu/softfloat3c/f128M_to_extF80M.c                | 4 ++--
 fpu/softfloat3c/f128M_to_f16.c                    | 4 ++--
 fpu/softfloat3c/f128M_to_f32.c                    | 4 ++--
 fpu/softfloat3c/f128M_to_f64.c                    | 4 ++--
 fpu/softfloat3c/f128M_to_i32.c                    | 4 ++--
 fpu/softfloat3c/f128M_to_i32_r_minMag.c           | 4 ++--
 fpu/softfloat3c/f128M_to_i64.c                    | 4 ++--
 fpu/softfloat3c/f128M_to_i64_r_minMag.c           | 4 ++--
 fpu/softfloat3c/f128M_to_ui32.c                   | 4 ++--
 fpu/softfloat3c/f128M_to_ui32_r_minMag.c          | 4 ++--
 fpu/softfloat3c/f128M_to_ui64.c                   | 4 ++--
 fpu/softfloat3c/f128M_to_ui64_r_minMag.c          | 4 ++--
 fpu/softfloat3c/f128_add.c                        | 4 ++--
 fpu/softfloat3c/f128_div.c                        | 4 ++--
 fpu/softfloat3c/f128_eq.c                         | 4 ++--
 fpu/softfloat3c/f128_eq_signaling.c               | 4 ++--
 fpu/softfloat3c/f128_isSignalingNaN.c             | 4 ++--
 fpu/softfloat3c/f128_le.c                         | 4 ++--
 fpu/softfloat3c/f128_le_quiet.c                   | 4 ++--
 fpu/softfloat3c/f128_lt.c                         | 4 ++--
 fpu/softfloat3c/f128_lt_quiet.c                   | 4 ++--
 fpu/softfloat3c/f128_mul.c                        | 4 ++--
 fpu/softfloat3c/f128_mulAdd.c                     | 4 ++--
 fpu/softfloat3c/f128_rem.c                        | 4 ++--
 fpu/softfloat3c/f128_roundToInt.c                 | 4 ++--
 fpu/softfloat3c/f128_sqrt.c                       | 4 ++--
 fpu/softfloat3c/f128_sub.c                        | 4 ++--
 fpu/softfloat3c/f128_to_extF80.c                  | 4 ++--
 fpu/softfloat3c/f128_to_f16.c                     | 4 ++--
 fpu/softfloat3c/f128_to_f32.c                     | 4 ++--
 fpu/softfloat3c/f128_to_f64.c                     | 4 ++--
 fpu/softfloat3c/f128_to_i32.c                     | 4 ++--
 fpu/softfloat3c/f128_to_i32_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f128_to_i64.c                     | 4 ++--
 fpu/softfloat3c/f128_to_i64_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f128_to_ui32.c                    | 4 ++--
 fpu/softfloat3c/f128_to_ui32_r_minMag.c           | 4 ++--
 fpu/softfloat3c/f128_to_ui64.c                    | 4 ++--
 fpu/softfloat3c/f128_to_ui64_r_minMag.c           | 4 ++--
 fpu/softfloat3c/f16_add.c                         | 4 ++--
 fpu/softfloat3c/f16_div.c                         | 8 ++++----
 fpu/softfloat3c/f16_eq.c                          | 4 ++--
 fpu/softfloat3c/f16_eq_signaling.c                | 4 ++--
 fpu/softfloat3c/f16_isSignalingNaN.c              | 4 ++--
 fpu/softfloat3c/f16_le.c                          | 4 ++--
 fpu/softfloat3c/f16_le_quiet.c                    | 4 ++--
 fpu/softfloat3c/f16_lt.c                          | 4 ++--
 fpu/softfloat3c/f16_lt_quiet.c                    | 4 ++--
 fpu/softfloat3c/f16_mul.c                         | 4 ++--
 fpu/softfloat3c/f16_mulAdd.c                      | 4 ++--
 fpu/softfloat3c/f16_rem.c                         | 4 ++--
 fpu/softfloat3c/f16_roundToInt.c                  | 4 ++--
 fpu/softfloat3c/f16_sqrt.c                        | 8 ++++----
 fpu/softfloat3c/f16_sub.c                         | 4 ++--
 fpu/softfloat3c/f16_to_extF80.c                   | 4 ++--
 fpu/softfloat3c/f16_to_extF80M.c                  | 4 ++--
 fpu/softfloat3c/f16_to_f128.c                     | 4 ++--
 fpu/softfloat3c/f16_to_f128M.c                    | 4 ++--
 fpu/softfloat3c/f16_to_f32.c                      | 4 ++--
 fpu/softfloat3c/f16_to_f64.c                      | 4 ++--
 fpu/softfloat3c/f16_to_i32.c                      | 4 ++--
 fpu/softfloat3c/f16_to_i32_r_minMag.c             | 4 ++--
 fpu/softfloat3c/f16_to_i64.c                      | 4 ++--
 fpu/softfloat3c/f16_to_i64_r_minMag.c             | 4 ++--
 fpu/softfloat3c/f16_to_ui32.c                     | 4 ++--
 fpu/softfloat3c/f16_to_ui32_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f16_to_ui64.c                     | 4 ++--
 fpu/softfloat3c/f16_to_ui64_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f32_add.c                         | 4 ++--
 fpu/softfloat3c/f32_div.c                         | 4 ++--
 fpu/softfloat3c/f32_eq.c                          | 4 ++--
 fpu/softfloat3c/f32_eq_signaling.c                | 4 ++--
 fpu/softfloat3c/f32_isSignalingNaN.c              | 4 ++--
 fpu/softfloat3c/f32_le.c                          | 4 ++--
 fpu/softfloat3c/f32_le_quiet.c                    | 4 ++--
 fpu/softfloat3c/f32_lt.c                          | 4 ++--
 fpu/softfloat3c/f32_lt_quiet.c                    | 4 ++--
 fpu/softfloat3c/f32_mul.c                         | 4 ++--
 fpu/softfloat3c/f32_mulAdd.c                      | 4 ++--
 fpu/softfloat3c/f32_rem.c                         | 4 ++--
 fpu/softfloat3c/f32_roundToInt.c                  | 4 ++--
 fpu/softfloat3c/f32_sqrt.c                        | 4 ++--
 fpu/softfloat3c/f32_sub.c                         | 4 ++--
 fpu/softfloat3c/f32_to_extF80.c                   | 4 ++--
 fpu/softfloat3c/f32_to_extF80M.c                  | 4 ++--
 fpu/softfloat3c/f32_to_f128.c                     | 4 ++--
 fpu/softfloat3c/f32_to_f128M.c                    | 4 ++--
 fpu/softfloat3c/f32_to_f16.c                      | 4 ++--
 fpu/softfloat3c/f32_to_f64.c                      | 4 ++--
 fpu/softfloat3c/f32_to_i32.c                      | 4 ++--
 fpu/softfloat3c/f32_to_i32_r_minMag.c             | 4 ++--
 fpu/softfloat3c/f32_to_i64.c                      | 4 ++--
 fpu/softfloat3c/f32_to_i64_r_minMag.c             | 4 ++--
 fpu/softfloat3c/f32_to_ui32.c                     | 4 ++--
 fpu/softfloat3c/f32_to_ui32_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f32_to_ui64.c                     | 4 ++--
 fpu/softfloat3c/f32_to_ui64_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f64_add.c                         | 4 ++--
 fpu/softfloat3c/f64_div.c                         | 4 ++--
 fpu/softfloat3c/f64_eq.c                          | 4 ++--
 fpu/softfloat3c/f64_eq_signaling.c                | 4 ++--
 fpu/softfloat3c/f64_isSignalingNaN.c              | 4 ++--
 fpu/softfloat3c/f64_le.c                          | 4 ++--
 fpu/softfloat3c/f64_le_quiet.c                    | 4 ++--
 fpu/softfloat3c/f64_lt.c                          | 4 ++--
 fpu/softfloat3c/f64_lt_quiet.c                    | 4 ++--
 fpu/softfloat3c/f64_mul.c                         | 4 ++--
 fpu/softfloat3c/f64_mulAdd.c                      | 4 ++--
 fpu/softfloat3c/f64_rem.c                         | 4 ++--
 fpu/softfloat3c/f64_roundToInt.c                  | 4 ++--
 fpu/softfloat3c/f64_sqrt.c                        | 4 ++--
 fpu/softfloat3c/f64_sub.c                         | 4 ++--
 fpu/softfloat3c/f64_to_extF80.c                   | 4 ++--
 fpu/softfloat3c/f64_to_extF80M.c                  | 4 ++--
 fpu/softfloat3c/f64_to_f128.c                     | 4 ++--
 fpu/softfloat3c/f64_to_f128M.c                    | 4 ++--
 fpu/softfloat3c/f64_to_f16.c                      | 4 ++--
 fpu/softfloat3c/f64_to_f32.c                      | 4 ++--
 fpu/softfloat3c/f64_to_i32.c                      | 4 ++--
 fpu/softfloat3c/f64_to_i32_r_minMag.c             | 4 ++--
 fpu/softfloat3c/f64_to_i64.c                      | 4 ++--
 fpu/softfloat3c/f64_to_i64_r_minMag.c             | 4 ++--
 fpu/softfloat3c/f64_to_ui32.c                     | 4 ++--
 fpu/softfloat3c/f64_to_ui32_r_minMag.c            | 4 ++--
 fpu/softfloat3c/f64_to_ui64.c                     | 4 ++--
 fpu/softfloat3c/f64_to_ui64_r_minMag.c            | 4 ++--
 fpu/softfloat3c/i32_to_extF80.c                   | 4 ++--
 fpu/softfloat3c/i32_to_extF80M.c                  | 4 ++--
 fpu/softfloat3c/i32_to_f128.c                     | 4 ++--
 fpu/softfloat3c/i32_to_f128M.c                    | 4 ++--
 fpu/softfloat3c/i32_to_f16.c                      | 4 ++--
 fpu/softfloat3c/i32_to_f32.c                      | 4 ++--
 fpu/softfloat3c/i32_to_f64.c                      | 4 ++--
 fpu/softfloat3c/i64_to_extF80.c                   | 4 ++--
 fpu/softfloat3c/i64_to_extF80M.c                  | 4 ++--
 fpu/softfloat3c/i64_to_f128.c                     | 4 ++--
 fpu/softfloat3c/i64_to_f128M.c                    | 4 ++--
 fpu/softfloat3c/i64_to_f16.c                      | 4 ++--
 fpu/softfloat3c/i64_to_f32.c                      | 4 ++--
 fpu/softfloat3c/i64_to_f64.c                      | 4 ++--
 fpu/softfloat3c/s_add128.c                        | 2 +-
 fpu/softfloat3c/s_add256M.c                       | 2 +-
 fpu/softfloat3c/s_addCarryM.c                     | 2 +-
 fpu/softfloat3c/s_addComplCarryM.c                | 2 +-
 fpu/softfloat3c/s_addExtF80M.c                    | 4 ++--
 fpu/softfloat3c/s_addF128M.c                      | 4 ++--
 fpu/softfloat3c/s_addM.c                          | 2 +-
 fpu/softfloat3c/s_addMagsExtF80.c                 | 4 ++--
 fpu/softfloat3c/s_addMagsF128.c                   | 2 +-
 fpu/softfloat3c/s_addMagsF16.c                    | 4 ++--
 fpu/softfloat3c/s_addMagsF32.c                    | 2 +-
 fpu/softfloat3c/s_addMagsF64.c                    | 2 +-
 fpu/softfloat3c/s_approxRecipSqrt_1Ks.c           | 2 +-
 fpu/softfloat3c/s_approxRecip_1Ks.c               | 2 +-
 fpu/softfloat3c/s_compare128M.c                   | 2 +-
 fpu/softfloat3c/s_compare96M.c                    | 2 +-
 fpu/softfloat3c/s_compareNonnormExtF80M.c         | 2 +-
 fpu/softfloat3c/s_countLeadingZeros16.c           | 2 +-
 fpu/softfloat3c/s_countLeadingZeros32.c           | 2 +-
 fpu/softfloat3c/s_countLeadingZeros64.c           | 2 +-
 fpu/softfloat3c/s_countLeadingZeros8.c            | 2 +-
 fpu/softfloat3c/s_invalidExtF80M.c                | 2 +-
 fpu/softfloat3c/s_invalidF128M.c                  | 4 ++--
 fpu/softfloat3c/s_isNaNF128M.c                    | 2 +-
 fpu/softfloat3c/s_mul128By32.c                    | 2 +-
 fpu/softfloat3c/s_mul128MTo256M.c                 | 2 +-
 fpu/softfloat3c/s_mul128To256M.c                  | 2 +-
 fpu/softfloat3c/s_mul64ByShifted32To128.c         | 2 +-
 fpu/softfloat3c/s_mul64To128.c                    | 2 +-
 fpu/softfloat3c/s_mul64To128M.c                   | 2 +-
 fpu/softfloat3c/s_mulAddF128.c                    | 4 ++--
 fpu/softfloat3c/s_mulAddF128M.c                   | 4 ++--
 fpu/softfloat3c/s_mulAddF16.c                     | 4 ++--
 fpu/softfloat3c/s_mulAddF32.c                     | 4 ++--
 fpu/softfloat3c/s_mulAddF64.c                     | 4 ++--
 fpu/softfloat3c/s_negXM.c                         | 2 +-
 fpu/softfloat3c/s_normExtF80SigM.c                | 2 +-
 fpu/softfloat3c/s_normRoundPackMToExtF80M.c       | 2 +-
 fpu/softfloat3c/s_normRoundPackMToF128M.c         | 2 +-
 fpu/softfloat3c/s_normRoundPackToExtF80.c         | 2 +-
 fpu/softfloat3c/s_normRoundPackToF128.c           | 2 +-
 fpu/softfloat3c/s_normRoundPackToF16.c            | 2 +-
 fpu/softfloat3c/s_normRoundPackToF32.c            | 2 +-
 fpu/softfloat3c/s_normRoundPackToF64.c            | 2 +-
 fpu/softfloat3c/s_normSubnormalExtF80Sig.c        | 2 +-
 fpu/softfloat3c/s_normSubnormalF128Sig.c          | 2 +-
 fpu/softfloat3c/s_normSubnormalF128SigM.c         | 2 +-
 fpu/softfloat3c/s_normSubnormalF16Sig.c           | 2 +-
 fpu/softfloat3c/s_normSubnormalF32Sig.c           | 2 +-
 fpu/softfloat3c/s_normSubnormalF64Sig.c           | 2 +-
 fpu/softfloat3c/s_remStepMBy32.c                  | 2 +-
 fpu/softfloat3c/s_roundMToI64.c                   | 4 ++--
 fpu/softfloat3c/s_roundMToUI64.c                  | 4 ++--
 fpu/softfloat3c/s_roundPackMToExtF80M.c           | 4 ++--
 fpu/softfloat3c/s_roundPackMToF128M.c             | 4 ++--
 fpu/softfloat3c/s_roundPackToExtF80.c             | 4 ++--
 fpu/softfloat3c/s_roundPackToF128.c               | 4 ++--
 fpu/softfloat3c/s_roundPackToF16.c                | 4 ++--
 fpu/softfloat3c/s_roundPackToF32.c                | 4 ++--
 fpu/softfloat3c/s_roundPackToF64.c                | 4 ++--
 fpu/softfloat3c/s_roundToI32.c                    | 4 ++--
 fpu/softfloat3c/s_roundToI64.c                    | 4 ++--
 fpu/softfloat3c/s_roundToUI32.c                   | 4 ++--
 fpu/softfloat3c/s_roundToUI64.c                   | 4 ++--
 fpu/softfloat3c/s_shiftLeftM.c                    | 2 +-
 fpu/softfloat3c/s_shiftNormSigF128M.c             | 2 +-
 fpu/softfloat3c/s_shiftRightJam128.c              | 2 +-
 fpu/softfloat3c/s_shiftRightJam128Extra.c         | 2 +-
 fpu/softfloat3c/s_shiftRightJam256M.c             | 2 +-
 fpu/softfloat3c/s_shiftRightJam64Extra.c          | 2 +-
 fpu/softfloat3c/s_shiftRightJamM.c                | 2 +-
 fpu/softfloat3c/s_shiftRightM.c                   | 2 +-
 fpu/softfloat3c/s_shortShiftLeft128.c             | 2 +-
 fpu/softfloat3c/s_shortShiftLeft64To96M.c         | 2 +-
 fpu/softfloat3c/s_shortShiftLeftM.c               | 2 +-
 fpu/softfloat3c/s_shortShiftRight128.c            | 2 +-
 fpu/softfloat3c/s_shortShiftRightExtendM.c        | 2 +-
 fpu/softfloat3c/s_shortShiftRightJam128.c         | 2 +-
 fpu/softfloat3c/s_shortShiftRightJam128Extra.c    | 2 +-
 fpu/softfloat3c/s_shortShiftRightJam64Extra.c     | 2 +-
 fpu/softfloat3c/s_shortShiftRightJamM.c           | 2 +-
 fpu/softfloat3c/s_shortShiftRightM.c              | 2 +-
 fpu/softfloat3c/s_sub128.c                        | 2 +-
 fpu/softfloat3c/s_sub1XM.c                        | 2 +-
 fpu/softfloat3c/s_sub256M.c                       | 2 +-
 fpu/softfloat3c/s_subM.c                          | 2 +-
 fpu/softfloat3c/s_subMagsExtF80.c                 | 4 ++--
 fpu/softfloat3c/s_subMagsF128.c                   | 4 ++--
 fpu/softfloat3c/s_subMagsF16.c                    | 4 ++--
 fpu/softfloat3c/s_subMagsF32.c                    | 4 ++--
 fpu/softfloat3c/s_subMagsF64.c                    | 4 ++--
 fpu/softfloat3c/s_tryPropagateNaNExtF80M.c        | 2 +-
 fpu/softfloat3c/s_tryPropagateNaNF128M.c          | 2 +-
 fpu/softfloat3c/softfloat_state.c                 | 4 ++--
 fpu/softfloat3c/ui32_to_extF80.c                  | 4 ++--
 fpu/softfloat3c/ui32_to_extF80M.c                 | 4 ++--
 fpu/softfloat3c/ui32_to_f128.c                    | 4 ++--
 fpu/softfloat3c/ui32_to_f128M.c                   | 4 ++--
 fpu/softfloat3c/ui32_to_f16.c                     | 4 ++--
 fpu/softfloat3c/ui32_to_f32.c                     | 4 ++--
 fpu/softfloat3c/ui32_to_f64.c                     | 4 ++--
 fpu/softfloat3c/ui64_to_extF80.c                  | 4 ++--
 fpu/softfloat3c/ui64_to_extF80M.c                 | 4 ++--
 fpu/softfloat3c/ui64_to_f128.c                    | 4 ++--
 fpu/softfloat3c/ui64_to_f128M.c                   | 4 ++--
 fpu/softfloat3c/ui64_to_f16.c                     | 4 ++--
 fpu/softfloat3c/ui64_to_f32.c                     | 4 ++--
 fpu/softfloat3c/ui64_to_f64.c                     | 4 ++--
 361 files changed, 719 insertions(+), 719 deletions(-)

diff --git a/fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c b/fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c
index fe27646938..0775b45b56 100644
--- a/fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c
+++ b/fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c b/fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c
index 9ea95bfcb1..0b6a3fb331 100644
--- a/fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c
+++ b/fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c
index dfa02437b4..9f6a678c31 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into an 80-bit extended
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c
index 4c8523d081..7c43d7b121 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into an 80-bit extended
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c
index 10b9b55047..746e6d77eb 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 128-bit floating-point
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c
index 8e2277a618..7059b017b2 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "../specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 128-bit floating-point
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c
index dd31223817..e112d7c08f 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c
@@ -35,8 +35,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 16-bit floating-point
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c
index 050f420ce9..cbd3d06b24 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c
@@ -35,8 +35,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "../specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 32-bit floating-point
diff --git a/fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c b/fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c
index f918861321..8413908b95 100644
--- a/fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c
@@ -35,8 +35,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "../specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 64-bit floating-point
diff --git a/fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c
index 9f1ae3d631..934b4bcc97 100644
--- a/fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c
@@ -35,10 +35,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the 80-bit extended floating-point value pointed to by `aSPtr' is
diff --git a/fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c
index 6cb0aad8d8..7db057e62f 100644
--- a/fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the unsigned integer formed from concatenating `uiA64' and `uiA0'
diff --git a/fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c
index 9992fbe04f..74f94a14f4 100644
--- a/fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c
@@ -35,10 +35,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the 128-bit floating-point value pointed to by `aWPtr' is a NaN,
diff --git a/fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c
index cde4482975..2fec597a5e 100644
--- a/fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c
@@ -35,10 +35,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the unsigned integer formed from concatenating `uiA64' and `uiA0'
diff --git a/fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c
index 7486582634..e17cdc8243 100644
--- a/fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "../specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming `uiA' has the bit pattern of a 16-bit floating-point NaN, converts
diff --git a/fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c
index 8c42690da7..1c3f23ad4a 100644
--- a/fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming `uiA' has the bit pattern of a 32-bit floating-point NaN, converts
diff --git a/fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c b/fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c
index 488e66ff01..53dbe16668 100644
--- a/fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming `uiA' has the bit pattern of a 64-bit floating-point NaN, converts
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c
index 1647bb8f1a..35b7daeb62 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming at least one of the two 80-bit extended floating-point values
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c
index 66d1103cc2..cd4263ed7d 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting the unsigned integer formed from concatenating `uiA64' and
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c
index b842412efd..992d7d68e0 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming at least one of the two 128-bit floating-point values pointed to by
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c
index de399b48f5..29b326098a 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting the unsigned integer formed from concatenating `uiA64' and
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c
index a5172fe433..6f1c9d8f31 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting `uiA' and `uiB' as the bit patterns of two 16-bit floating-
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c
index 4e06231403..7832a13a6d 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting `uiA' and `uiB' as the bit patterns of two 32-bit floating-
diff --git a/fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c b/fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c
index 1f095d9a21..acbf381e3b 100644
--- a/fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c
+++ b/fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting `uiA' and `uiB' as the bit patterns of two 64-bit floating-
diff --git a/fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c b/fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c
index a4b3c131b4..489e2d1dc8 100644
--- a/fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c
+++ b/fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c
@@ -34,8 +34,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 =============================================================================*/
 
-#include "platform.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Raises the exceptions specified by `flags'.  Floating-point traps can be
diff --git a/fpu/softfloat3c/8086/extF80M_isSignalingNaN.c b/fpu/softfloat3c/8086/extF80M_isSignalingNaN.c
index fe27646938..0775b45b56 100644
--- a/fpu/softfloat3c/8086/extF80M_isSignalingNaN.c
+++ b/fpu/softfloat3c/8086/extF80M_isSignalingNaN.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat3c/8086/f128M_isSignalingNaN.c b/fpu/softfloat3c/8086/f128M_isSignalingNaN.c
index 9ea95bfcb1..0b6a3fb331 100644
--- a/fpu/softfloat3c/8086/f128M_isSignalingNaN.c
+++ b/fpu/softfloat3c/8086/f128M_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat3c/8086/s_commonNaNToExtF80M.c b/fpu/softfloat3c/8086/s_commonNaNToExtF80M.c
index dfa02437b4..9f6a678c31 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToExtF80M.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToExtF80M.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into an 80-bit extended
diff --git a/fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c b/fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c
index 4c8523d081..7c43d7b121 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into an 80-bit extended
diff --git a/fpu/softfloat3c/8086/s_commonNaNToF128M.c b/fpu/softfloat3c/8086/s_commonNaNToF128M.c
index 10b9b55047..746e6d77eb 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToF128M.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToF128M.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 128-bit floating-point
diff --git a/fpu/softfloat3c/8086/s_commonNaNToF128UI.c b/fpu/softfloat3c/8086/s_commonNaNToF128UI.c
index 8e2277a618..d98d446a4f 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToF128UI.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToF128UI.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 128-bit floating-point
diff --git a/fpu/softfloat3c/8086/s_commonNaNToF16UI.c b/fpu/softfloat3c/8086/s_commonNaNToF16UI.c
index dd31223817..e112d7c08f 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToF16UI.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToF16UI.c
@@ -35,8 +35,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 16-bit floating-point
diff --git a/fpu/softfloat3c/8086/s_commonNaNToF32UI.c b/fpu/softfloat3c/8086/s_commonNaNToF32UI.c
index 050f420ce9..259ee78833 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToF32UI.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToF32UI.c
@@ -35,8 +35,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 32-bit floating-point
diff --git a/fpu/softfloat3c/8086/s_commonNaNToF64UI.c b/fpu/softfloat3c/8086/s_commonNaNToF64UI.c
index f918861321..e718171d9e 100644
--- a/fpu/softfloat3c/8086/s_commonNaNToF64UI.c
+++ b/fpu/softfloat3c/8086/s_commonNaNToF64UI.c
@@ -35,8 +35,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
 
 /*----------------------------------------------------------------------------
 | Converts the common NaN pointed to by `aPtr' into a 64-bit floating-point
diff --git a/fpu/softfloat3c/8086/s_extF80MToCommonNaN.c b/fpu/softfloat3c/8086/s_extF80MToCommonNaN.c
index 9f1ae3d631..934b4bcc97 100644
--- a/fpu/softfloat3c/8086/s_extF80MToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_extF80MToCommonNaN.c
@@ -35,10 +35,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the 80-bit extended floating-point value pointed to by `aSPtr' is
diff --git a/fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c b/fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c
index 6cb0aad8d8..7db057e62f 100644
--- a/fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the unsigned integer formed from concatenating `uiA64' and `uiA0'
diff --git a/fpu/softfloat3c/8086/s_f128MToCommonNaN.c b/fpu/softfloat3c/8086/s_f128MToCommonNaN.c
index 9992fbe04f..74f94a14f4 100644
--- a/fpu/softfloat3c/8086/s_f128MToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_f128MToCommonNaN.c
@@ -35,10 +35,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the 128-bit floating-point value pointed to by `aWPtr' is a NaN,
diff --git a/fpu/softfloat3c/8086/s_f128UIToCommonNaN.c b/fpu/softfloat3c/8086/s_f128UIToCommonNaN.c
index cde4482975..2fec597a5e 100644
--- a/fpu/softfloat3c/8086/s_f128UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_f128UIToCommonNaN.c
@@ -35,10 +35,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "primitives.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/primitives.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming the unsigned integer formed from concatenating `uiA64' and `uiA0'
diff --git a/fpu/softfloat3c/8086/s_f16UIToCommonNaN.c b/fpu/softfloat3c/8086/s_f16UIToCommonNaN.c
index 7486582634..b0ee1bafa5 100644
--- a/fpu/softfloat3c/8086/s_f16UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_f16UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming `uiA' has the bit pattern of a 16-bit floating-point NaN, converts
diff --git a/fpu/softfloat3c/8086/s_f32UIToCommonNaN.c b/fpu/softfloat3c/8086/s_f32UIToCommonNaN.c
index 8c42690da7..1c3f23ad4a 100644
--- a/fpu/softfloat3c/8086/s_f32UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_f32UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming `uiA' has the bit pattern of a 32-bit floating-point NaN, converts
diff --git a/fpu/softfloat3c/8086/s_f64UIToCommonNaN.c b/fpu/softfloat3c/8086/s_f64UIToCommonNaN.c
index 488e66ff01..53dbe16668 100644
--- a/fpu/softfloat3c/8086/s_f64UIToCommonNaN.c
+++ b/fpu/softfloat3c/8086/s_f64UIToCommonNaN.c
@@ -35,9 +35,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 =============================================================================*/
 
 #include <stdint.h>
-#include "platform.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming `uiA' has the bit pattern of a 64-bit floating-point NaN, converts
diff --git a/fpu/softfloat3c/8086/s_propagateNaNExtF80M.c b/fpu/softfloat3c/8086/s_propagateNaNExtF80M.c
index 1647bb8f1a..35b7daeb62 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNExtF80M.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNExtF80M.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming at least one of the two 80-bit extended floating-point values
diff --git a/fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c b/fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c
index 66d1103cc2..cd4263ed7d 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting the unsigned integer formed from concatenating `uiA64' and
diff --git a/fpu/softfloat3c/8086/s_propagateNaNF128M.c b/fpu/softfloat3c/8086/s_propagateNaNF128M.c
index 7461f2dd63..462aa619c6 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNF128M.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNF128M.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Assuming at least one of the two 128-bit floating-point values pointed to by
diff --git a/fpu/softfloat3c/8086/s_propagateNaNF128UI.c b/fpu/softfloat3c/8086/s_propagateNaNF128UI.c
index d8420df78e..b3fe99171e 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNF128UI.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNF128UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting the unsigned integer formed from concatenating `uiA64' and
diff --git a/fpu/softfloat3c/8086/s_propagateNaNF16UI.c b/fpu/softfloat3c/8086/s_propagateNaNF16UI.c
index 79bc88ac32..ba27332aba 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNF16UI.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNF16UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting `uiA' and `uiB' as the bit patterns of two 16-bit floating-
diff --git a/fpu/softfloat3c/8086/s_propagateNaNF32UI.c b/fpu/softfloat3c/8086/s_propagateNaNF32UI.c
index 191146305a..a096a98416 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNF32UI.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNF32UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting `uiA' and `uiB' as the bit patterns of two 32-bit floating-
diff --git a/fpu/softfloat3c/8086/s_propagateNaNF64UI.c b/fpu/softfloat3c/8086/s_propagateNaNF64UI.c
index 83a273092f..06cb9ee86c 100644
--- a/fpu/softfloat3c/8086/s_propagateNaNF64UI.c
+++ b/fpu/softfloat3c/8086/s_propagateNaNF64UI.c
@@ -36,10 +36,10 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include <stdint.h>
-#include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "specialize.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/specialize.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Interpreting `uiA' and `uiB' as the bit patterns of two 64-bit floating-
diff --git a/fpu/softfloat3c/8086/softfloat_raiseFlags.c b/fpu/softfloat3c/8086/softfloat_raiseFlags.c
index a4b3c131b4..489e2d1dc8 100644
--- a/fpu/softfloat3c/8086/softfloat_raiseFlags.c
+++ b/fpu/softfloat3c/8086/softfloat_raiseFlags.c
@@ -34,8 +34,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 =============================================================================*/
 
-#include "platform.h"
-#include "softfloat.h"
+#include "../platform.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 /*----------------------------------------------------------------------------
 | Raises the exceptions specified by `flags'.  Floating-point traps can be
diff --git a/fpu/softfloat3c/extF80M_add.c b/fpu/softfloat3c/extF80M_add.c
index 26da14b10e..b9b27ce643 100644
--- a/fpu/softfloat3c/extF80M_add.c
+++ b/fpu/softfloat3c/extF80M_add.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_div.c b/fpu/softfloat3c/extF80M_div.c
index 21702e3cf3..5d20d3ade6 100644
--- a/fpu/softfloat3c/extF80M_div.c
+++ b/fpu/softfloat3c/extF80M_div.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_eq.c b/fpu/softfloat3c/extF80M_eq.c
index b723d4a3a5..c6a734b0b1 100644
--- a/fpu/softfloat3c/extF80M_eq.c
+++ b/fpu/softfloat3c/extF80M_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_eq_signaling.c b/fpu/softfloat3c/extF80M_eq_signaling.c
index 33dbf1d5fe..8e1567c57e 100644
--- a/fpu/softfloat3c/extF80M_eq_signaling.c
+++ b/fpu/softfloat3c/extF80M_eq_signaling.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_le.c b/fpu/softfloat3c/extF80M_le.c
index d05e6c6209..1ad8ab0052 100644
--- a/fpu/softfloat3c/extF80M_le.c
+++ b/fpu/softfloat3c/extF80M_le.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_le_quiet.c b/fpu/softfloat3c/extF80M_le_quiet.c
index 9201f14e31..53d7268906 100644
--- a/fpu/softfloat3c/extF80M_le_quiet.c
+++ b/fpu/softfloat3c/extF80M_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_lt.c b/fpu/softfloat3c/extF80M_lt.c
index e8d46d88ef..6b4dd9ee72 100644
--- a/fpu/softfloat3c/extF80M_lt.c
+++ b/fpu/softfloat3c/extF80M_lt.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_lt_quiet.c b/fpu/softfloat3c/extF80M_lt_quiet.c
index 9172a00150..cf065e0d00 100644
--- a/fpu/softfloat3c/extF80M_lt_quiet.c
+++ b/fpu/softfloat3c/extF80M_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_mul.c b/fpu/softfloat3c/extF80M_mul.c
index 78d1ed76b7..cbb7794aa6 100644
--- a/fpu/softfloat3c/extF80M_mul.c
+++ b/fpu/softfloat3c/extF80M_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_rem.c b/fpu/softfloat3c/extF80M_rem.c
index 5f76dd3f88..a4ed2c7d58 100644
--- a/fpu/softfloat3c/extF80M_rem.c
+++ b/fpu/softfloat3c/extF80M_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_roundToInt.c b/fpu/softfloat3c/extF80M_roundToInt.c
index c11a4905ae..821f2c4a9a 100644
--- a/fpu/softfloat3c/extF80M_roundToInt.c
+++ b/fpu/softfloat3c/extF80M_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_sqrt.c b/fpu/softfloat3c/extF80M_sqrt.c
index f1257706f2..b52f1168bb 100644
--- a/fpu/softfloat3c/extF80M_sqrt.c
+++ b/fpu/softfloat3c/extF80M_sqrt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_sub.c b/fpu/softfloat3c/extF80M_sub.c
index 2275b82d49..aa4552e500 100644
--- a/fpu/softfloat3c/extF80M_sub.c
+++ b/fpu/softfloat3c/extF80M_sub.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_f128M.c b/fpu/softfloat3c/extF80M_to_f128M.c
index 7beff7c1d3..2a3b7049e6 100644
--- a/fpu/softfloat3c/extF80M_to_f128M.c
+++ b/fpu/softfloat3c/extF80M_to_f128M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_f16.c b/fpu/softfloat3c/extF80M_to_f16.c
index 442371ab78..3ec275a65c 100644
--- a/fpu/softfloat3c/extF80M_to_f16.c
+++ b/fpu/softfloat3c/extF80M_to_f16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_f32.c b/fpu/softfloat3c/extF80M_to_f32.c
index 2255371dfe..d284290f27 100644
--- a/fpu/softfloat3c/extF80M_to_f32.c
+++ b/fpu/softfloat3c/extF80M_to_f32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_f64.c b/fpu/softfloat3c/extF80M_to_f64.c
index 7b0d660f95..06ee1d76a4 100644
--- a/fpu/softfloat3c/extF80M_to_f64.c
+++ b/fpu/softfloat3c/extF80M_to_f64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_i32.c b/fpu/softfloat3c/extF80M_to_i32.c
index d984991fa7..e7b31e0890 100644
--- a/fpu/softfloat3c/extF80M_to_i32.c
+++ b/fpu/softfloat3c/extF80M_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_i32_r_minMag.c b/fpu/softfloat3c/extF80M_to_i32_r_minMag.c
index a516fe9e5e..3d0110a644 100644
--- a/fpu/softfloat3c/extF80M_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/extF80M_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_i64.c b/fpu/softfloat3c/extF80M_to_i64.c
index 12d2383315..63dc2e9daf 100644
--- a/fpu/softfloat3c/extF80M_to_i64.c
+++ b/fpu/softfloat3c/extF80M_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_i64_r_minMag.c b/fpu/softfloat3c/extF80M_to_i64_r_minMag.c
index 4352826101..1a12b24364 100644
--- a/fpu/softfloat3c/extF80M_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/extF80M_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_ui32.c b/fpu/softfloat3c/extF80M_to_ui32.c
index 9ae187d9a5..bb18082c59 100644
--- a/fpu/softfloat3c/extF80M_to_ui32.c
+++ b/fpu/softfloat3c/extF80M_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_ui32_r_minMag.c b/fpu/softfloat3c/extF80M_to_ui32_r_minMag.c
index d428888336..e2938c52c3 100644
--- a/fpu/softfloat3c/extF80M_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/extF80M_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_ui64.c b/fpu/softfloat3c/extF80M_to_ui64.c
index c564fb86b8..f431d066b8 100644
--- a/fpu/softfloat3c/extF80M_to_ui64.c
+++ b/fpu/softfloat3c/extF80M_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80M_to_ui64_r_minMag.c b/fpu/softfloat3c/extF80M_to_ui64_r_minMag.c
index e912fd2289..a9d2f47791 100644
--- a/fpu/softfloat3c/extF80M_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/extF80M_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/extF80_add.c b/fpu/softfloat3c/extF80_add.c
index c2dedd3380..53b2c0a855 100644
--- a/fpu/softfloat3c/extF80_add.c
+++ b/fpu/softfloat3c/extF80_add.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t extF80_add( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_div.c b/fpu/softfloat3c/extF80_div.c
index a18cad5ce8..2d13354257 100644
--- a/fpu/softfloat3c/extF80_div.c
+++ b/fpu/softfloat3c/extF80_div.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t extF80_div( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_eq.c b/fpu/softfloat3c/extF80_eq.c
index 1dfd04a7c2..ffa74fbd2a 100644
--- a/fpu/softfloat3c/extF80_eq.c
+++ b/fpu/softfloat3c/extF80_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_eq( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_eq_signaling.c b/fpu/softfloat3c/extF80_eq_signaling.c
index 003bc50633..d3323d3f63 100644
--- a/fpu/softfloat3c/extF80_eq_signaling.c
+++ b/fpu/softfloat3c/extF80_eq_signaling.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_eq_signaling( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_isSignalingNaN.c b/fpu/softfloat3c/extF80_isSignalingNaN.c
index a0c39239a4..26bf1043ac 100644
--- a/fpu/softfloat3c/extF80_isSignalingNaN.c
+++ b/fpu/softfloat3c/extF80_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_isSignalingNaN( extFloat80_t a )
 {
diff --git a/fpu/softfloat3c/extF80_le.c b/fpu/softfloat3c/extF80_le.c
index 611ec6c31f..4ccfba0792 100644
--- a/fpu/softfloat3c/extF80_le.c
+++ b/fpu/softfloat3c/extF80_le.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_le( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_le_quiet.c b/fpu/softfloat3c/extF80_le_quiet.c
index d1050ed514..1e3c1b19fe 100644
--- a/fpu/softfloat3c/extF80_le_quiet.c
+++ b/fpu/softfloat3c/extF80_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_le_quiet( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_lt.c b/fpu/softfloat3c/extF80_lt.c
index b51e308cd8..936508fec7 100644
--- a/fpu/softfloat3c/extF80_lt.c
+++ b/fpu/softfloat3c/extF80_lt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_lt( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_lt_quiet.c b/fpu/softfloat3c/extF80_lt_quiet.c
index 3c954eb11a..84a6f9b250 100644
--- a/fpu/softfloat3c/extF80_lt_quiet.c
+++ b/fpu/softfloat3c/extF80_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool extF80_lt_quiet( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_mul.c b/fpu/softfloat3c/extF80_mul.c
index 1acf3c5ef5..750931b462 100644
--- a/fpu/softfloat3c/extF80_mul.c
+++ b/fpu/softfloat3c/extF80_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t extF80_mul( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_rem.c b/fpu/softfloat3c/extF80_rem.c
index 720f1eb6f0..3169e7e580 100644
--- a/fpu/softfloat3c/extF80_rem.c
+++ b/fpu/softfloat3c/extF80_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t extF80_rem( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_roundToInt.c b/fpu/softfloat3c/extF80_roundToInt.c
index a5f0644726..ad334ed080 100644
--- a/fpu/softfloat3c/extF80_roundToInt.c
+++ b/fpu/softfloat3c/extF80_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t
  extF80_roundToInt( extFloat80_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/extF80_sqrt.c b/fpu/softfloat3c/extF80_sqrt.c
index 667b50a6f4..ecef6f0854 100644
--- a/fpu/softfloat3c/extF80_sqrt.c
+++ b/fpu/softfloat3c/extF80_sqrt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t extF80_sqrt( extFloat80_t a )
 {
diff --git a/fpu/softfloat3c/extF80_sub.c b/fpu/softfloat3c/extF80_sub.c
index 3ae8a2791c..c9963af7ee 100644
--- a/fpu/softfloat3c/extF80_sub.c
+++ b/fpu/softfloat3c/extF80_sub.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t extF80_sub( extFloat80_t a, extFloat80_t b )
 {
diff --git a/fpu/softfloat3c/extF80_to_f128.c b/fpu/softfloat3c/extF80_to_f128.c
index bd95042017..bb3a09bff7 100644
--- a/fpu/softfloat3c/extF80_to_f128.c
+++ b/fpu/softfloat3c/extF80_to_f128.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t extF80_to_f128( extFloat80_t a )
 {
diff --git a/fpu/softfloat3c/extF80_to_f16.c b/fpu/softfloat3c/extF80_to_f16.c
index 0275b5a776..3c17ee0bf2 100644
--- a/fpu/softfloat3c/extF80_to_f16.c
+++ b/fpu/softfloat3c/extF80_to_f16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t extF80_to_f16( extFloat80_t a )
 {
diff --git a/fpu/softfloat3c/extF80_to_f32.c b/fpu/softfloat3c/extF80_to_f32.c
index af8bb94130..28239ebc62 100644
--- a/fpu/softfloat3c/extF80_to_f32.c
+++ b/fpu/softfloat3c/extF80_to_f32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t extF80_to_f32( extFloat80_t a )
 {
diff --git a/fpu/softfloat3c/extF80_to_f64.c b/fpu/softfloat3c/extF80_to_f64.c
index 772480cbe0..254508536c 100644
--- a/fpu/softfloat3c/extF80_to_f64.c
+++ b/fpu/softfloat3c/extF80_to_f64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t extF80_to_f64( extFloat80_t a )
 {
diff --git a/fpu/softfloat3c/extF80_to_i32.c b/fpu/softfloat3c/extF80_to_i32.c
index 2e6b78d071..4a5aa3b8ec 100644
--- a/fpu/softfloat3c/extF80_to_i32.c
+++ b/fpu/softfloat3c/extF80_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t
  extF80_to_i32( extFloat80_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/extF80_to_i32_r_minMag.c b/fpu/softfloat3c/extF80_to_i32_r_minMag.c
index d681abb555..86947e6e53 100644
--- a/fpu/softfloat3c/extF80_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/extF80_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t extF80_to_i32_r_minMag( extFloat80_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/extF80_to_i64.c b/fpu/softfloat3c/extF80_to_i64.c
index 6b213eace4..3d2ff73c6e 100644
--- a/fpu/softfloat3c/extF80_to_i64.c
+++ b/fpu/softfloat3c/extF80_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t
  extF80_to_i64( extFloat80_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/extF80_to_i64_r_minMag.c b/fpu/softfloat3c/extF80_to_i64_r_minMag.c
index adcecb5b8f..5ebac1feb4 100644
--- a/fpu/softfloat3c/extF80_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/extF80_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t extF80_to_i64_r_minMag( extFloat80_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/extF80_to_ui32.c b/fpu/softfloat3c/extF80_to_ui32.c
index c7ca85a76e..da1b5ba940 100644
--- a/fpu/softfloat3c/extF80_to_ui32.c
+++ b/fpu/softfloat3c/extF80_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t
  extF80_to_ui32( extFloat80_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/extF80_to_ui32_r_minMag.c b/fpu/softfloat3c/extF80_to_ui32_r_minMag.c
index 636d5b7852..95932e8e08 100644
--- a/fpu/softfloat3c/extF80_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/extF80_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t extF80_to_ui32_r_minMag( extFloat80_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/extF80_to_ui64.c b/fpu/softfloat3c/extF80_to_ui64.c
index abcf5931d2..030b2b1b9d 100644
--- a/fpu/softfloat3c/extF80_to_ui64.c
+++ b/fpu/softfloat3c/extF80_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t
  extF80_to_ui64( extFloat80_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/extF80_to_ui64_r_minMag.c b/fpu/softfloat3c/extF80_to_ui64_r_minMag.c
index ed392a314c..8b7e180481 100644
--- a/fpu/softfloat3c/extF80_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/extF80_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t extF80_to_ui64_r_minMag( extFloat80_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f128M_add.c b/fpu/softfloat3c/f128M_add.c
index 81f6c1f8d5..ed697e5c4c 100644
--- a/fpu/softfloat3c/f128M_add.c
+++ b/fpu/softfloat3c/f128M_add.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_div.c b/fpu/softfloat3c/f128M_div.c
index c708590ea8..5612c5e8d1 100644
--- a/fpu/softfloat3c/f128M_div.c
+++ b/fpu/softfloat3c/f128M_div.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_eq.c b/fpu/softfloat3c/f128M_eq.c
index 336af9d63f..86ea1a3303 100644
--- a/fpu/softfloat3c/f128M_eq.c
+++ b/fpu/softfloat3c/f128M_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_eq_signaling.c b/fpu/softfloat3c/f128M_eq_signaling.c
index 8948851945..8a2bdffbb8 100644
--- a/fpu/softfloat3c/f128M_eq_signaling.c
+++ b/fpu/softfloat3c/f128M_eq_signaling.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_le.c b/fpu/softfloat3c/f128M_le.c
index 73d71a9cd1..86271a10ff 100644
--- a/fpu/softfloat3c/f128M_le.c
+++ b/fpu/softfloat3c/f128M_le.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_le_quiet.c b/fpu/softfloat3c/f128M_le_quiet.c
index c6e8055c10..62615ffe04 100644
--- a/fpu/softfloat3c/f128M_le_quiet.c
+++ b/fpu/softfloat3c/f128M_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_lt.c b/fpu/softfloat3c/f128M_lt.c
index 7d86b51323..16c635606f 100644
--- a/fpu/softfloat3c/f128M_lt.c
+++ b/fpu/softfloat3c/f128M_lt.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_lt_quiet.c b/fpu/softfloat3c/f128M_lt_quiet.c
index b860d03f3d..ecaef926b8 100644
--- a/fpu/softfloat3c/f128M_lt_quiet.c
+++ b/fpu/softfloat3c/f128M_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_mul.c b/fpu/softfloat3c/f128M_mul.c
index 423e6175cf..42e5786b50 100644
--- a/fpu/softfloat3c/f128M_mul.c
+++ b/fpu/softfloat3c/f128M_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_mulAdd.c b/fpu/softfloat3c/f128M_mulAdd.c
index 5f405e4490..78e0f512b3 100644
--- a/fpu/softfloat3c/f128M_mulAdd.c
+++ b/fpu/softfloat3c/f128M_mulAdd.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_rem.c b/fpu/softfloat3c/f128M_rem.c
index 09dddaa706..bd02a5aecd 100644
--- a/fpu/softfloat3c/f128M_rem.c
+++ b/fpu/softfloat3c/f128M_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_roundToInt.c b/fpu/softfloat3c/f128M_roundToInt.c
index 0ad1c3e5be..64163c681c 100644
--- a/fpu/softfloat3c/f128M_roundToInt.c
+++ b/fpu/softfloat3c/f128M_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_sqrt.c b/fpu/softfloat3c/f128M_sqrt.c
index 81879ef8ec..c1dd585910 100644
--- a/fpu/softfloat3c/f128M_sqrt.c
+++ b/fpu/softfloat3c/f128M_sqrt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_sub.c b/fpu/softfloat3c/f128M_sub.c
index fe9fed0b96..d73a18f0b1 100644
--- a/fpu/softfloat3c/f128M_sub.c
+++ b/fpu/softfloat3c/f128M_sub.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_extF80M.c b/fpu/softfloat3c/f128M_to_extF80M.c
index 14f5a95aed..e831af8b3c 100644
--- a/fpu/softfloat3c/f128M_to_extF80M.c
+++ b/fpu/softfloat3c/f128M_to_extF80M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_f16.c b/fpu/softfloat3c/f128M_to_f16.c
index 112c312c09..d19b5e436d 100644
--- a/fpu/softfloat3c/f128M_to_f16.c
+++ b/fpu/softfloat3c/f128M_to_f16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_f32.c b/fpu/softfloat3c/f128M_to_f32.c
index 62293a9e88..3b2938e6e0 100644
--- a/fpu/softfloat3c/f128M_to_f32.c
+++ b/fpu/softfloat3c/f128M_to_f32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_f64.c b/fpu/softfloat3c/f128M_to_f64.c
index 86634c4e6e..914c3adf8b 100644
--- a/fpu/softfloat3c/f128M_to_f64.c
+++ b/fpu/softfloat3c/f128M_to_f64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_i32.c b/fpu/softfloat3c/f128M_to_i32.c
index 4a01c0339d..2c4413e48a 100644
--- a/fpu/softfloat3c/f128M_to_i32.c
+++ b/fpu/softfloat3c/f128M_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_i32_r_minMag.c b/fpu/softfloat3c/f128M_to_i32_r_minMag.c
index 61d784e9fd..061dae0503 100644
--- a/fpu/softfloat3c/f128M_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/f128M_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_i64.c b/fpu/softfloat3c/f128M_to_i64.c
index 07f1b42e8d..6651a355d6 100644
--- a/fpu/softfloat3c/f128M_to_i64.c
+++ b/fpu/softfloat3c/f128M_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_i64_r_minMag.c b/fpu/softfloat3c/f128M_to_i64_r_minMag.c
index 8b1acb59d7..a2c14d4958 100644
--- a/fpu/softfloat3c/f128M_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/f128M_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_ui32.c b/fpu/softfloat3c/f128M_to_ui32.c
index 6e3953c695..9909f2a5fe 100644
--- a/fpu/softfloat3c/f128M_to_ui32.c
+++ b/fpu/softfloat3c/f128M_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_ui32_r_minMag.c b/fpu/softfloat3c/f128M_to_ui32_r_minMag.c
index bd81b29590..cb8c6cfa78 100644
--- a/fpu/softfloat3c/f128M_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/f128M_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_ui64.c b/fpu/softfloat3c/f128M_to_ui64.c
index 567bad1dd6..d782b5ab82 100644
--- a/fpu/softfloat3c/f128M_to_ui64.c
+++ b/fpu/softfloat3c/f128M_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128M_to_ui64_r_minMag.c b/fpu/softfloat3c/f128M_to_ui64_r_minMag.c
index 4cf49d3bf8..a8cd41b3b3 100644
--- a/fpu/softfloat3c/f128M_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/f128M_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f128_add.c b/fpu/softfloat3c/f128_add.c
index e0dd8f2768..5934f3e46b 100644
--- a/fpu/softfloat3c/f128_add.c
+++ b/fpu/softfloat3c/f128_add.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_add( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_div.c b/fpu/softfloat3c/f128_div.c
index 88281b46d3..30cb349c8a 100644
--- a/fpu/softfloat3c/f128_div.c
+++ b/fpu/softfloat3c/f128_div.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_div( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_eq.c b/fpu/softfloat3c/f128_eq.c
index 6d3b88c4e5..3a82705373 100644
--- a/fpu/softfloat3c/f128_eq.c
+++ b/fpu/softfloat3c/f128_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_eq( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_eq_signaling.c b/fpu/softfloat3c/f128_eq_signaling.c
index 92089596e8..105dfbd18e 100644
--- a/fpu/softfloat3c/f128_eq_signaling.c
+++ b/fpu/softfloat3c/f128_eq_signaling.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_eq_signaling( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_isSignalingNaN.c b/fpu/softfloat3c/f128_isSignalingNaN.c
index 197d46bcb0..5dc2cde1ba 100644
--- a/fpu/softfloat3c/f128_isSignalingNaN.c
+++ b/fpu/softfloat3c/f128_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_isSignalingNaN( float128_t a )
 {
diff --git a/fpu/softfloat3c/f128_le.c b/fpu/softfloat3c/f128_le.c
index f56f560bce..44e3d1662b 100644
--- a/fpu/softfloat3c/f128_le.c
+++ b/fpu/softfloat3c/f128_le.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_le( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_le_quiet.c b/fpu/softfloat3c/f128_le_quiet.c
index a06bfed28e..01c8fc87d5 100644
--- a/fpu/softfloat3c/f128_le_quiet.c
+++ b/fpu/softfloat3c/f128_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_le_quiet( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_lt.c b/fpu/softfloat3c/f128_lt.c
index b512fb69c6..68347f1a95 100644
--- a/fpu/softfloat3c/f128_lt.c
+++ b/fpu/softfloat3c/f128_lt.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_lt( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_lt_quiet.c b/fpu/softfloat3c/f128_lt_quiet.c
index 67abe3f6c5..51baeb9c36 100644
--- a/fpu/softfloat3c/f128_lt_quiet.c
+++ b/fpu/softfloat3c/f128_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f128_lt_quiet( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_mul.c b/fpu/softfloat3c/f128_mul.c
index 328979d39b..158eba3780 100644
--- a/fpu/softfloat3c/f128_mul.c
+++ b/fpu/softfloat3c/f128_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_mul( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_mulAdd.c b/fpu/softfloat3c/f128_mulAdd.c
index b761d759c4..bf682e6ede 100644
--- a/fpu/softfloat3c/f128_mulAdd.c
+++ b/fpu/softfloat3c/f128_mulAdd.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_mulAdd( float128_t a, float128_t b, float128_t c )
 {
diff --git a/fpu/softfloat3c/f128_rem.c b/fpu/softfloat3c/f128_rem.c
index 1a966a8cac..5484d4ef24 100644
--- a/fpu/softfloat3c/f128_rem.c
+++ b/fpu/softfloat3c/f128_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_rem( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_roundToInt.c b/fpu/softfloat3c/f128_roundToInt.c
index f66de96ed5..1ba3019336 100644
--- a/fpu/softfloat3c/f128_roundToInt.c
+++ b/fpu/softfloat3c/f128_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t
  f128_roundToInt( float128_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/f128_sqrt.c b/fpu/softfloat3c/f128_sqrt.c
index 0cab01ba4e..c2ff56fa20 100644
--- a/fpu/softfloat3c/f128_sqrt.c
+++ b/fpu/softfloat3c/f128_sqrt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_sqrt( float128_t a )
 {
diff --git a/fpu/softfloat3c/f128_sub.c b/fpu/softfloat3c/f128_sub.c
index 349fe65b4c..a43dc3587e 100644
--- a/fpu/softfloat3c/f128_sub.c
+++ b/fpu/softfloat3c/f128_sub.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f128_sub( float128_t a, float128_t b )
 {
diff --git a/fpu/softfloat3c/f128_to_extF80.c b/fpu/softfloat3c/f128_to_extF80.c
index ce24e5bfb8..dc5035d4fd 100644
--- a/fpu/softfloat3c/f128_to_extF80.c
+++ b/fpu/softfloat3c/f128_to_extF80.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t f128_to_extF80( float128_t a )
 {
diff --git a/fpu/softfloat3c/f128_to_f16.c b/fpu/softfloat3c/f128_to_f16.c
index f3f4e7a365..487a821ae3 100644
--- a/fpu/softfloat3c/f128_to_f16.c
+++ b/fpu/softfloat3c/f128_to_f16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f128_to_f16( float128_t a )
 {
diff --git a/fpu/softfloat3c/f128_to_f32.c b/fpu/softfloat3c/f128_to_f32.c
index 9df420d435..256c7d9797 100644
--- a/fpu/softfloat3c/f128_to_f32.c
+++ b/fpu/softfloat3c/f128_to_f32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f128_to_f32( float128_t a )
 {
diff --git a/fpu/softfloat3c/f128_to_f64.c b/fpu/softfloat3c/f128_to_f64.c
index a40a2319a6..f2a9cbfff0 100644
--- a/fpu/softfloat3c/f128_to_f64.c
+++ b/fpu/softfloat3c/f128_to_f64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f128_to_f64( float128_t a )
 {
diff --git a/fpu/softfloat3c/f128_to_i32.c b/fpu/softfloat3c/f128_to_i32.c
index 2610782e06..f91fc07bde 100644
--- a/fpu/softfloat3c/f128_to_i32.c
+++ b/fpu/softfloat3c/f128_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f128_to_i32( float128_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f128_to_i32_r_minMag.c b/fpu/softfloat3c/f128_to_i32_r_minMag.c
index 43ba4a2367..413334817f 100644
--- a/fpu/softfloat3c/f128_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/f128_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f128_to_i32_r_minMag( float128_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f128_to_i64.c b/fpu/softfloat3c/f128_to_i64.c
index d57874dd4c..5bfb3617d6 100644
--- a/fpu/softfloat3c/f128_to_i64.c
+++ b/fpu/softfloat3c/f128_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f128_to_i64( float128_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f128_to_i64_r_minMag.c b/fpu/softfloat3c/f128_to_i64_r_minMag.c
index 718bff4292..bcfe9ea3ef 100644
--- a/fpu/softfloat3c/f128_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/f128_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f128_to_i64_r_minMag( float128_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f128_to_ui32.c b/fpu/softfloat3c/f128_to_ui32.c
index 8b94897e57..a0c3cb19fc 100644
--- a/fpu/softfloat3c/f128_to_ui32.c
+++ b/fpu/softfloat3c/f128_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t
  f128_to_ui32( float128_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/f128_to_ui32_r_minMag.c b/fpu/softfloat3c/f128_to_ui32_r_minMag.c
index ab81a27b40..834d76174f 100644
--- a/fpu/softfloat3c/f128_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/f128_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f128_to_ui32_r_minMag( float128_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f128_to_ui64.c b/fpu/softfloat3c/f128_to_ui64.c
index d12be45038..d70375220e 100644
--- a/fpu/softfloat3c/f128_to_ui64.c
+++ b/fpu/softfloat3c/f128_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t
  f128_to_ui64( float128_t a, uint_fast8_t roundingMode, bool exact )
diff --git a/fpu/softfloat3c/f128_to_ui64_r_minMag.c b/fpu/softfloat3c/f128_to_ui64_r_minMag.c
index 28757513b4..7bf1bfedfa 100644
--- a/fpu/softfloat3c/f128_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/f128_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f128_to_ui64_r_minMag( float128_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_add.c b/fpu/softfloat3c/f16_add.c
index 230dabddb7..fb53e1e276 100644
--- a/fpu/softfloat3c/f16_add.c
+++ b/fpu/softfloat3c/f16_add.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f16_add( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_div.c b/fpu/softfloat3c/f16_div.c
index 381057005b..6752fe051d 100644
--- a/fpu/softfloat3c/f16_div.c
+++ b/fpu/softfloat3c/f16_div.c
@@ -37,12 +37,12 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 #include "specialize.h"
-#include "softfloat.h"
 
-extern const uint16_t softfloat_approxRecip_1k0s[];
-extern const uint16_t softfloat_approxRecip_1k1s[];
+/* extern const uint16_t softfloat_approxRecip_1k0s[]; */
+/* extern const uint16_t softfloat_approxRecip_1k1s[]; */
 
 float16_t f16_div( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_eq.c b/fpu/softfloat3c/f16_eq.c
index 15e6077154..1fe7629b2c 100644
--- a/fpu/softfloat3c/f16_eq.c
+++ b/fpu/softfloat3c/f16_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_eq( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_eq_signaling.c b/fpu/softfloat3c/f16_eq_signaling.c
index 6e324baf09..199a4c0144 100644
--- a/fpu/softfloat3c/f16_eq_signaling.c
+++ b/fpu/softfloat3c/f16_eq_signaling.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_eq_signaling( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_isSignalingNaN.c b/fpu/softfloat3c/f16_isSignalingNaN.c
index 5e2370f3cd..b710740a2e 100644
--- a/fpu/softfloat3c/f16_isSignalingNaN.c
+++ b/fpu/softfloat3c/f16_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_isSignalingNaN( float16_t a )
 {
diff --git a/fpu/softfloat3c/f16_le.c b/fpu/softfloat3c/f16_le.c
index 5be7b0dec4..a98bd61e75 100644
--- a/fpu/softfloat3c/f16_le.c
+++ b/fpu/softfloat3c/f16_le.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_le( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_le_quiet.c b/fpu/softfloat3c/f16_le_quiet.c
index 1b1a416580..0f70744241 100644
--- a/fpu/softfloat3c/f16_le_quiet.c
+++ b/fpu/softfloat3c/f16_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_le_quiet( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_lt.c b/fpu/softfloat3c/f16_lt.c
index 97a9a620cd..d9909cc456 100644
--- a/fpu/softfloat3c/f16_lt.c
+++ b/fpu/softfloat3c/f16_lt.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_lt( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_lt_quiet.c b/fpu/softfloat3c/f16_lt_quiet.c
index 029ff55852..bd52b360b5 100644
--- a/fpu/softfloat3c/f16_lt_quiet.c
+++ b/fpu/softfloat3c/f16_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f16_lt_quiet( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_mul.c b/fpu/softfloat3c/f16_mul.c
index b1a79089de..ca731efe3f 100644
--- a/fpu/softfloat3c/f16_mul.c
+++ b/fpu/softfloat3c/f16_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f16_mul( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_mulAdd.c b/fpu/softfloat3c/f16_mulAdd.c
index 98fbd52a92..8fc7b904b2 100644
--- a/fpu/softfloat3c/f16_mulAdd.c
+++ b/fpu/softfloat3c/f16_mulAdd.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f16_mulAdd( float16_t a, float16_t b, float16_t c )
 {
diff --git a/fpu/softfloat3c/f16_rem.c b/fpu/softfloat3c/f16_rem.c
index 57f6e68afd..f8c724ffc2 100644
--- a/fpu/softfloat3c/f16_rem.c
+++ b/fpu/softfloat3c/f16_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f16_rem( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_roundToInt.c b/fpu/softfloat3c/f16_roundToInt.c
index 072232e8cc..c10bfbb19d 100644
--- a/fpu/softfloat3c/f16_roundToInt.c
+++ b/fpu/softfloat3c/f16_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f16_roundToInt( float16_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_sqrt.c b/fpu/softfloat3c/f16_sqrt.c
index 5f5f927327..1291bd6399 100644
--- a/fpu/softfloat3c/f16_sqrt.c
+++ b/fpu/softfloat3c/f16_sqrt.c
@@ -37,12 +37,12 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 #include "specialize.h"
-#include "softfloat.h"
 
-extern const uint16_t softfloat_approxRecipSqrt_1k0s[];
-extern const uint16_t softfloat_approxRecipSqrt_1k1s[];
+/* extern const uint16_t softfloat_approxRecipSqrt_1k0s[]; */
+/* extern const uint16_t softfloat_approxRecipSqrt_1k1s[]; */
 
 float16_t f16_sqrt( float16_t a )
 {
diff --git a/fpu/softfloat3c/f16_sub.c b/fpu/softfloat3c/f16_sub.c
index 71c643a22a..73331f277f 100644
--- a/fpu/softfloat3c/f16_sub.c
+++ b/fpu/softfloat3c/f16_sub.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f16_sub( float16_t a, float16_t b )
 {
diff --git a/fpu/softfloat3c/f16_to_extF80.c b/fpu/softfloat3c/f16_to_extF80.c
index 10cd58b6a2..d0d73a5704 100644
--- a/fpu/softfloat3c/f16_to_extF80.c
+++ b/fpu/softfloat3c/f16_to_extF80.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t f16_to_extF80( float16_t a )
 {
diff --git a/fpu/softfloat3c/f16_to_extF80M.c b/fpu/softfloat3c/f16_to_extF80M.c
index 65fb12d0fb..a289a42895 100644
--- a/fpu/softfloat3c/f16_to_extF80M.c
+++ b/fpu/softfloat3c/f16_to_extF80M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f16_to_f128.c b/fpu/softfloat3c/f16_to_f128.c
index 4e557efd4b..e9e371479c 100644
--- a/fpu/softfloat3c/f16_to_f128.c
+++ b/fpu/softfloat3c/f16_to_f128.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 #include "specialize.h"
-#include "softfloat.h"
 
 float128_t f16_to_f128( float16_t a )
 {
diff --git a/fpu/softfloat3c/f16_to_f128M.c b/fpu/softfloat3c/f16_to_f128M.c
index af09eaa1dc..b947ffc08d 100644
--- a/fpu/softfloat3c/f16_to_f128M.c
+++ b/fpu/softfloat3c/f16_to_f128M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f16_to_f32.c b/fpu/softfloat3c/f16_to_f32.c
index a487d4798f..39570112d8 100644
--- a/fpu/softfloat3c/f16_to_f32.c
+++ b/fpu/softfloat3c/f16_to_f32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f16_to_f32( float16_t a )
 {
diff --git a/fpu/softfloat3c/f16_to_f64.c b/fpu/softfloat3c/f16_to_f64.c
index 02906aecbf..a091de738c 100644
--- a/fpu/softfloat3c/f16_to_f64.c
+++ b/fpu/softfloat3c/f16_to_f64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f16_to_f64( float16_t a )
 {
diff --git a/fpu/softfloat3c/f16_to_i32.c b/fpu/softfloat3c/f16_to_i32.c
index 67c30342f0..dbd4e10f03 100644
--- a/fpu/softfloat3c/f16_to_i32.c
+++ b/fpu/softfloat3c/f16_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f16_to_i32( float16_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_i32_r_minMag.c b/fpu/softfloat3c/f16_to_i32_r_minMag.c
index c1023efee7..f4868f89ee 100644
--- a/fpu/softfloat3c/f16_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/f16_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f16_to_i32_r_minMag( float16_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_i64.c b/fpu/softfloat3c/f16_to_i64.c
index abf71a0aec..c11ad251e3 100644
--- a/fpu/softfloat3c/f16_to_i64.c
+++ b/fpu/softfloat3c/f16_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f16_to_i64( float16_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_i64_r_minMag.c b/fpu/softfloat3c/f16_to_i64_r_minMag.c
index db0eaed903..c497861219 100644
--- a/fpu/softfloat3c/f16_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/f16_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f16_to_i64_r_minMag( float16_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_ui32.c b/fpu/softfloat3c/f16_to_ui32.c
index e27befff54..9211ffcf61 100644
--- a/fpu/softfloat3c/f16_to_ui32.c
+++ b/fpu/softfloat3c/f16_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f16_to_ui32( float16_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_ui32_r_minMag.c b/fpu/softfloat3c/f16_to_ui32_r_minMag.c
index 518769ca44..3b19b2a01e 100644
--- a/fpu/softfloat3c/f16_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/f16_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f16_to_ui32_r_minMag( float16_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_ui64.c b/fpu/softfloat3c/f16_to_ui64.c
index e7f8e33814..a8616832c9 100644
--- a/fpu/softfloat3c/f16_to_ui64.c
+++ b/fpu/softfloat3c/f16_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f16_to_ui64( float16_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f16_to_ui64_r_minMag.c b/fpu/softfloat3c/f16_to_ui64_r_minMag.c
index ba9021e6a8..08a12fcedc 100644
--- a/fpu/softfloat3c/f16_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/f16_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f16_to_ui64_r_minMag( float16_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_add.c b/fpu/softfloat3c/f32_add.c
index 42e1a6a02a..5726144373 100644
--- a/fpu/softfloat3c/f32_add.c
+++ b/fpu/softfloat3c/f32_add.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_add( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_div.c b/fpu/softfloat3c/f32_div.c
index 3d4b232685..806eef2952 100644
--- a/fpu/softfloat3c/f32_div.c
+++ b/fpu/softfloat3c/f32_div.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_div( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_eq.c b/fpu/softfloat3c/f32_eq.c
index fc05c91908..c618f9384e 100644
--- a/fpu/softfloat3c/f32_eq.c
+++ b/fpu/softfloat3c/f32_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_eq( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_eq_signaling.c b/fpu/softfloat3c/f32_eq_signaling.c
index ff7c39e956..7a38014800 100644
--- a/fpu/softfloat3c/f32_eq_signaling.c
+++ b/fpu/softfloat3c/f32_eq_signaling.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_eq_signaling( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_isSignalingNaN.c b/fpu/softfloat3c/f32_isSignalingNaN.c
index 9290fa9697..8298aab457 100644
--- a/fpu/softfloat3c/f32_isSignalingNaN.c
+++ b/fpu/softfloat3c/f32_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_isSignalingNaN( float32_t a )
 {
diff --git a/fpu/softfloat3c/f32_le.c b/fpu/softfloat3c/f32_le.c
index d2f8519ae4..63c4dc8e61 100644
--- a/fpu/softfloat3c/f32_le.c
+++ b/fpu/softfloat3c/f32_le.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_le( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_le_quiet.c b/fpu/softfloat3c/f32_le_quiet.c
index de004db5fd..6a7d97e812 100644
--- a/fpu/softfloat3c/f32_le_quiet.c
+++ b/fpu/softfloat3c/f32_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_le_quiet( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_lt.c b/fpu/softfloat3c/f32_lt.c
index 5a12891b24..20424db86f 100644
--- a/fpu/softfloat3c/f32_lt.c
+++ b/fpu/softfloat3c/f32_lt.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_lt( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_lt_quiet.c b/fpu/softfloat3c/f32_lt_quiet.c
index 694b901b3e..c99da4a865 100644
--- a/fpu/softfloat3c/f32_lt_quiet.c
+++ b/fpu/softfloat3c/f32_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f32_lt_quiet( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_mul.c b/fpu/softfloat3c/f32_mul.c
index 6880fb9238..8d482090e2 100644
--- a/fpu/softfloat3c/f32_mul.c
+++ b/fpu/softfloat3c/f32_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_mul( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_mulAdd.c b/fpu/softfloat3c/f32_mulAdd.c
index caddad0632..2d567fec9a 100644
--- a/fpu/softfloat3c/f32_mulAdd.c
+++ b/fpu/softfloat3c/f32_mulAdd.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_mulAdd( float32_t a, float32_t b, float32_t c )
 {
diff --git a/fpu/softfloat3c/f32_rem.c b/fpu/softfloat3c/f32_rem.c
index 1028b25fd0..61d49a72ae 100644
--- a/fpu/softfloat3c/f32_rem.c
+++ b/fpu/softfloat3c/f32_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_rem( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_roundToInt.c b/fpu/softfloat3c/f32_roundToInt.c
index ed903262b9..18ec04b6c3 100644
--- a/fpu/softfloat3c/f32_roundToInt.c
+++ b/fpu/softfloat3c/f32_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_roundToInt( float32_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_sqrt.c b/fpu/softfloat3c/f32_sqrt.c
index 028a3be928..aedb18458d 100644
--- a/fpu/softfloat3c/f32_sqrt.c
+++ b/fpu/softfloat3c/f32_sqrt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_sqrt( float32_t a )
 {
diff --git a/fpu/softfloat3c/f32_sub.c b/fpu/softfloat3c/f32_sub.c
index c452298ae3..0b0b7910fe 100644
--- a/fpu/softfloat3c/f32_sub.c
+++ b/fpu/softfloat3c/f32_sub.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f32_sub( float32_t a, float32_t b )
 {
diff --git a/fpu/softfloat3c/f32_to_extF80.c b/fpu/softfloat3c/f32_to_extF80.c
index 574aa4fb16..2365f0e5c0 100644
--- a/fpu/softfloat3c/f32_to_extF80.c
+++ b/fpu/softfloat3c/f32_to_extF80.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t f32_to_extF80( float32_t a )
 {
diff --git a/fpu/softfloat3c/f32_to_extF80M.c b/fpu/softfloat3c/f32_to_extF80M.c
index 3388654e78..af746e914b 100644
--- a/fpu/softfloat3c/f32_to_extF80M.c
+++ b/fpu/softfloat3c/f32_to_extF80M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f32_to_f128.c b/fpu/softfloat3c/f32_to_f128.c
index 29888580d3..b8ea8128ca 100644
--- a/fpu/softfloat3c/f32_to_f128.c
+++ b/fpu/softfloat3c/f32_to_f128.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f32_to_f128( float32_t a )
 {
diff --git a/fpu/softfloat3c/f32_to_f128M.c b/fpu/softfloat3c/f32_to_f128M.c
index 1739ee4ff7..5e782f515e 100644
--- a/fpu/softfloat3c/f32_to_f128M.c
+++ b/fpu/softfloat3c/f32_to_f128M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f32_to_f16.c b/fpu/softfloat3c/f32_to_f16.c
index 6a62b6b466..566f34f957 100644
--- a/fpu/softfloat3c/f32_to_f16.c
+++ b/fpu/softfloat3c/f32_to_f16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f32_to_f16( float32_t a )
 {
diff --git a/fpu/softfloat3c/f32_to_f64.c b/fpu/softfloat3c/f32_to_f64.c
index 7dad8038ec..680983f1c2 100644
--- a/fpu/softfloat3c/f32_to_f64.c
+++ b/fpu/softfloat3c/f32_to_f64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f32_to_f64( float32_t a )
 {
diff --git a/fpu/softfloat3c/f32_to_i32.c b/fpu/softfloat3c/f32_to_i32.c
index 9cd2ca3f0b..93ff1ba01e 100644
--- a/fpu/softfloat3c/f32_to_i32.c
+++ b/fpu/softfloat3c/f32_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f32_to_i32( float32_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_i32_r_minMag.c b/fpu/softfloat3c/f32_to_i32_r_minMag.c
index 521d34d067..36a3c157f6 100644
--- a/fpu/softfloat3c/f32_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/f32_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f32_to_i32_r_minMag( float32_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_i64.c b/fpu/softfloat3c/f32_to_i64.c
index 126546d7ab..b511571f88 100644
--- a/fpu/softfloat3c/f32_to_i64.c
+++ b/fpu/softfloat3c/f32_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f32_to_i64( float32_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_i64_r_minMag.c b/fpu/softfloat3c/f32_to_i64_r_minMag.c
index 940aa59f65..faa813608b 100644
--- a/fpu/softfloat3c/f32_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/f32_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f32_to_i64_r_minMag( float32_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_ui32.c b/fpu/softfloat3c/f32_to_ui32.c
index 5b5f7eb87e..63741871ca 100644
--- a/fpu/softfloat3c/f32_to_ui32.c
+++ b/fpu/softfloat3c/f32_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f32_to_ui32( float32_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_ui32_r_minMag.c b/fpu/softfloat3c/f32_to_ui32_r_minMag.c
index ae30170b97..07ec8acb59 100644
--- a/fpu/softfloat3c/f32_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/f32_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f32_to_ui32_r_minMag( float32_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_ui64.c b/fpu/softfloat3c/f32_to_ui64.c
index 67f396d308..d331e67a39 100644
--- a/fpu/softfloat3c/f32_to_ui64.c
+++ b/fpu/softfloat3c/f32_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f32_to_ui64( float32_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f32_to_ui64_r_minMag.c b/fpu/softfloat3c/f32_to_ui64_r_minMag.c
index 5d2fe22127..804ec5ed9a 100644
--- a/fpu/softfloat3c/f32_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/f32_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f32_to_ui64_r_minMag( float32_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_add.c b/fpu/softfloat3c/f64_add.c
index 33b0a7397d..bd07247825 100644
--- a/fpu/softfloat3c/f64_add.c
+++ b/fpu/softfloat3c/f64_add.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_add( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_div.c b/fpu/softfloat3c/f64_div.c
index ac3e612b1c..e9d3380198 100644
--- a/fpu/softfloat3c/f64_div.c
+++ b/fpu/softfloat3c/f64_div.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_div( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_eq.c b/fpu/softfloat3c/f64_eq.c
index 76b4127cef..80c86cf619 100644
--- a/fpu/softfloat3c/f64_eq.c
+++ b/fpu/softfloat3c/f64_eq.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_eq( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_eq_signaling.c b/fpu/softfloat3c/f64_eq_signaling.c
index 8b688a6e65..a33fbe9d45 100644
--- a/fpu/softfloat3c/f64_eq_signaling.c
+++ b/fpu/softfloat3c/f64_eq_signaling.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_eq_signaling( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_isSignalingNaN.c b/fpu/softfloat3c/f64_isSignalingNaN.c
index ae89c6bc00..e8e2b03e04 100644
--- a/fpu/softfloat3c/f64_isSignalingNaN.c
+++ b/fpu/softfloat3c/f64_isSignalingNaN.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_isSignalingNaN( float64_t a )
 {
diff --git a/fpu/softfloat3c/f64_le.c b/fpu/softfloat3c/f64_le.c
index 0c22f834a7..ca9bd7253d 100644
--- a/fpu/softfloat3c/f64_le.c
+++ b/fpu/softfloat3c/f64_le.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_le( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_le_quiet.c b/fpu/softfloat3c/f64_le_quiet.c
index 9984cea87a..e570887997 100644
--- a/fpu/softfloat3c/f64_le_quiet.c
+++ b/fpu/softfloat3c/f64_le_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_le_quiet( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_lt.c b/fpu/softfloat3c/f64_lt.c
index e49d8257b6..5fc79b7e82 100644
--- a/fpu/softfloat3c/f64_lt.c
+++ b/fpu/softfloat3c/f64_lt.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_lt( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_lt_quiet.c b/fpu/softfloat3c/f64_lt_quiet.c
index 0a1c39f516..168e071b41 100644
--- a/fpu/softfloat3c/f64_lt_quiet.c
+++ b/fpu/softfloat3c/f64_lt_quiet.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 bool f64_lt_quiet( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_mul.c b/fpu/softfloat3c/f64_mul.c
index a9fac898d7..eba287a533 100644
--- a/fpu/softfloat3c/f64_mul.c
+++ b/fpu/softfloat3c/f64_mul.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_mul( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_mulAdd.c b/fpu/softfloat3c/f64_mulAdd.c
index c5c1d073ab..301fbfbc8d 100644
--- a/fpu/softfloat3c/f64_mulAdd.c
+++ b/fpu/softfloat3c/f64_mulAdd.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_mulAdd( float64_t a, float64_t b, float64_t c )
 {
diff --git a/fpu/softfloat3c/f64_rem.c b/fpu/softfloat3c/f64_rem.c
index da3266bcbc..0d02701a94 100644
--- a/fpu/softfloat3c/f64_rem.c
+++ b/fpu/softfloat3c/f64_rem.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_rem( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_roundToInt.c b/fpu/softfloat3c/f64_roundToInt.c
index 5f96bd1a4c..17cf5ab383 100644
--- a/fpu/softfloat3c/f64_roundToInt.c
+++ b/fpu/softfloat3c/f64_roundToInt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_roundToInt( float64_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_sqrt.c b/fpu/softfloat3c/f64_sqrt.c
index 04974bc69e..ac2541c6e0 100644
--- a/fpu/softfloat3c/f64_sqrt.c
+++ b/fpu/softfloat3c/f64_sqrt.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_sqrt( float64_t a )
 {
diff --git a/fpu/softfloat3c/f64_sub.c b/fpu/softfloat3c/f64_sub.c
index c8a1b58bca..86dbba5cf4 100644
--- a/fpu/softfloat3c/f64_sub.c
+++ b/fpu/softfloat3c/f64_sub.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t f64_sub( float64_t a, float64_t b )
 {
diff --git a/fpu/softfloat3c/f64_to_extF80.c b/fpu/softfloat3c/f64_to_extF80.c
index 634ad93786..13d1a36b8d 100644
--- a/fpu/softfloat3c/f64_to_extF80.c
+++ b/fpu/softfloat3c/f64_to_extF80.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t f64_to_extF80( float64_t a )
 {
diff --git a/fpu/softfloat3c/f64_to_extF80M.c b/fpu/softfloat3c/f64_to_extF80M.c
index 258204315a..c3fe75dff7 100644
--- a/fpu/softfloat3c/f64_to_extF80M.c
+++ b/fpu/softfloat3c/f64_to_extF80M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f64_to_f128.c b/fpu/softfloat3c/f64_to_f128.c
index 4b15258698..f44a5db267 100644
--- a/fpu/softfloat3c/f64_to_f128.c
+++ b/fpu/softfloat3c/f64_to_f128.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t f64_to_f128( float64_t a )
 {
diff --git a/fpu/softfloat3c/f64_to_f128M.c b/fpu/softfloat3c/f64_to_f128M.c
index 0fe36ff42e..14db80895a 100644
--- a/fpu/softfloat3c/f64_to_f128M.c
+++ b/fpu/softfloat3c/f64_to_f128M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/f64_to_f16.c b/fpu/softfloat3c/f64_to_f16.c
index 4e2040b94b..9869960e4b 100644
--- a/fpu/softfloat3c/f64_to_f16.c
+++ b/fpu/softfloat3c/f64_to_f16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t f64_to_f16( float64_t a )
 {
diff --git a/fpu/softfloat3c/f64_to_f32.c b/fpu/softfloat3c/f64_to_f32.c
index 640bb91dc9..ebfbb59529 100644
--- a/fpu/softfloat3c/f64_to_f32.c
+++ b/fpu/softfloat3c/f64_to_f32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t f64_to_f32( float64_t a )
 {
diff --git a/fpu/softfloat3c/f64_to_i32.c b/fpu/softfloat3c/f64_to_i32.c
index c2aaeade4d..24e67c45f1 100644
--- a/fpu/softfloat3c/f64_to_i32.c
+++ b/fpu/softfloat3c/f64_to_i32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f64_to_i32( float64_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_i32_r_minMag.c b/fpu/softfloat3c/f64_to_i32_r_minMag.c
index d936bd6aaa..167d5c6ba6 100644
--- a/fpu/softfloat3c/f64_to_i32_r_minMag.c
+++ b/fpu/softfloat3c/f64_to_i32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t f64_to_i32_r_minMag( float64_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_i64.c b/fpu/softfloat3c/f64_to_i64.c
index da53f5c7d2..3552efd0d3 100644
--- a/fpu/softfloat3c/f64_to_i64.c
+++ b/fpu/softfloat3c/f64_to_i64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f64_to_i64( float64_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_i64_r_minMag.c b/fpu/softfloat3c/f64_to_i64_r_minMag.c
index 0c70057f1b..979d17d839 100644
--- a/fpu/softfloat3c/f64_to_i64_r_minMag.c
+++ b/fpu/softfloat3c/f64_to_i64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t f64_to_i64_r_minMag( float64_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_ui32.c b/fpu/softfloat3c/f64_to_ui32.c
index 20f4e4ce9e..4c86afb3d9 100644
--- a/fpu/softfloat3c/f64_to_ui32.c
+++ b/fpu/softfloat3c/f64_to_ui32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f64_to_ui32( float64_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_ui32_r_minMag.c b/fpu/softfloat3c/f64_to_ui32_r_minMag.c
index 34d230adb2..44ac8f2914 100644
--- a/fpu/softfloat3c/f64_to_ui32_r_minMag.c
+++ b/fpu/softfloat3c/f64_to_ui32_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t f64_to_ui32_r_minMag( float64_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_ui64.c b/fpu/softfloat3c/f64_to_ui64.c
index c90bb5d8da..6f8ed417d7 100644
--- a/fpu/softfloat3c/f64_to_ui64.c
+++ b/fpu/softfloat3c/f64_to_ui64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f64_to_ui64( float64_t a, uint_fast8_t roundingMode, bool exact )
 {
diff --git a/fpu/softfloat3c/f64_to_ui64_r_minMag.c b/fpu/softfloat3c/f64_to_ui64_r_minMag.c
index 7d9ce9c025..973533474b 100644
--- a/fpu/softfloat3c/f64_to_ui64_r_minMag.c
+++ b/fpu/softfloat3c/f64_to_ui64_r_minMag.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t f64_to_ui64_r_minMag( float64_t a, bool exact )
 {
diff --git a/fpu/softfloat3c/i32_to_extF80.c b/fpu/softfloat3c/i32_to_extF80.c
index 8ad1881d95..27fe42a31b 100644
--- a/fpu/softfloat3c/i32_to_extF80.c
+++ b/fpu/softfloat3c/i32_to_extF80.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t i32_to_extF80( int32_t a )
 {
diff --git a/fpu/softfloat3c/i32_to_extF80M.c b/fpu/softfloat3c/i32_to_extF80M.c
index 91ebdf43b1..635e6f5390 100644
--- a/fpu/softfloat3c/i32_to_extF80M.c
+++ b/fpu/softfloat3c/i32_to_extF80M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/i32_to_f128.c b/fpu/softfloat3c/i32_to_f128.c
index b6e08f33af..ecca68d4f5 100644
--- a/fpu/softfloat3c/i32_to_f128.c
+++ b/fpu/softfloat3c/i32_to_f128.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t i32_to_f128( int32_t a )
 {
diff --git a/fpu/softfloat3c/i32_to_f128M.c b/fpu/softfloat3c/i32_to_f128M.c
index ee461ce170..228cdc91ae 100644
--- a/fpu/softfloat3c/i32_to_f128M.c
+++ b/fpu/softfloat3c/i32_to_f128M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/i32_to_f16.c b/fpu/softfloat3c/i32_to_f16.c
index f656272d94..6927e0f70b 100644
--- a/fpu/softfloat3c/i32_to_f16.c
+++ b/fpu/softfloat3c/i32_to_f16.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t i32_to_f16( int32_t a )
 {
diff --git a/fpu/softfloat3c/i32_to_f32.c b/fpu/softfloat3c/i32_to_f32.c
index d51cdfce25..7478f898c6 100644
--- a/fpu/softfloat3c/i32_to_f32.c
+++ b/fpu/softfloat3c/i32_to_f32.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t i32_to_f32( int32_t a )
 {
diff --git a/fpu/softfloat3c/i32_to_f64.c b/fpu/softfloat3c/i32_to_f64.c
index 641af60f9f..1e108d1d64 100644
--- a/fpu/softfloat3c/i32_to_f64.c
+++ b/fpu/softfloat3c/i32_to_f64.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t i32_to_f64( int32_t a )
 {
diff --git a/fpu/softfloat3c/i64_to_extF80.c b/fpu/softfloat3c/i64_to_extF80.c
index 61334686e5..f791537fa2 100644
--- a/fpu/softfloat3c/i64_to_extF80.c
+++ b/fpu/softfloat3c/i64_to_extF80.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t i64_to_extF80( int64_t a )
 {
diff --git a/fpu/softfloat3c/i64_to_extF80M.c b/fpu/softfloat3c/i64_to_extF80M.c
index 1ccbfac3ab..9f63fcd663 100644
--- a/fpu/softfloat3c/i64_to_extF80M.c
+++ b/fpu/softfloat3c/i64_to_extF80M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/i64_to_f128.c b/fpu/softfloat3c/i64_to_f128.c
index 6223cce2ec..739c069f44 100644
--- a/fpu/softfloat3c/i64_to_f128.c
+++ b/fpu/softfloat3c/i64_to_f128.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t i64_to_f128( int64_t a )
 {
diff --git a/fpu/softfloat3c/i64_to_f128M.c b/fpu/softfloat3c/i64_to_f128M.c
index 35fdfcaf8c..b42fd4232e 100644
--- a/fpu/softfloat3c/i64_to_f128M.c
+++ b/fpu/softfloat3c/i64_to_f128M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/i64_to_f16.c b/fpu/softfloat3c/i64_to_f16.c
index a5c4bc8712..ee32e33622 100644
--- a/fpu/softfloat3c/i64_to_f16.c
+++ b/fpu/softfloat3c/i64_to_f16.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t i64_to_f16( int64_t a )
 {
diff --git a/fpu/softfloat3c/i64_to_f32.c b/fpu/softfloat3c/i64_to_f32.c
index ac2b7bb3e6..dfdd21c6a7 100644
--- a/fpu/softfloat3c/i64_to_f32.c
+++ b/fpu/softfloat3c/i64_to_f32.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t i64_to_f32( int64_t a )
 {
diff --git a/fpu/softfloat3c/i64_to_f64.c b/fpu/softfloat3c/i64_to_f64.c
index d9d4797f5a..afb830823d 100644
--- a/fpu/softfloat3c/i64_to_f64.c
+++ b/fpu/softfloat3c/i64_to_f64.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t i64_to_f64( int64_t a )
 {
diff --git a/fpu/softfloat3c/s_add128.c b/fpu/softfloat3c/s_add128.c
index d556dc9506..0098949386 100644
--- a/fpu/softfloat3c/s_add128.c
+++ b/fpu/softfloat3c/s_add128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_add128
 
diff --git a/fpu/softfloat3c/s_add256M.c b/fpu/softfloat3c/s_add256M.c
index c60e6e8035..d71d3f5823 100644
--- a/fpu/softfloat3c/s_add256M.c
+++ b/fpu/softfloat3c/s_add256M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_add256M
 
diff --git a/fpu/softfloat3c/s_addCarryM.c b/fpu/softfloat3c/s_addCarryM.c
index fa81646d53..3b6b5989fc 100644
--- a/fpu/softfloat3c/s_addCarryM.c
+++ b/fpu/softfloat3c/s_addCarryM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_addCarryM
 
diff --git a/fpu/softfloat3c/s_addComplCarryM.c b/fpu/softfloat3c/s_addComplCarryM.c
index 24cc79855d..db3bf7d834 100644
--- a/fpu/softfloat3c/s_addComplCarryM.c
+++ b/fpu/softfloat3c/s_addComplCarryM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_addComplCarryM
 
diff --git a/fpu/softfloat3c/s_addExtF80M.c b/fpu/softfloat3c/s_addExtF80M.c
index 7d72332d6e..329e98ecd1 100644
--- a/fpu/softfloat3c/s_addExtF80M.c
+++ b/fpu/softfloat3c/s_addExtF80M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void
  softfloat_addExtF80M(
diff --git a/fpu/softfloat3c/s_addF128M.c b/fpu/softfloat3c/s_addF128M.c
index be1e31d261..02bf253707 100644
--- a/fpu/softfloat3c/s_addF128M.c
+++ b/fpu/softfloat3c/s_addF128M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void
  softfloat_addF128M(
diff --git a/fpu/softfloat3c/s_addM.c b/fpu/softfloat3c/s_addM.c
index 45e1751b23..67529521a0 100644
--- a/fpu/softfloat3c/s_addM.c
+++ b/fpu/softfloat3c/s_addM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_addM
 
diff --git a/fpu/softfloat3c/s_addMagsExtF80.c b/fpu/softfloat3c/s_addMagsExtF80.c
index fd4f6d9c52..ee9abfaeb2 100644
--- a/fpu/softfloat3c/s_addMagsExtF80.c
+++ b/fpu/softfloat3c/s_addMagsExtF80.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t
  softfloat_addMagsExtF80(
diff --git a/fpu/softfloat3c/s_addMagsF128.c b/fpu/softfloat3c/s_addMagsF128.c
index 33efe10c50..e70a8853d6 100644
--- a/fpu/softfloat3c/s_addMagsF128.c
+++ b/fpu/softfloat3c/s_addMagsF128.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
 
 float128_t
diff --git a/fpu/softfloat3c/s_addMagsF16.c b/fpu/softfloat3c/s_addMagsF16.c
index 1a1593f8c6..0baabbb3c5 100644
--- a/fpu/softfloat3c/s_addMagsF16.c
+++ b/fpu/softfloat3c/s_addMagsF16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t softfloat_addMagsF16( uint_fast16_t uiA, uint_fast16_t uiB )
 {
diff --git a/fpu/softfloat3c/s_addMagsF32.c b/fpu/softfloat3c/s_addMagsF32.c
index f372c3b1af..701603a2ae 100644
--- a/fpu/softfloat3c/s_addMagsF32.c
+++ b/fpu/softfloat3c/s_addMagsF32.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
 
 float32_t softfloat_addMagsF32( uint_fast32_t uiA, uint_fast32_t uiB )
diff --git a/fpu/softfloat3c/s_addMagsF64.c b/fpu/softfloat3c/s_addMagsF64.c
index 0def51e822..f84244dd92 100644
--- a/fpu/softfloat3c/s_addMagsF64.c
+++ b/fpu/softfloat3c/s_addMagsF64.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
 
 float64_t
diff --git a/fpu/softfloat3c/s_approxRecipSqrt_1Ks.c b/fpu/softfloat3c/s_approxRecipSqrt_1Ks.c
index 9cd9f2ecdd..137df0c1d5 100644
--- a/fpu/softfloat3c/s_approxRecipSqrt_1Ks.c
+++ b/fpu/softfloat3c/s_approxRecipSqrt_1Ks.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 const uint16_t softfloat_approxRecipSqrt_1k0s[16] = {
     0xB4C9, 0xFFAB, 0xAA7D, 0xF11C, 0xA1C5, 0xE4C7, 0x9A43, 0xDA29,
diff --git a/fpu/softfloat3c/s_approxRecip_1Ks.c b/fpu/softfloat3c/s_approxRecip_1Ks.c
index a9b16465ab..be71968db3 100644
--- a/fpu/softfloat3c/s_approxRecip_1Ks.c
+++ b/fpu/softfloat3c/s_approxRecip_1Ks.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 const uint16_t softfloat_approxRecip_1k0s[16] = {
     0xFFC4, 0xF0BE, 0xE363, 0xD76F, 0xCCAD, 0xC2F0, 0xBA16, 0xB201,
diff --git a/fpu/softfloat3c/s_compare128M.c b/fpu/softfloat3c/s_compare128M.c
index 905b59577d..8aeb23f87d 100644
--- a/fpu/softfloat3c/s_compare128M.c
+++ b/fpu/softfloat3c/s_compare128M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_compare128M
 
diff --git a/fpu/softfloat3c/s_compare96M.c b/fpu/softfloat3c/s_compare96M.c
index bb2642a102..ee9254d313 100644
--- a/fpu/softfloat3c/s_compare96M.c
+++ b/fpu/softfloat3c/s_compare96M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_compare96M
 
diff --git a/fpu/softfloat3c/s_compareNonnormExtF80M.c b/fpu/softfloat3c/s_compareNonnormExtF80M.c
index 52296a1bdc..9c47865a30 100644
--- a/fpu/softfloat3c/s_compareNonnormExtF80M.c
+++ b/fpu/softfloat3c/s_compareNonnormExtF80M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "softfloat_types.h"
 
 int
diff --git a/fpu/softfloat3c/s_countLeadingZeros16.c b/fpu/softfloat3c/s_countLeadingZeros16.c
index 0b9faa6a1f..ca5524b579 100644
--- a/fpu/softfloat3c/s_countLeadingZeros16.c
+++ b/fpu/softfloat3c/s_countLeadingZeros16.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_countLeadingZeros16
 
 #define softfloat_countLeadingZeros16 softfloat_countLeadingZeros16
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 uint_fast8_t softfloat_countLeadingZeros16( uint16_t a )
 {
diff --git a/fpu/softfloat3c/s_countLeadingZeros32.c b/fpu/softfloat3c/s_countLeadingZeros32.c
index c85c3a871d..67a07df172 100644
--- a/fpu/softfloat3c/s_countLeadingZeros32.c
+++ b/fpu/softfloat3c/s_countLeadingZeros32.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_countLeadingZeros32
 
 #define softfloat_countLeadingZeros32 softfloat_countLeadingZeros32
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 uint_fast8_t softfloat_countLeadingZeros32( uint32_t a )
 {
diff --git a/fpu/softfloat3c/s_countLeadingZeros64.c b/fpu/softfloat3c/s_countLeadingZeros64.c
index f1c7245a92..536febf4db 100644
--- a/fpu/softfloat3c/s_countLeadingZeros64.c
+++ b/fpu/softfloat3c/s_countLeadingZeros64.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_countLeadingZeros64
 
 #define softfloat_countLeadingZeros64 softfloat_countLeadingZeros64
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 uint_fast8_t softfloat_countLeadingZeros64( uint64_t a )
 {
diff --git a/fpu/softfloat3c/s_countLeadingZeros8.c b/fpu/softfloat3c/s_countLeadingZeros8.c
index 3006dba63a..eb5c846e2c 100644
--- a/fpu/softfloat3c/s_countLeadingZeros8.c
+++ b/fpu/softfloat3c/s_countLeadingZeros8.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 const uint_least8_t softfloat_countLeadingZeros8[256] = {
     8, 7, 6, 6, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4,
diff --git a/fpu/softfloat3c/s_invalidExtF80M.c b/fpu/softfloat3c/s_invalidExtF80M.c
index 6cbada20b7..038f1bbcf3 100644
--- a/fpu/softfloat3c/s_invalidExtF80M.c
+++ b/fpu/softfloat3c/s_invalidExtF80M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include "platform.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void softfloat_invalidExtF80M( struct extFloat80M *zSPtr )
 {
diff --git a/fpu/softfloat3c/s_invalidF128M.c b/fpu/softfloat3c/s_invalidF128M.c
index acf3d126b2..bdd3dbb64c 100644
--- a/fpu/softfloat3c/s_invalidF128M.c
+++ b/fpu/softfloat3c/s_invalidF128M.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void softfloat_invalidF128M( uint32_t *zWPtr )
 {
diff --git a/fpu/softfloat3c/s_isNaNF128M.c b/fpu/softfloat3c/s_isNaNF128M.c
index 5d35e4b517..f63eaa3139 100644
--- a/fpu/softfloat3c/s_isNaNF128M.c
+++ b/fpu/softfloat3c/s_isNaNF128M.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 /*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat3c/s_mul128By32.c b/fpu/softfloat3c/s_mul128By32.c
index 95d31be0aa..da5106aa49 100644
--- a/fpu/softfloat3c/s_mul128By32.c
+++ b/fpu/softfloat3c/s_mul128By32.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_mul128By32
 
diff --git a/fpu/softfloat3c/s_mul128MTo256M.c b/fpu/softfloat3c/s_mul128MTo256M.c
index 8c0526ce0c..357d3530c4 100644
--- a/fpu/softfloat3c/s_mul128MTo256M.c
+++ b/fpu/softfloat3c/s_mul128MTo256M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_mul128MTo256M
 
diff --git a/fpu/softfloat3c/s_mul128To256M.c b/fpu/softfloat3c/s_mul128To256M.c
index 264af029cf..ccfe5c713b 100644
--- a/fpu/softfloat3c/s_mul128To256M.c
+++ b/fpu/softfloat3c/s_mul128To256M.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_mul128To256M
 
 #define softfloat_mul128To256M softfloat_mul128To256M
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 void
  softfloat_mul128To256M(
diff --git a/fpu/softfloat3c/s_mul64ByShifted32To128.c b/fpu/softfloat3c/s_mul64ByShifted32To128.c
index f2fd8c2a03..a5a4f64ac6 100644
--- a/fpu/softfloat3c/s_mul64ByShifted32To128.c
+++ b/fpu/softfloat3c/s_mul64ByShifted32To128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_mul64ByShifted32To128
 
diff --git a/fpu/softfloat3c/s_mul64To128.c b/fpu/softfloat3c/s_mul64To128.c
index f45e9fd2b5..beb64b1d66 100644
--- a/fpu/softfloat3c/s_mul64To128.c
+++ b/fpu/softfloat3c/s_mul64To128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_mul64To128
 
diff --git a/fpu/softfloat3c/s_mul64To128M.c b/fpu/softfloat3c/s_mul64To128M.c
index 97f4c3172e..8ed4b658ce 100644
--- a/fpu/softfloat3c/s_mul64To128M.c
+++ b/fpu/softfloat3c/s_mul64To128M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_mul64To128M
 
diff --git a/fpu/softfloat3c/s_mulAddF128.c b/fpu/softfloat3c/s_mulAddF128.c
index cda7d9cf31..d9c51a6ba6 100644
--- a/fpu/softfloat3c/s_mulAddF128.c
+++ b/fpu/softfloat3c/s_mulAddF128.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t
  softfloat_mulAddF128(
diff --git a/fpu/softfloat3c/s_mulAddF128M.c b/fpu/softfloat3c/s_mulAddF128M.c
index 08a2cf8b59..3e8a43f434 100644
--- a/fpu/softfloat3c/s_mulAddF128M.c
+++ b/fpu/softfloat3c/s_mulAddF128M.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void
  softfloat_mulAddF128M(
diff --git a/fpu/softfloat3c/s_mulAddF16.c b/fpu/softfloat3c/s_mulAddF16.c
index 77c0401b92..4e3e279f45 100644
--- a/fpu/softfloat3c/s_mulAddF16.c
+++ b/fpu/softfloat3c/s_mulAddF16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t
  softfloat_mulAddF16(
diff --git a/fpu/softfloat3c/s_mulAddF32.c b/fpu/softfloat3c/s_mulAddF32.c
index 1f5b9b033a..bb25cc5a01 100644
--- a/fpu/softfloat3c/s_mulAddF32.c
+++ b/fpu/softfloat3c/s_mulAddF32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t
  softfloat_mulAddF32(
diff --git a/fpu/softfloat3c/s_mulAddF64.c b/fpu/softfloat3c/s_mulAddF64.c
index 88148d9526..179e3f8cdd 100644
--- a/fpu/softfloat3c/s_mulAddF64.c
+++ b/fpu/softfloat3c/s_mulAddF64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/s_negXM.c b/fpu/softfloat3c/s_negXM.c
index 10047eda71..ec82ad12da 100644
--- a/fpu/softfloat3c/s_negXM.c
+++ b/fpu/softfloat3c/s_negXM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_negXM
 
diff --git a/fpu/softfloat3c/s_normExtF80SigM.c b/fpu/softfloat3c/s_normExtF80SigM.c
index df48babd4c..ed7b5ec548 100644
--- a/fpu/softfloat3c/s_normExtF80SigM.c
+++ b/fpu/softfloat3c/s_normExtF80SigM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 int softfloat_normExtF80SigM( uint64_t *sigPtr )
 {
diff --git a/fpu/softfloat3c/s_normRoundPackMToExtF80M.c b/fpu/softfloat3c/s_normRoundPackMToExtF80M.c
index 125bfb08ad..0d2c4ab20b 100644
--- a/fpu/softfloat3c/s_normRoundPackMToExtF80M.c
+++ b/fpu/softfloat3c/s_normRoundPackMToExtF80M.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 void
  softfloat_normRoundPackMToExtF80M(
diff --git a/fpu/softfloat3c/s_normRoundPackMToF128M.c b/fpu/softfloat3c/s_normRoundPackMToF128M.c
index f2d368d602..59a9b625ea 100644
--- a/fpu/softfloat3c/s_normRoundPackMToF128M.c
+++ b/fpu/softfloat3c/s_normRoundPackMToF128M.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 void
  softfloat_normRoundPackMToF128M(
diff --git a/fpu/softfloat3c/s_normRoundPackToExtF80.c b/fpu/softfloat3c/s_normRoundPackToExtF80.c
index b735bc0b0b..f0cd34740b 100644
--- a/fpu/softfloat3c/s_normRoundPackToExtF80.c
+++ b/fpu/softfloat3c/s_normRoundPackToExtF80.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 extFloat80_t
  softfloat_normRoundPackToExtF80(
diff --git a/fpu/softfloat3c/s_normRoundPackToF128.c b/fpu/softfloat3c/s_normRoundPackToF128.c
index af7679d154..0395c79e8b 100644
--- a/fpu/softfloat3c/s_normRoundPackToF128.c
+++ b/fpu/softfloat3c/s_normRoundPackToF128.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 float128_t
  softfloat_normRoundPackToF128(
diff --git a/fpu/softfloat3c/s_normRoundPackToF16.c b/fpu/softfloat3c/s_normRoundPackToF16.c
index 4f59863241..833159dc66 100644
--- a/fpu/softfloat3c/s_normRoundPackToF16.c
+++ b/fpu/softfloat3c/s_normRoundPackToF16.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 float16_t
  softfloat_normRoundPackToF16( bool sign, int_fast16_t exp, uint_fast16_t sig )
diff --git a/fpu/softfloat3c/s_normRoundPackToF32.c b/fpu/softfloat3c/s_normRoundPackToF32.c
index e7ce7959a0..d79c8cecba 100644
--- a/fpu/softfloat3c/s_normRoundPackToF32.c
+++ b/fpu/softfloat3c/s_normRoundPackToF32.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 float32_t
  softfloat_normRoundPackToF32( bool sign, int_fast16_t exp, uint_fast32_t sig )
diff --git a/fpu/softfloat3c/s_normRoundPackToF64.c b/fpu/softfloat3c/s_normRoundPackToF64.c
index 4bac7a3b0d..c9eb533e84 100644
--- a/fpu/softfloat3c/s_normRoundPackToF64.c
+++ b/fpu/softfloat3c/s_normRoundPackToF64.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 float64_t
  softfloat_normRoundPackToF64( bool sign, int_fast16_t exp, uint_fast64_t sig )
diff --git a/fpu/softfloat3c/s_normSubnormalExtF80Sig.c b/fpu/softfloat3c/s_normSubnormalExtF80Sig.c
index 2df05601b8..d53293c08e 100644
--- a/fpu/softfloat3c/s_normSubnormalExtF80Sig.c
+++ b/fpu/softfloat3c/s_normSubnormalExtF80Sig.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 struct exp32_sig64 softfloat_normSubnormalExtF80Sig( uint_fast64_t sig )
 {
diff --git a/fpu/softfloat3c/s_normSubnormalF128Sig.c b/fpu/softfloat3c/s_normSubnormalF128Sig.c
index c1bb4b63c7..6b8774febd 100644
--- a/fpu/softfloat3c/s_normSubnormalF128Sig.c
+++ b/fpu/softfloat3c/s_normSubnormalF128Sig.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 struct exp32_sig128
  softfloat_normSubnormalF128Sig( uint_fast64_t sig64, uint_fast64_t sig0 )
diff --git a/fpu/softfloat3c/s_normSubnormalF128SigM.c b/fpu/softfloat3c/s_normSubnormalF128SigM.c
index dbc08268e8..5be9ed46fb 100644
--- a/fpu/softfloat3c/s_normSubnormalF128SigM.c
+++ b/fpu/softfloat3c/s_normSubnormalF128SigM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 int softfloat_normSubnormalF128SigM( uint32_t *sigPtr )
 {
diff --git a/fpu/softfloat3c/s_normSubnormalF16Sig.c b/fpu/softfloat3c/s_normSubnormalF16Sig.c
index d694833426..cfea0dddfa 100644
--- a/fpu/softfloat3c/s_normSubnormalF16Sig.c
+++ b/fpu/softfloat3c/s_normSubnormalF16Sig.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 struct exp8_sig16 softfloat_normSubnormalF16Sig( uint_fast16_t sig )
 {
diff --git a/fpu/softfloat3c/s_normSubnormalF32Sig.c b/fpu/softfloat3c/s_normSubnormalF32Sig.c
index 9a668f964d..c4150ba532 100644
--- a/fpu/softfloat3c/s_normSubnormalF32Sig.c
+++ b/fpu/softfloat3c/s_normSubnormalF32Sig.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 struct exp16_sig32 softfloat_normSubnormalF32Sig( uint_fast32_t sig )
 {
diff --git a/fpu/softfloat3c/s_normSubnormalF64Sig.c b/fpu/softfloat3c/s_normSubnormalF64Sig.c
index 3970d16b1e..0ffc2f86ce 100644
--- a/fpu/softfloat3c/s_normSubnormalF64Sig.c
+++ b/fpu/softfloat3c/s_normSubnormalF64Sig.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 struct exp16_sig64 softfloat_normSubnormalF64Sig( uint_fast64_t sig )
 {
diff --git a/fpu/softfloat3c/s_remStepMBy32.c b/fpu/softfloat3c/s_remStepMBy32.c
index 7f62dbaccb..2766d8c173 100644
--- a/fpu/softfloat3c/s_remStepMBy32.c
+++ b/fpu/softfloat3c/s_remStepMBy32.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_remStepMBy32
 
diff --git a/fpu/softfloat3c/s_roundMToI64.c b/fpu/softfloat3c/s_roundMToI64.c
index 034ede19c7..ef5f5168ef 100644
--- a/fpu/softfloat3c/s_roundMToI64.c
+++ b/fpu/softfloat3c/s_roundMToI64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t
  softfloat_roundMToI64(
diff --git a/fpu/softfloat3c/s_roundMToUI64.c b/fpu/softfloat3c/s_roundMToUI64.c
index 49b50358ff..4475ce5537 100644
--- a/fpu/softfloat3c/s_roundMToUI64.c
+++ b/fpu/softfloat3c/s_roundMToUI64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t
  softfloat_roundMToUI64(
diff --git a/fpu/softfloat3c/s_roundPackMToExtF80M.c b/fpu/softfloat3c/s_roundPackMToExtF80M.c
index ad13d40302..5acba81ca1 100644
--- a/fpu/softfloat3c/s_roundPackMToExtF80M.c
+++ b/fpu/softfloat3c/s_roundPackMToExtF80M.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void
  softfloat_roundPackMToExtF80M(
diff --git a/fpu/softfloat3c/s_roundPackMToF128M.c b/fpu/softfloat3c/s_roundPackMToF128M.c
index 9ebaa8aef5..7ee2f483cb 100644
--- a/fpu/softfloat3c/s_roundPackMToF128M.c
+++ b/fpu/softfloat3c/s_roundPackMToF128M.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 void
  softfloat_roundPackMToF128M(
diff --git a/fpu/softfloat3c/s_roundPackToExtF80.c b/fpu/softfloat3c/s_roundPackToExtF80.c
index 77b9135d8f..e0dc1841ff 100644
--- a/fpu/softfloat3c/s_roundPackToExtF80.c
+++ b/fpu/softfloat3c/s_roundPackToExtF80.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t
  softfloat_roundPackToExtF80(
diff --git a/fpu/softfloat3c/s_roundPackToF128.c b/fpu/softfloat3c/s_roundPackToF128.c
index 1783917f2a..fc7285bbdf 100644
--- a/fpu/softfloat3c/s_roundPackToF128.c
+++ b/fpu/softfloat3c/s_roundPackToF128.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t
  softfloat_roundPackToF128(
diff --git a/fpu/softfloat3c/s_roundPackToF16.c b/fpu/softfloat3c/s_roundPackToF16.c
index 670e613d47..c4c70d7aa5 100644
--- a/fpu/softfloat3c/s_roundPackToF16.c
+++ b/fpu/softfloat3c/s_roundPackToF16.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t
  softfloat_roundPackToF16( bool sign, int_fast16_t exp, uint_fast16_t sig )
diff --git a/fpu/softfloat3c/s_roundPackToF32.c b/fpu/softfloat3c/s_roundPackToF32.c
index 26a80b1c29..11ddd62df4 100644
--- a/fpu/softfloat3c/s_roundPackToF32.c
+++ b/fpu/softfloat3c/s_roundPackToF32.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t
  softfloat_roundPackToF32( bool sign, int_fast16_t exp, uint_fast32_t sig )
diff --git a/fpu/softfloat3c/s_roundPackToF64.c b/fpu/softfloat3c/s_roundPackToF64.c
index d03b4367e4..a081f6d62c 100644
--- a/fpu/softfloat3c/s_roundPackToF64.c
+++ b/fpu/softfloat3c/s_roundPackToF64.c
@@ -37,8 +37,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t
  softfloat_roundPackToF64( bool sign, int_fast16_t exp, uint_fast64_t sig )
diff --git a/fpu/softfloat3c/s_roundToI32.c b/fpu/softfloat3c/s_roundToI32.c
index 8ac6628912..6fd62dc3af 100644
--- a/fpu/softfloat3c/s_roundToI32.c
+++ b/fpu/softfloat3c/s_roundToI32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast32_t
  softfloat_roundToI32(
diff --git a/fpu/softfloat3c/s_roundToI64.c b/fpu/softfloat3c/s_roundToI64.c
index 1719cd4464..f6d11e69ef 100644
--- a/fpu/softfloat3c/s_roundToI64.c
+++ b/fpu/softfloat3c/s_roundToI64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 int_fast64_t
  softfloat_roundToI64(
diff --git a/fpu/softfloat3c/s_roundToUI32.c b/fpu/softfloat3c/s_roundToUI32.c
index 415277c98f..4a5fb644bd 100644
--- a/fpu/softfloat3c/s_roundToUI32.c
+++ b/fpu/softfloat3c/s_roundToUI32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast32_t
  softfloat_roundToUI32(
diff --git a/fpu/softfloat3c/s_roundToUI64.c b/fpu/softfloat3c/s_roundToUI64.c
index 4758a11cf6..e19cd548aa 100644
--- a/fpu/softfloat3c/s_roundToUI64.c
+++ b/fpu/softfloat3c/s_roundToUI64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 uint_fast64_t
  softfloat_roundToUI64(
diff --git a/fpu/softfloat3c/s_shiftLeftM.c b/fpu/softfloat3c/s_shiftLeftM.c
index ad8463644b..de1ae41ce9 100644
--- a/fpu/softfloat3c/s_shiftLeftM.c
+++ b/fpu/softfloat3c/s_shiftLeftM.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_shiftLeftM
 
 #define softfloat_shiftLeftM softfloat_shiftLeftM
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 void
  softfloat_shiftLeftM(
diff --git a/fpu/softfloat3c/s_shiftNormSigF128M.c b/fpu/softfloat3c/s_shiftNormSigF128M.c
index dbc35da326..a0d816f3d7 100644
--- a/fpu/softfloat3c/s_shiftNormSigF128M.c
+++ b/fpu/softfloat3c/s_shiftNormSigF128M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 
 int
  softfloat_shiftNormSigF128M(
diff --git a/fpu/softfloat3c/s_shiftRightJam128.c b/fpu/softfloat3c/s_shiftRightJam128.c
index 0f2d1c1fc1..74b64d4773 100644
--- a/fpu/softfloat3c/s_shiftRightJam128.c
+++ b/fpu/softfloat3c/s_shiftRightJam128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shiftRightJam128
 
diff --git a/fpu/softfloat3c/s_shiftRightJam128Extra.c b/fpu/softfloat3c/s_shiftRightJam128Extra.c
index 5576ec3af2..f66e693eab 100644
--- a/fpu/softfloat3c/s_shiftRightJam128Extra.c
+++ b/fpu/softfloat3c/s_shiftRightJam128Extra.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shiftRightJam128Extra
 
diff --git a/fpu/softfloat3c/s_shiftRightJam256M.c b/fpu/softfloat3c/s_shiftRightJam256M.c
index 9ad5ebb074..bfabccb3a5 100644
--- a/fpu/softfloat3c/s_shiftRightJam256M.c
+++ b/fpu/softfloat3c/s_shiftRightJam256M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shiftRightJam256M
 
diff --git a/fpu/softfloat3c/s_shiftRightJam64Extra.c b/fpu/softfloat3c/s_shiftRightJam64Extra.c
index 69be3f80a1..e52b1a7d83 100644
--- a/fpu/softfloat3c/s_shiftRightJam64Extra.c
+++ b/fpu/softfloat3c/s_shiftRightJam64Extra.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shiftRightJam64Extra
 
diff --git a/fpu/softfloat3c/s_shiftRightJamM.c b/fpu/softfloat3c/s_shiftRightJamM.c
index ff540995b1..47ba5ddaf9 100644
--- a/fpu/softfloat3c/s_shiftRightJamM.c
+++ b/fpu/softfloat3c/s_shiftRightJamM.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_shiftRightJamM
 
 #define softfloat_shiftRightJamM softfloat_shiftRightJamM
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 void
  softfloat_shiftRightJamM(
diff --git a/fpu/softfloat3c/s_shiftRightM.c b/fpu/softfloat3c/s_shiftRightM.c
index 19a6375f0e..a4662dc407 100644
--- a/fpu/softfloat3c/s_shiftRightM.c
+++ b/fpu/softfloat3c/s_shiftRightM.c
@@ -40,7 +40,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef softfloat_shiftRightM
 
 #define softfloat_shiftRightM softfloat_shiftRightM
-#include "primitives.h"
+#include "fpu/softfloat3c/primitives.h"
 
 void
  softfloat_shiftRightM(
diff --git a/fpu/softfloat3c/s_shortShiftLeft128.c b/fpu/softfloat3c/s_shortShiftLeft128.c
index 9bd6da5bfc..7c46ec39ec 100644
--- a/fpu/softfloat3c/s_shortShiftLeft128.c
+++ b/fpu/softfloat3c/s_shortShiftLeft128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftLeft128
 
diff --git a/fpu/softfloat3c/s_shortShiftLeft64To96M.c b/fpu/softfloat3c/s_shortShiftLeft64To96M.c
index 1d48ff73e6..971067b26e 100644
--- a/fpu/softfloat3c/s_shortShiftLeft64To96M.c
+++ b/fpu/softfloat3c/s_shortShiftLeft64To96M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftLeft64To96M
 
diff --git a/fpu/softfloat3c/s_shortShiftLeftM.c b/fpu/softfloat3c/s_shortShiftLeftM.c
index aaecf89549..54d7938756 100644
--- a/fpu/softfloat3c/s_shortShiftLeftM.c
+++ b/fpu/softfloat3c/s_shortShiftLeftM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftLeftM
 
diff --git a/fpu/softfloat3c/s_shortShiftRight128.c b/fpu/softfloat3c/s_shortShiftRight128.c
index e56e6256cc..8a51091eeb 100644
--- a/fpu/softfloat3c/s_shortShiftRight128.c
+++ b/fpu/softfloat3c/s_shortShiftRight128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRight128
 
diff --git a/fpu/softfloat3c/s_shortShiftRightExtendM.c b/fpu/softfloat3c/s_shortShiftRightExtendM.c
index 0c16176df3..c130c0a556 100644
--- a/fpu/softfloat3c/s_shortShiftRightExtendM.c
+++ b/fpu/softfloat3c/s_shortShiftRightExtendM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRightExtendM
 
diff --git a/fpu/softfloat3c/s_shortShiftRightJam128.c b/fpu/softfloat3c/s_shortShiftRightJam128.c
index a0b4480d45..d29077249b 100644
--- a/fpu/softfloat3c/s_shortShiftRightJam128.c
+++ b/fpu/softfloat3c/s_shortShiftRightJam128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRightJam128
 
diff --git a/fpu/softfloat3c/s_shortShiftRightJam128Extra.c b/fpu/softfloat3c/s_shortShiftRightJam128Extra.c
index c64331b304..50d92b6174 100644
--- a/fpu/softfloat3c/s_shortShiftRightJam128Extra.c
+++ b/fpu/softfloat3c/s_shortShiftRightJam128Extra.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRightJam128Extra
 
diff --git a/fpu/softfloat3c/s_shortShiftRightJam64Extra.c b/fpu/softfloat3c/s_shortShiftRightJam64Extra.c
index 0406f363f8..9d0b6c7b19 100644
--- a/fpu/softfloat3c/s_shortShiftRightJam64Extra.c
+++ b/fpu/softfloat3c/s_shortShiftRightJam64Extra.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRightJam64Extra
 
diff --git a/fpu/softfloat3c/s_shortShiftRightJamM.c b/fpu/softfloat3c/s_shortShiftRightJamM.c
index 6822d4ebf6..b351cf4881 100644
--- a/fpu/softfloat3c/s_shortShiftRightJamM.c
+++ b/fpu/softfloat3c/s_shortShiftRightJamM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRightJamM
 
diff --git a/fpu/softfloat3c/s_shortShiftRightM.c b/fpu/softfloat3c/s_shortShiftRightM.c
index bf099c7646..2c00140238 100644
--- a/fpu/softfloat3c/s_shortShiftRightM.c
+++ b/fpu/softfloat3c/s_shortShiftRightM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_shortShiftRightM
 
diff --git a/fpu/softfloat3c/s_sub128.c b/fpu/softfloat3c/s_sub128.c
index 8372cfc743..b0c83fa998 100644
--- a/fpu/softfloat3c/s_sub128.c
+++ b/fpu/softfloat3c/s_sub128.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_sub128
 
diff --git a/fpu/softfloat3c/s_sub1XM.c b/fpu/softfloat3c/s_sub1XM.c
index 775e8a05d6..b5515a8772 100644
--- a/fpu/softfloat3c/s_sub1XM.c
+++ b/fpu/softfloat3c/s_sub1XM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_sub1XM
 
diff --git a/fpu/softfloat3c/s_sub256M.c b/fpu/softfloat3c/s_sub256M.c
index 8edfa1e5bb..71f8073a14 100644
--- a/fpu/softfloat3c/s_sub256M.c
+++ b/fpu/softfloat3c/s_sub256M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_sub256M
 
diff --git a/fpu/softfloat3c/s_subM.c b/fpu/softfloat3c/s_subM.c
index 3b45e6e793..6eb2cc082b 100644
--- a/fpu/softfloat3c/s_subM.c
+++ b/fpu/softfloat3c/s_subM.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "primitiveTypes.h"
+#include "fpu/softfloat3c/primitiveTypes.h"
 
 #ifndef softfloat_subM
 
diff --git a/fpu/softfloat3c/s_subMagsExtF80.c b/fpu/softfloat3c/s_subMagsExtF80.c
index 22fa6ae243..90644319a7 100644
--- a/fpu/softfloat3c/s_subMagsExtF80.c
+++ b/fpu/softfloat3c/s_subMagsExtF80.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t
  softfloat_subMagsExtF80(
diff --git a/fpu/softfloat3c/s_subMagsF128.c b/fpu/softfloat3c/s_subMagsF128.c
index b308774b2a..49487ab953 100644
--- a/fpu/softfloat3c/s_subMagsF128.c
+++ b/fpu/softfloat3c/s_subMagsF128.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t
  softfloat_subMagsF128(
diff --git a/fpu/softfloat3c/s_subMagsF16.c b/fpu/softfloat3c/s_subMagsF16.c
index af38564787..cbfeb02f07 100644
--- a/fpu/softfloat3c/s_subMagsF16.c
+++ b/fpu/softfloat3c/s_subMagsF16.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t softfloat_subMagsF16( uint_fast16_t uiA, uint_fast16_t uiB )
 {
diff --git a/fpu/softfloat3c/s_subMagsF32.c b/fpu/softfloat3c/s_subMagsF32.c
index 21d5a55e89..569c008758 100644
--- a/fpu/softfloat3c/s_subMagsF32.c
+++ b/fpu/softfloat3c/s_subMagsF32.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t softfloat_subMagsF32( uint_fast32_t uiA, uint_fast32_t uiB )
 {
diff --git a/fpu/softfloat3c/s_subMagsF64.c b/fpu/softfloat3c/s_subMagsF64.c
index b048831082..cd6d17aeda 100644
--- a/fpu/softfloat3c/s_subMagsF64.c
+++ b/fpu/softfloat3c/s_subMagsF64.c
@@ -37,9 +37,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t
  softfloat_subMagsF64( uint_fast64_t uiA, uint_fast64_t uiB, bool signZ )
diff --git a/fpu/softfloat3c/s_tryPropagateNaNExtF80M.c b/fpu/softfloat3c/s_tryPropagateNaNExtF80M.c
index 0bc0eeb823..3919543a31 100644
--- a/fpu/softfloat3c/s_tryPropagateNaNExtF80M.c
+++ b/fpu/softfloat3c/s_tryPropagateNaNExtF80M.c
@@ -36,7 +36,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdbool.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
 
 bool
diff --git a/fpu/softfloat3c/s_tryPropagateNaNF128M.c b/fpu/softfloat3c/s_tryPropagateNaNF128M.c
index 81131419d8..aef360a8cc 100644
--- a/fpu/softfloat3c/s_tryPropagateNaNF128M.c
+++ b/fpu/softfloat3c/s_tryPropagateNaNF128M.c
@@ -37,7 +37,7 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #include <stdbool.h>
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
 
 bool
diff --git a/fpu/softfloat3c/softfloat_state.c b/fpu/softfloat3c/softfloat_state.c
index 20a8aa91bc..5a8daeeeb1 100644
--- a/fpu/softfloat3c/softfloat_state.c
+++ b/fpu/softfloat3c/softfloat_state.c
@@ -36,9 +36,9 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
 #include "specialize.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifndef THREAD_LOCAL
 #define THREAD_LOCAL
diff --git a/fpu/softfloat3c/ui32_to_extF80.c b/fpu/softfloat3c/ui32_to_extF80.c
index a7b4696d94..8a94880dc0 100644
--- a/fpu/softfloat3c/ui32_to_extF80.c
+++ b/fpu/softfloat3c/ui32_to_extF80.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t ui32_to_extF80( uint32_t a )
 {
diff --git a/fpu/softfloat3c/ui32_to_extF80M.c b/fpu/softfloat3c/ui32_to_extF80M.c
index 75c0502706..f464e3cb58 100644
--- a/fpu/softfloat3c/ui32_to_extF80M.c
+++ b/fpu/softfloat3c/ui32_to_extF80M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/ui32_to_f128.c b/fpu/softfloat3c/ui32_to_f128.c
index a48043a31d..11b9a0fa33 100644
--- a/fpu/softfloat3c/ui32_to_f128.c
+++ b/fpu/softfloat3c/ui32_to_f128.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t ui32_to_f128( uint32_t a )
 {
diff --git a/fpu/softfloat3c/ui32_to_f128M.c b/fpu/softfloat3c/ui32_to_f128M.c
index b2ff91fe17..a4d3d4e948 100644
--- a/fpu/softfloat3c/ui32_to_f128M.c
+++ b/fpu/softfloat3c/ui32_to_f128M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/ui32_to_f16.c b/fpu/softfloat3c/ui32_to_f16.c
index 61f5c95158..cbd159c34e 100644
--- a/fpu/softfloat3c/ui32_to_f16.c
+++ b/fpu/softfloat3c/ui32_to_f16.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t ui32_to_f16( uint32_t a )
 {
diff --git a/fpu/softfloat3c/ui32_to_f32.c b/fpu/softfloat3c/ui32_to_f32.c
index 8ac9018c4d..f67522c079 100644
--- a/fpu/softfloat3c/ui32_to_f32.c
+++ b/fpu/softfloat3c/ui32_to_f32.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t ui32_to_f32( uint32_t a )
 {
diff --git a/fpu/softfloat3c/ui32_to_f64.c b/fpu/softfloat3c/ui32_to_f64.c
index 4056a59ae7..4632cd14c4 100644
--- a/fpu/softfloat3c/ui32_to_f64.c
+++ b/fpu/softfloat3c/ui32_to_f64.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t ui32_to_f64( uint32_t a )
 {
diff --git a/fpu/softfloat3c/ui64_to_extF80.c b/fpu/softfloat3c/ui64_to_extF80.c
index 4170022954..be7029dad4 100644
--- a/fpu/softfloat3c/ui64_to_extF80.c
+++ b/fpu/softfloat3c/ui64_to_extF80.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 extFloat80_t ui64_to_extF80( uint64_t a )
 {
diff --git a/fpu/softfloat3c/ui64_to_extF80M.c b/fpu/softfloat3c/ui64_to_extF80M.c
index 7e8d53c3c9..5d6f4a6057 100644
--- a/fpu/softfloat3c/ui64_to_extF80M.c
+++ b/fpu/softfloat3c/ui64_to_extF80M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/ui64_to_f128.c b/fpu/softfloat3c/ui64_to_f128.c
index 22943f81ed..0fc2f828fd 100644
--- a/fpu/softfloat3c/ui64_to_f128.c
+++ b/fpu/softfloat3c/ui64_to_f128.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float128_t ui64_to_f128( uint64_t a )
 {
diff --git a/fpu/softfloat3c/ui64_to_f128M.c b/fpu/softfloat3c/ui64_to_f128M.c
index 23efc5a8a1..16cc2c9159 100644
--- a/fpu/softfloat3c/ui64_to_f128M.c
+++ b/fpu/softfloat3c/ui64_to_f128M.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 #ifdef SOFTFLOAT_FAST_INT64
 
diff --git a/fpu/softfloat3c/ui64_to_f16.c b/fpu/softfloat3c/ui64_to_f16.c
index 76b374b472..8f179a4747 100644
--- a/fpu/softfloat3c/ui64_to_f16.c
+++ b/fpu/softfloat3c/ui64_to_f16.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float16_t ui64_to_f16( uint64_t a )
 {
diff --git a/fpu/softfloat3c/ui64_to_f32.c b/fpu/softfloat3c/ui64_to_f32.c
index 4b8f4df370..d0c4a7b415 100644
--- a/fpu/softfloat3c/ui64_to_f32.c
+++ b/fpu/softfloat3c/ui64_to_f32.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float32_t ui64_to_f32( uint64_t a )
 {
diff --git a/fpu/softfloat3c/ui64_to_f64.c b/fpu/softfloat3c/ui64_to_f64.c
index a737c62551..154884e5bb 100644
--- a/fpu/softfloat3c/ui64_to_f64.c
+++ b/fpu/softfloat3c/ui64_to_f64.c
@@ -36,8 +36,8 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 #include <stdint.h>
 #include "platform.h"
-#include "fpu/softfloat3c/softfloat-internals.h"
-#include "softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+#include "fpu/softfloat3c/softfloat.h"
 
 float64_t ui64_to_f64( uint64_t a )
 {
-- 
2.13.0
