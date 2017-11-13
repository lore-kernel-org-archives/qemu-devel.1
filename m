Received: from eggs.gnu.org ([2001:4830:134:3::10]:55227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEIM3-0002d8-8K
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEILz-00073j-Su
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:17:03 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEILz-00073B-MB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:16:59 -0500
Received: by mail-wr0-x243.google.com with SMTP id u97so15107642wrc.1
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:16:59 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-1-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 17:16:57 +0000
Message-ID: <87mv3q9jzq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 00/12] ARM v8.1 simd + v8.3
 complex insns
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

> This patch set depends on v3 of native-vector-registers;
> for ease of review the whole tree is at
>
>   git://github.com/rth7680/qemu.git tgt-arm-cplx
>
> I have successfully tested all insns for AArch64 via RISU.
> I have successfully tested everything but VCMLA for AArch32.
>
> The insn that doesn't match up is
>
>   fef3c848  vcmla.f32  q14, <illegal reg q1.5>, d8[0], #270
>
> for which FoundationModel is *not* signalling illegal insn.
> I'm not really sure what it is doing -- perhaps treating the
> insn as a coprocessor 8 nop?  I'll have to investigate further.
>
> In the meantime, it's surely time for a round 1 review.

OK I'm done with round 1 review, I skipped past the later complex
instructions as I don't have access to the 8.3 ARM ARM yet (although the
instructions are in the ASL HTML dumps).

>
>
> r~
>
>
> Richard Henderson (12):
>   HACK: use objdump disas
>   target/arm: Add ARM_FEATURE_V8_1_SIMD
>   target/arm: Decode aa64 armv8.1 scalar three same extra
>   target/arm: Decode aa64 armv8.1 three same extra
>   target/arm: Decode aa64 armv8.1 scalar/vector x indexed element
>   target/arm: Decode aa32 armv8.1 three same
>   target/arm: Decode aa32 armv8.1 two reg and a scalar
>   target/arm: Add ARM_FEATURE_V8_FCMA
>   target/arm: Decode aa64 armv8.3 fcadd
>   target/arm: Decode aa64 armv8.3 fcmla
>   target/arm: Decode aa32 armv8.3 3-same
>   target/arm: Decode aa32 armv8.3 2-reg-index
>
>  target/arm/cpu.h            |   2 +
>  target/arm/helper.h         |  26 ++++
>  disas.c                     |   2 +-
>  linux-user/elfload.c        |  10 ++
>  target/arm/advsimd_helper.c | 331 ++++++++++++++++++++++++++++++++++++++=
+++
>  target/arm/cpu.c            |   2 +
>  target/arm/cpu64.c          |   2 +
>  target/arm/translate-a64.c  | 350 ++++++++++++++++++++++++++++++++++++++=
+-----
>  target/arm/translate.c      | 241 +++++++++++++++++++++++++++---
>  target/arm/Makefile.objs    |   2 +-
>  10 files changed, 912 insertions(+), 56 deletions(-)
>  create mode 100644 target/arm/advsimd_helper.c


--
Alex Benn=C3=A9e
