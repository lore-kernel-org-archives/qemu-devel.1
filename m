Received: from eggs.gnu.org ([2001:4830:134:3::10]:39263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGouh-0002sP-G6
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGoug-0008CI-Il
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:59:31 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGoug-0008C0-El
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:59:30 -0400
Received: by mail-ot0-x242.google.com with SMTP id m11-v6so3087274otf.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 09:59:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502221552.3873-12-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
	<20180502221552.3873-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 17:59:09 +0100
Message-ID: <CAFEAcA9fa4-DMgxMFGrOYgB6eMYGvLupyKS_LNp+vez7xGRKNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/14] target/arm: Implement FCMP for
 fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 2 May 2018 at 23:15, Richard Henderson <richard.henderson@linaro.org> wr=
ote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> These where missed out from the rest of the half-precision work.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> [rth: Diagnose lack of FP16 before fp_access_check]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h    |  2 ++
>  target/arm/helper-a64.c    | 10 ++++++
>  target/arm/translate-a64.c | 88 +++++++++++++++++++++++++++++++++++++---=
------
>  3 files changed, 83 insertions(+), 17 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
