Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHlKg-000415-FI
	for qemu-devel@nongnu.org; Sun, 13 May 2018 03:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHlKd-0001dw-AE
	for qemu-devel@nongnu.org; Sun, 13 May 2018 03:22:14 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fHlKd-0001dd-43
	for qemu-devel@nongnu.org; Sun, 13 May 2018 03:22:11 -0400
Received: by mail-wr0-x241.google.com with SMTP id q3-v6so9076450wrj.6
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 00:22:11 -0700 (PDT)
References: <20180512003217.9105-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180512003217.9105-1-richard.henderson@linaro.org>
Date: Sun, 13 May 2018 08:22:08 +0100
Message-ID: <87po20ow9r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/11] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Changes since v3:
>   * Fixup rebase vs target-arm.next.  One of the middle
>     patches had conflicts resolved incorrectly, so the
>     patch set was non-bisectable.

I've tested with the new RISU set:

 http://people.linaro.org/~alex.bennee/testcases/arm64.risu/testcases_aarch=
64_all_half.tar.xz

without any LD/ST opcodes on your rth/tgt-arm-fp16 branch

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Changes since v2:
>   * Rebased vs target-arm.next.
>   * Merged Peter's review.
>   * Split out return fix as a separate patch.
>
> Changes since v1:
>   * Rebased vs master instead of tgt-arm-sve-9.
>   * Alex did some additional digging through the ARM xhtml
>     and came up with some additional missing instructions.
>   * Everything cc'd to qemu-stable.
>
>
> r~
>
>
> Alex Benn=C3=A9e (4):
>   target/arm: Implement FCMP for fp16
>   target/arm: Implement FCSEL for fp16
>   target/arm: Implement FMOV (immediate) for fp16
>   target/arm: Fix sqrt_f16 exception raising
>
> Richard Henderson (7):
>   target/arm: Implement FMOV (general) for fp16
>   target/arm: Early exit after unallocated_encoding in disas_fp_int_conv
>   target/arm: Implement FCVT (scalar,integer) for fp16
>   target/arm: Implement FCVT (scalar,fixed-point) for fp16
>   target/arm: Introduce and use read_fp_hreg
>   target/arm: Implement FP data-processing (2 source) for fp16
>   target/arm: Implement FP data-processing (3 source) for fp16
>
>  target/arm/helper-a64.h    |   2 +
>  target/arm/helper.h        |   6 +
>  target/arm/helper-a64.c    |  10 +
>  target/arm/helper.c        |  38 +++-
>  target/arm/translate-a64.c | 421 +++++++++++++++++++++++++++++++------
>  5 files changed, 413 insertions(+), 64 deletions(-)


--
Alex Benn=C3=A9e
