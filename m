Received: from eggs.gnu.org ([209.51.188.92]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPq1-0001iV-6Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPeW-00044s-AE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:06:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPeS-00041O-Qm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:06:18 -0400
Received: by mail-ot1-x341.google.com with SMTP id t20so11380259otl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-23-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:06:03 +0100
Message-ID: <CAFEAcA_jBgEvFTnSu_KMHD6Ofnr05DvX6mTZD1x7-jhdi8sdJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 22/26] target/unicore32: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On Wed, 3 Apr 2019 at 04:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/unicore32/cpu.h       |  5 +++--
>  target/unicore32/cpu.c       |  5 +----
>  target/unicore32/helper.c    | 23 -----------------------
>  target/unicore32/op_helper.c | 14 --------------
>  target/unicore32/softmmu.c   | 19 +++++++++++++++----
>  5 files changed, 19 insertions(+), 47 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

You might note in the commit message that we can just delete
the user-mode (non-)handling of tlb fill because we
don't support unicore32 linux-user any more.

thanks
-- PMM
