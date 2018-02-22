Received: from eggs.gnu.org ([2001:4830:134:3::10]:33070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotfy-000679-U9
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotfy-0000MS-4g
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:54 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eotfx-0000Kj-W5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:54 -0500
Received: by mail-ot0-x242.google.com with SMTP id e64so5115584ote.4
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 08:24:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216215608.13227-4-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 16:24:33 +0000
Message-ID: <CAFEAcA-ZdRT+qUz8NDrHfFwFF3pKA3QuzcWbc9TgUuFJgrALRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] aarch64-linux-user: Remove struct
 target_aux_context
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

On 16 February 2018 at 21:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This changes the qemu signal frame layout to be more like the kernel's,
> in that the various records are dynamically allocated rather than fixed
> in place by a structure.
>
> For now, all of the allocation is out of uc.tuc_mcontext.__reserved,
> so the allocation is actually trivial.  That will change with SVE support.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
