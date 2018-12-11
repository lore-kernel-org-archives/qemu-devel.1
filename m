Received: from eggs.gnu.org ([2001:4830:134:3::10]:39929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWkA2-00052N-5z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk9z-0003sT-8z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:41:24 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWk9u-0003nm-PD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:41:20 -0500
Received: by mail-ot1-x343.google.com with SMTP id t5so14467332otk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-15-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:41:04 +0000
Message-ID: <CAFEAcA_A0fshRFunzjj6Qj4BQBk--UeDkRbRr61SL6TKLxbrdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/26] target/arm: Move cpu_mmu_index out
 of line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This function is, or will shortly become, too big to inline.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 48 +++++----------------------------------------
>  target/arm/helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 43 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
