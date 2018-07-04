Received: from eggs.gnu.org ([2001:4830:134:3::10]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faiZ7-0005xW-9z
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faiZ3-0006fL-5K
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:15:29 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faiZ2-0006f2-M6
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:15:24 -0400
Received: by mail-wm0-x243.google.com with SMTP id s14-v6so5921471wmc.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 07:15:24 -0700 (PDT)
References: <20180703151732.29843-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180703151732.29843-1-richard.henderson@linaro.org>
Date: Wed, 04 Jul 2018 15:15:22 +0100
Message-ID: <87y3er84ud.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, programmingkidx@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au


Richard Henderson <richard.henderson@linaro.org> writes:

>
> Anyway, all of this has been broken long enough that it'll need to
> wait til next devel cycle before anything further gets done.

When it gets done should we add some explicit ppc tests to tests/tcg/ppc
like we did with arm64 fcvt or would it be worth spending more time on
the general purpose FP test suite Emilio was working on as part of his
hard-float series?

>
>
> r~
>
>
> Richard Henderson (7):
>   target/ppc: Enable fp exceptions for user-only
>   target/ppc: Honor fpscr_ze semantics and tidy fdiv
>   target/ppc: Tidy helper_fmul
>   target/ppc: Tidy helper_fadd, helper_fsub
>   target/ppc: Tidy helper_fsqrt
>   target/ppc: Honor fpscr_ze semantics and tidy fre, fresqrt
>   target/ppc: Use non-arithmetic conversions for fp load/store
>
>  target/ppc/helper.h                |  14 +-
>  target/ppc/fpu_helper.c            | 294 +++++++++++++++++------------
>  target/ppc/translate/fp-impl.inc.c |  26 +--
>  target/ppc/translate_init.inc.c    |   2 +
>  4 files changed, 189 insertions(+), 147 deletions(-)


--
Alex Benn=C3=A9e
