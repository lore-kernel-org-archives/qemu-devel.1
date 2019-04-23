Received: from eggs.gnu.org ([209.51.188.92]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3Ff-0005lK-Qj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3Fe-0000Nq-Pt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:46:55 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:42393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ3Fe-0000Lj-Hi
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:46:54 -0400
Received: by mail-pg1-x529.google.com with SMTP id p6so8253314pgh.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:46:54 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11425be6-f1ec-e707-9a81-eb0ed9362551@linaro.org>
Date: Tue, 23 Apr 2019 14:46:50 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/26] target/arm/helper: don't return
 early for STKOF faults during stacking
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
> Currently the code in v7m_push_stack() which detects a violation
> of the v8M stack limit simply returns early if it does so. This
> is OK for the current integer-only code, but won't work for the
> floating point handling we're about to add. We need to continue
> executing the rest of the function so that we check for other
> exceptions like not having permission to use the FPU and so
> that we correctly set the FPCCR state if we are doing lazy
> stacking. Refactor to avoid the early return.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
