Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SVh-0001Wu-Fk
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SVb-0007X2-JY
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:59:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SVb-0007WA-3m
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:59:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id s12-v6so2350851wmc.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:59:18 -0700 (PDT)
References: <20181004175700.20847-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181004175700.20847-1-richard.henderson@linaro.org>
Date: Fri, 05 Oct 2018 16:59:16 +0100
Message-ID: <87lg7cqt9n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Changes from v2:
>   * Add shift128Left.  I had been using shortShift128Left,
>     with a shift of 64, which lead to undefined behaviour.
>     Which I suspect is exactly the Heisenbug Alex saw.

No weirdness this time around

>
>     I did keep the R-b tags I had already applied.

You already have mine but this version also:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
> r~
>
>
> Richard Henderson (4):
>   softfloat: Fix division
>   softfloat: Specialize udiv_qrnnd for x86_64
>   softfloat: Specialize udiv_qrnnd for s390x
>   softfloat: Specialize udiv_qrnnd for ppc64
>
>  include/fpu/softfloat-macros.h | 62 +++++++++++++++++++++++++++++-----
>  fpu/softfloat.c                | 35 ++++++++++++++-----
>  2 files changed, 80 insertions(+), 17 deletions(-)


--
Alex Benn=C3=A9e
