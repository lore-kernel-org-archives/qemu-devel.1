Received: from eggs.gnu.org ([2001:4830:134:3::10]:47817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWlIF-0003ty-32
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWlIB-0006rH-2m
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:53:58 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWlIA-0006pQ-Rs
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:53:54 -0500
Received: by mail-oi1-x243.google.com with SMTP id t204so12546428oie.7
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-19-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 16:53:42 +0000
Message-ID: <CAFEAcA9Hz0oDKL4FWUGrg38whuOYUer7bfDETWmF6XE987JFcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 18/26] target/arm: Export
 aa64_va_parameters to internals.h
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

On Fri, 7 Dec 2018 at 10:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We need to reuse this from helper-a64.c.  Provide a stub
> definition for CONFIG_USER_ONLY.  This matches the stub
> definitions that we removed for arm_regime_tbi{0,1} before.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 29 +++++++++++++++++++++++++++++
>  target/arm/helper.c    | 16 ++--------------
>  2 files changed, 31 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
