Received: from eggs.gnu.org ([209.51.188.92]:48353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUIN-0003au-GL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUIL-0000FI-Is
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:34:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkUIJ-0008QS-4k
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:34:49 -0500
Received: by mail-oi1-x243.google.com with SMTP id w13so8936265oiw.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-2-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 13:34:13 +0000
Message-ID: <CAFEAcA9wu6Bth3g02wtTPP8kc8UFwjXzxoMvBXJ1jKQE9f5Oiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/31] target/arm: Add state for the
 ARMv8.3-PAuth extension
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
> Add storage space for the 5 encryption keys.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
> v2: Remove pointless double migration.
>     Use a struct to make it clear which half is which.

PS: if you use four-hyphens to separate the changelog from
the commit message then git am and other patch-applying scripts
don't recognize it and I have to strip the text out by hand...

thanks
-- PMM
