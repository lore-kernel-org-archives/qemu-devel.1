Received: from eggs.gnu.org ([209.51.188.92]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh0lz-00062U-J2
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh0ly-0003yu-Gb
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:27:03 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gh0ly-0003x6-9P
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:27:02 -0500
Received: by mail-oi1-x241.google.com with SMTP id r62so4853932oie.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 15:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-5-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 23:26:49 +0000
Message-ID: <CAFEAcA_YyTuuyTO-A_2n2wDFcSfBMZ8+suCrPbn9myKpHcbhHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 04/31] target/arm: Introduce
 raise_exception_ra
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

On Tue, 8 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This path uses cpu_loop_exit_restore to unwind current processor state.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h |  7 +++++++
>  target/arm/op_helper.c | 19 +++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
