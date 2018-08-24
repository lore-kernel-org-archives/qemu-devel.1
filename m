Received: from eggs.gnu.org ([2001:4830:134:3::10]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDLC-00013S-04
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDLB-0003x3-9w
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:45:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDLA-0003wQ-US
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:45:33 -0400
Received: by mail-oi0-x241.google.com with SMTP id l82-v6so10115128oih.11
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:45:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824141428.27268-1-richard.henderson@linaro.org>
References: <20180824141428.27268-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 15:45:11 +0100
Message-ID: <CAFEAcA-Se-MF2-h=SP_m74WzyzssPz=8Da-yDAzs5Yi4_BKxuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix cpu_get_tb_cpu_flags vs
 !sve
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

On 24 August 2018 at 15:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Not only are the sve-related tb_flags fields unused when SVE is
> disabled, but not all of the cpu registers are initialized properly
> for computing same.  This can corrupt other fields by oring in -1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Your version is better than mine as it conditionalises the
sve_el flags field too.

thanks
-- PMM
