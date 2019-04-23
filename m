Received: from eggs.gnu.org ([209.51.188.92]:44222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzq6-0006Bg-Js
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzq4-0005Wm-M2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:08:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIzq3-0005Vn-13
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:08:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so7887889pfo.5
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:08:14 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42db75fd-84a8-eb45-b1e7-d64c3201440d@linaro.org>
Date: Tue, 23 Apr 2019 11:08:10 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/26] target/arm: Disable most VFP sysregs
 for M-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The only "system register" that M-profile floating point exposes
> via the VMRS/VMRS instructions is FPSCR, and it does not have
> the odd special case for rd==15. Add a check to ensure we only
> expose FPSCR.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
