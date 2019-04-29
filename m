Received: from eggs.gnu.org ([209.51.188.92]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6WG-0005a8-1D
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6WF-0001Hc-4P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:31 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6WC-0001Er-GE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:30 -0400
Received: by mail-ot1-x341.google.com with SMTP id f23so8583475otl.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-4-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:40:13 +0100
Message-ID: <CAFEAcA8q2ZTvFco28XTqgfMq9LQDJg6m9Dq98Y+N2xKYR1zJqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 03/36] tcg: Create struct CPUTLB
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

On Thu, 28 Mar 2019 at 23:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move all softmmu tlb data into this structure.  Arrange the
> members so that we are able to place mask+table together and
> at a smaller absolute offset from ENV.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
