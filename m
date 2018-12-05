Received: from eggs.gnu.org ([2001:4830:134:3::10]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWPv-0005g9-GY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWPs-0002bu-Ak
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:36:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUWPs-0002bF-2j
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:36:36 -0500
Received: by mail-wr1-x432.google.com with SMTP id r10so19488543wrs.10
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:36:35 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-14-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-14-cota@braap.org>
Date: Wed, 05 Dec 2018 12:36:33 +0000
Message-ID: <8736rc2lri.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 13/13] hardfloat: implement float32/64
 comparison
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

> Performance results for fp-bench:
>
> Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
> - before:
> cmp-single: 110.98 MFlops
> cmp-double: 107.12 MFlops
> - after:
> cmp-single: 506.28 MFlops
> cmp-double: 524.77 MFlops
>
> Note that flattening both eq and eq_signaling versions
> would give us extra performance (695v506, 615v524 Mflops
> for single/double, respectively) but this would emit two
> essentially identical functions for each eq/signaling pair,
> which is a waste.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
