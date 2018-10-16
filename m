Received: from eggs.gnu.org ([2001:4830:134:3::10]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMkP-00083R-HX
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMkO-0003OS-T4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:38:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMkO-0003M6-Ml
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:38:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id w81-v6so17607424oiw.9
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:38:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008212205.17752-2-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
	<20181008212205.17752-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:38:23 +0100
Message-ID: <CAFEAcA_wOFF8V7ONOJ9mpvL92KFONfGie+TO=gYixikcuEnZXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/10] target/arm: Fix
 aarch64_sve_change_el wrt EL0
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

On 8 October 2018 at 22:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> At present we assert:
>
>   arm_el_is_aa64: Assertion `el >= 1 && el <= 3' failed.
>
> The comment in arm_el_is_aa64 explains why asking about EL0 without
> extra information is impossible.  Add an extra argument to provide
> it from the surrounding context.
>
> Fixes: 0ab5953b00b3
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
