Received: from eggs.gnu.org ([2001:4830:134:3::10]:58382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTpE8-0001Sb-Fi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTpE5-0000Zl-Rr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:29:36 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTpE5-0000ZJ-Ll
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:29:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id z18so6058553wmc.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:29:33 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-7-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-7-cota@braap.org>
Date: Mon, 03 Dec 2018 14:29:31 +0000
Message-ID: <87mupm3cqc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/13] tests/fp: add fp-bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> These microbenchmarks will allow us to measure the performance impact of
> FP emulation optimizations. Note that we can measure both directly the im=
pact
> on the softfloat functions (with "-t soft"), or the impact on an
> emulated workload (call with "-t host" and run under qemu user-mode).

It would be nice to be able to cross-build this later so we can build
easily for non-x86. However no reason to hold things up for that:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +
> +/*
> + * The main benchmark function. Instead of (ab)using macros, we rely
> + * on the compiler to unfold this at compile-time.
> + */

\o/

--
Alex Benn=C3=A9e
