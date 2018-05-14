Received: from eggs.gnu.org ([2001:4830:134:3::10]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAbR-00026i-Ro
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAbR-0006HO-2I
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:21:13 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAbQ-0006H4-Tl
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:21:12 -0400
Received: by mail-oi0-x243.google.com with SMTP id k5-v6so10189367oiw.0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:21:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-4-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:20:52 +0100
Message-ID: <CAFEAcA-vyAxAOzYHC05OOkrBz5QzyrrTrHk1s8LnJyZm4Hd=6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/27] fpu/softfloat: Merge
 NO_SIGNALING_NANS definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> Move the ifdef inside the relevant functions instead of
> duplicating the function declarations.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 100 +++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 60 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
