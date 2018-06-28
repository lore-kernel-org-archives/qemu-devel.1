Received: from eggs.gnu.org ([2001:4830:134:3::10]:44419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWMc-0001RA-9v
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWMb-0004yD-Ik
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:49:30 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:37218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYWMb-0004xP-E5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:49:29 -0400
Received: by mail-ot0-x235.google.com with SMTP id q11-v6so3766904otk.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 05:49:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627043328.11531-6-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 13:49:08 +0100
Message-ID: <CAFEAcA8a6AkKB=x5YUyS9WBCK4gB9Na2n4byeiuAbOgTt9bfnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 05/35] target/arm: Implement SVE integer
 convert to floating-point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 June 2018 at 05:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 30 +++++++++++++
>  target/arm/sve_helper.c    | 38 ++++++++++++++++
>  target/arm/translate-sve.c | 90 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 22 ++++++++++
>  4 files changed, 180 insertions(+)
>


> +
> +/*
> + *** SVE Floating Point Unary Operations Prediated Group
> + */
> +

just noticed this typo in the context for a later patch:
should be "Predicated".

thanks
-- PMM
