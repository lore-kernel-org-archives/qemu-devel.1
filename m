Received: from eggs.gnu.org ([2001:4830:134:3::10]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrdE-0007kL-9x
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrd9-0007HA-K0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:15:48 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUrd9-0007Fw-Ef
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:15:43 -0500
Received: by mail-ot1-x344.google.com with SMTP id v23so39158otk.9
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 03:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-3-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 11:15:30 +0000
Message-ID: <CAFEAcA-TT6AkKXiJnHjtW+VMuMCyXMC3PAho0pJ66VpECvifbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/10] target/arm: Add HCR_EL2 bits up
 to ARMv8.5
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

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Post v8.3 bits taken from SysReg_v85_xml-00bet8.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 656a96a8f8..79d58978f7 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1249,7 +1249,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>  #define HCR_TIDCP     (1ULL << 20)
>  #define HCR_TACR      (1ULL << 21)
>  #define HCR_TSW       (1ULL << 22)
> -#define HCR_TPC       (1ULL << 23)
> +#define HCR_TPCP      (1ULL << 23)

We were using "TPC" here because that's what the 32-bit HCR
register names the bit; but standardizing on the 64-bit HCR_EL2
names makes sense.

thanks
-- PMM
