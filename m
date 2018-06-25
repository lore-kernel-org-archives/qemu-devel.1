Received: from eggs.gnu.org ([2001:4830:134:3::10]:42712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTMG-0001oj-Sf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTMG-0007Dc-5f
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:24:48 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTMG-0007DT-0Q
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:24:48 -0400
Received: by mail-ot0-x241.google.com with SMTP id i17-v6so4615822otl.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:24:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-7-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:24:26 +0100
Message-ID: <CAFEAcA9qFjrPKi_QuGivw_dE-f7uWZ2Tkj6v=naE=7-_xAoKYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 06/35] target/arm: Implement SVE
 floating-point arithmetic (predicated)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 77 +++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 89 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 46 ++++++++++++++++++++
>  target/arm/sve.decode      | 17 ++++++++
>  4 files changed, 229 insertions(+)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
