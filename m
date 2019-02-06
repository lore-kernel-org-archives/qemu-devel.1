Received: from eggs.gnu.org ([209.51.188.92]:53058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grOs1-0003sc-MB
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grOs0-00061t-0R
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:12:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:35716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grOry-000610-VT
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:12:11 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z18so7203527wrh.2
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 07:12:09 -0800 (PST)
References: <20190206105339.32664-1-david@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <87ef8lneja.fsf@zen.linaroharston>
In-reply-to: <20190206105339.32664-1-david@redhat.com>
Date: Wed, 06 Feb 2019 15:12:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] softfloat: Implement float128_to_uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>


David Hildenbrand <david@redhat.com> writes:

> Handling it just like float128_to_uint32_round_to_zero, that hopefully
> is free of bugs :)
>
> Documentation basically copied from float128_to_uint64

Queued to fpu/next, thanks.

BTW to test:

tests/fp: add wrapping for f128_to_ui32

Needed to test: softfloat: add float128_is_{normal,denormal}

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

2 files changed, 3 insertions(+), 1 deletion(-)
tests/fp/fp-test.c  | 3 ++-
tests/fp/wrap.inc.c | 1 +

modified   tests/fp/fp-test.c
@@ -622,7 +622,8 @@ static void do_testfloat(int op, int rmode, bool exact)
         test_ab_extF80_z_bool(true_ab_extF80M_z_bool, subj_ab_extF80M_z_bo=
ol);
         break;
     case F128_TO_UI32:
-        not_implemented();
+        test_a_f128_z_ui32_rx(slow_f128M_to_ui32, qemu_f128M_to_ui32, rmod=
e,
+                              exact);
         break;
     case F128_TO_UI64:
         test_a_f128_z_ui64_rx(slow_f128M_to_ui64, qemu_f128M_to_ui64, rmod=
e,
modified   tests/fp/wrap.inc.c
@@ -367,6 +367,7 @@ WRAP_80_TO_INT_MINMAG(qemu_extF80M_to_i64_r_minMag,
 WRAP_128_TO_INT(qemu_f128M_to_i32, float128_to_int32, int_fast32_t)
 WRAP_128_TO_INT(qemu_f128M_to_i64, float128_to_int64, int_fast64_t)

+WRAP_128_TO_INT(qemu_f128M_to_ui32, float128_to_uint32, uint_fast32_t)
 WRAP_128_TO_INT(qemu_f128M_to_ui64, float128_to_uint64, uint_fast64_t)
 #undef WRAP_128_TO_INT

--
Alex Benn=C3=A9e
