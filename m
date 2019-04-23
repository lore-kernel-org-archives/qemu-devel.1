Received: from eggs.gnu.org ([209.51.188.92]:52443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ00z-00024L-4Z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ00v-0008Fp-5V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:19:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ00u-0008DU-V4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:19:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id e24so7880748pfi.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:19:27 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5f58c94-3122-9c65-6f6f-18d19acbad8d@linaro.org>
Date: Tue, 23 Apr 2019 11:19:23 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/26] target/arm: Honour M-profile FP
 enable bits
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
> Like AArch64, M-profile floating point has no FPEXC enable
> bit to gate floating point; so always set the VFPEN TB flag.
> 
> M-profile also has CPACR and NSACR similar to A-profile;
> they behave slightly differently:
>  * the CPACR is banked between Secure and Non-Secure
>  * if the NSACR forces a trap then this is taken to
>    the Secure state, not the Non-Secure state
> 
> Honour the CPACR and NSACR settings. The NSACR handling
> requires us to borrow the exception.target_el field
> (usually meaningless for M profile) to distinguish the
> NOCP UsageFault taken to Secure state from the more
> usual fault taken to the current security state.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c    | 55 +++++++++++++++++++++++++++++++++++++++---
>  target/arm/translate.c | 10 ++++++--
>  2 files changed, 60 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
