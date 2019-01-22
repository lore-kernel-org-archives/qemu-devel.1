Received: from eggs.gnu.org ([209.51.188.92]:44973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm13m-0003ac-4y
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm13g-0004WE-TT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:05 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm13f-00047G-Js
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:00 -0500
Received: by mail-oi1-x244.google.com with SMTP id y1so18257579oie.12
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-2-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 12:01:24 +0000
Message-ID: <CAFEAcA9v8JMGg3=DE_vqOv87B+atNJr=4cPOtXWNqAGH0O37MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/11] target/arm: Introduce
 isar_feature_aa64_bti
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

On Thu, 10 Jan 2019 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Also create field definitions for id_aa64pfr1 from ARMv8.5.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8512ca3552..fadb74d9a6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1630,6 +1630,9 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
>  FIELD(ID_AA64PFR0, RAS, 28, 4)
>  FIELD(ID_AA64PFR0, SVE, 32, 4)
>
> +FIELD(ID_AA64PFR1, BT, 0, 4)
> +FIELD(ID_AA64PFR1, SBSS, 4, 4)

You could add
FIELD(ID_AA64PFR1, MTE, 8, 4)
FIELD(ID_AA64PFR1, RAS_FRAC, 12, 4)

if you liked (from v8.5-MemTag and v8.4-RAS).

> +
>  FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
>  FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
>  FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
> @@ -3268,6 +3271,11 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
>  }
>
> +static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
> +}
> +
>  /*
>   * Forward to the above feature tests given an ARMCPU pointer.
>   */
> --
> 2.17.2

Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
