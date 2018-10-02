Received: from eggs.gnu.org ([2001:4830:134:3::10]:37313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HtU-0003KZ-JJ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HtT-0003MG-TS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:27:08 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HtR-0003Jk-Aa
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:27:07 -0400
Received: by mail-oi1-x243.google.com with SMTP id j68-v6so1068930oib.7
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:27:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926192323.12659-8-richard.henderson@linaro.org>
References: <20180926192323.12659-1-richard.henderson@linaro.org>
	<20180926192323.12659-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:26:41 +0100
Message-ID: <CAFEAcA8WErCMXvJPAFfBk5_HuFsZRpzc9tjFGydLwJYhxOjrGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/15] target/arm: Rewrite
 helper_sve_ld1*_r using pages
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

On 26 September 2018 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Uses tlb_vaddr_to_host for correct operation with softmmu.
> Optimize for accesses within a single page or pair of pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
