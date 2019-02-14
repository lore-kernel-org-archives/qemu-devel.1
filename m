Received: from eggs.gnu.org ([209.51.188.92]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guJco-0001z1-72
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guJcn-0007A6-LS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:12:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guJcn-00079T-G6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:12:33 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so11350949otk.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20190209033847.9014-1-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 16:12:20 +0000
Message-ID: <CAFEAcA8B7NHaUcF2Zw=6_a7hHPmAWtCeEP5LjkGeaWCGCf1S5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/12] target/arm: tcg vector cleanups
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

On Sat, 9 Feb 2019 at 03:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes since v2:
>   * Fix some representational issues with FPSCR.
>   * Use host vector saturation for SQADD/UQADD.
>     This requires changing the internal representation of FPSR.QC.
>   * Fix a latent vector bug, noticed during the rest.
>
> Correct RISU results depend on Mark C-A's patch from today,
> "tcg/i386: fix unsigned vector saturating arithmetic",
> which will be in my next tcg pull.
>

Applied to target-arm.next, thanks. (That tcg fix is in
master now.)

-- PMM
