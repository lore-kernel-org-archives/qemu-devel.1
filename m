Received: from eggs.gnu.org ([209.51.188.92]:52740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7lc-0008T3-RE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7lb-00015F-8O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:00:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7lb-00013n-3M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:00:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id a10so63716otl.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-37-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:00:14 +0100
Message-ID: <CAFEAcA-an2BRh+Ji0y-6P9e_3=Z22CDVSMJ1RAEXefa-MFZdFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 36/36] tcg/arm: Use LDRD to load
 tlb mask+table
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

On Thu, 28 Mar 2019 at 23:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/arm/tcg-target.inc.c | 109 +++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 57 deletions(-)

I think this would be easier to understand if the commit message
included what the old and new generated code fragments looked like.

(git diff seems to not have done a very good job of identifying
what's actually changed in this patch, unfortunately.)

The same remark about a compile-time check that mask and
table are where we expect from patch 35 applies here too.

thanks
-- PMM
