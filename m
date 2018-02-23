Received: from eggs.gnu.org ([2001:4830:134:3::10]:53189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epGmh-0006lj-6S
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epGmd-0004FJ-T0
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:05:23 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epGmd-0004A4-Ii
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:05:19 -0500
Received: by mail-wr0-x243.google.com with SMTP id l43so14817337wrc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:05:19 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180217182323.25885-1-richard.henderson@linaro.org>
Date: Fri, 23 Feb 2018 17:05:17 +0000
Message-ID: <87606nab76.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/67] target/arm: Scalable
 Vector Extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This is 99% of the instruction set.  There are a few things missing,
> notably first-fault and non-fault loads (even these are decoded, but
> simply treated as normal loads for now).
>
> The patch set is dependant on at least 3 other branches.
> A fully composed tree is available as
>
>   git://github.com/rth7680/qemu.git tgt-arm-sve-7

Well now it's down just my half-precision patches because I was able to
apply this to my recently re-based against master arm-fp16-v3:

  https://github.com/stsquad/qemu/tree/review/sve-vectors-v2-rebase

>
> There are a few checkpatch errors due to macros and typedefs, but
> nothing that isn't be obvious as a false positive.
>
> This is able to run SVE enabled Himeno and LULESH benchmarks as
> compiled by last week's gcc-8:
>
> $ ./aarch64-linux-user/qemu-aarch64 ~/himeno-advsimd
> mimax =3D 129 mjmax =3D 65 mkmax =3D 65
> imax =3D 128 jmax =3D 64 kmax =3D64
> cpu : 67.028643 sec.
> Loop executed for 200 times
> Gosa : 1.688752e-03
> MFLOPS measured : 49.136295
> Score based on MMX Pentium 200MHz : 1.522662
>
> $ ./aarch64-linux-user/qemu-aarch64 ~/himeno-sve
> mimax =3D 129 mjmax =3D 65 mkmax =3D 65
> imax =3D 128 jmax =3D 64 kmax =3D64
> cpu : 43.481213 sec.
> Loop executed for 200 times
> Gosa : 3.830036e-06
> MFLOPS measured : 75.746259
> Score based on MMX Pentium 200MHz : 2.347266
>
> Hopefully the size of the patch set isn't too daunting...
>
>
> r~
>
>
> Richard Henderson (67):
>   target/arm: Enable SVE for aarch64-linux-user
>   target/arm: Introduce translate-a64.h
>   target/arm: Add SVE decode skeleton
>   target/arm: Implement SVE Bitwise Logical - Unpredicated Group
>   target/arm: Implement SVE load vector/predicate
>   target/arm: Implement SVE predicate test
>   target/arm: Implement SVE Predicate Logical Operations Group
>   target/arm: Implement SVE Predicate Misc Group
>   target/arm: Implement SVE Integer Binary Arithmetic - Predicated Group
>   target/arm: Implement SVE Integer Reduction Group
>   target/arm: Implement SVE bitwise shift by immediate (predicated)
>   target/arm: Implement SVE bitwise shift by vector (predicated)
>   target/arm: Implement SVE bitwise shift by wide elements (predicated)
>   target/arm: Implement SVE Integer Arithmetic - Unary Predicated Group
>   target/arm: Implement SVE Integer Multiply-Add Group
>   target/arm: Implement SVE Integer Arithmetic - Unpredicated Group
>   target/arm: Implement SVE Index Generation Group
>   target/arm: Implement SVE Stack Allocation Group
>   target/arm: Implement SVE Bitwise Shift - Unpredicated Group
>   target/arm: Implement SVE Compute Vector Address Group
>   target/arm: Implement SVE floating-point exponential accelerator
>   target/arm: Implement SVE floating-point trig select coefficient
>   target/arm: Implement SVE Element Count Group
>   target/arm: Implement SVE Bitwise Immediate Group
>   target/arm: Implement SVE Integer Wide Immediate - Predicated Group
>   target/arm: Implement SVE Permute - Extract Group
>   target/arm: Implement SVE Permute - Unpredicated Group
>   target/arm: Implement SVE Permute - Predicates Group
>   target/arm: Implement SVE Permute - Interleaving Group
>   target/arm: Implement SVE compress active elements
>   target/arm: Implement SVE conditionally broadcast/extract element
>   target/arm: Implement SVE copy to vector (predicated)
>   target/arm: Implement SVE reverse within elements
>   target/arm: Implement SVE vector splice (predicated)
>   target/arm: Implement SVE Select Vectors Group
>   target/arm: Implement SVE Integer Compare - Vectors Group
>   target/arm: Implement SVE Integer Compare - Immediate Group
>   target/arm: Implement SVE Partition Break Group
>   target/arm: Implement SVE Predicate Count Group
>   target/arm: Implement SVE Integer Compare - Scalars Group
>   target/arm: Implement FDUP/DUP
>   target/arm: Implement SVE Integer Wide Immediate - Unpredicated Group
>   target/arm: Implement SVE Floating Point Arithmetic - Unpredicated
>     Group
>   target/arm: Implement SVE Memory Contiguous Load Group
>   target/arm: Implement SVE Memory Contiguous Store Group
>   target/arm: Implement SVE load and broadcast quadword
>   target/arm: Implement SVE integer convert to floating-point
>   target/arm: Implement SVE floating-point arithmetic (predicated)
>   target/arm: Implement SVE FP Multiply-Add Group
>   target/arm: Implement SVE Floating Point Accumulating Reduction Group
>   target/arm: Implement SVE load and broadcast element
>   target/arm: Implement SVE store vector/predicate register
>   target/arm: Implement SVE scatter stores
>   target/arm: Implement SVE prefetches
>   target/arm: Implement SVE gather loads
>   target/arm: Implement SVE scatter store vector immediate
>   target/arm: Implement SVE floating-point compare vectors
>   target/arm: Implement SVE floating-point arithmetic with immediate
>   target/arm: Implement SVE Floating Point Multiply Indexed Group
>   target/arm: Implement SVE FP Fast Reduction Group
>   target/arm: Implement SVE Floating Point Unary Operations -
>     Unpredicated Group
>   target/arm: Implement SVE FP Compare with Zero Group
>   target/arm: Implement SVE floating-point trig multiply-add coefficient
>   target/arm: Implement SVE floating-point convert precision
>   target/arm: Implement SVE floating-point convert to integer
>   target/arm: Implement SVE floating-point round to integral value
>   target/arm: Implement SVE floating-point unary operations
>
>  target/arm/cpu.h           |    7 +-
>  target/arm/helper-sve.h    | 1285 ++++++++++++
>  target/arm/helper.h        |   42 +
>  target/arm/translate-a64.h |  110 ++
>  target/arm/cpu.c           |    7 +
>  target/arm/cpu64.c         |    1 +
>  target/arm/sve_helper.c    | 4051 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c |  112 +-
>  target/arm/translate-sve.c | 4626 ++++++++++++++++++++++++++++++++++++++=
++++++
>  target/arm/vec_helper.c    |  178 ++
>  .gitignore                 |    1 +
>  target/arm/Makefile.objs   |   12 +-
>  target/arm/sve.decode      | 1067 ++++++++++
>  13 files changed, 11408 insertions(+), 91 deletions(-)
>  create mode 100644 target/arm/helper-sve.h
>  create mode 100644 target/arm/translate-a64.h
>  create mode 100644 target/arm/sve_helper.c
>  create mode 100644 target/arm/translate-sve.c
>  create mode 100644 target/arm/vec_helper.c
>  create mode 100644 target/arm/sve.decode


--
Alex Benn=C3=A9e
