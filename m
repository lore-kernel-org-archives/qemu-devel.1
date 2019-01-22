Received: from eggs.gnu.org ([209.51.188.92]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1nL-0007pl-TQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1ix-0000hX-4s
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:28:39 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1iw-0000ft-VT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:28:39 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so18429817oif.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-10-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:30:13 +0000
Message-ID: <CAFEAcA-PxLRviCkjpyOX6Vv32Z1voNsBHgRYxcGQVAHrepJNrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/11] target/arm: Enable BTI for -cpu max
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

On Thu, 10 Jan 2019 at 12:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 713d2d5579..64fbe75eca 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -372,6 +372,10 @@ static void aarch64_max_initfn(Object *obj)
>          t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
>          cpu->isar.id_aa64pfr0 = t;
>
> +        t = cpu->isar.id_aa64pfr1;
> +        t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
> +        cpu->isar.id_aa64pfr1 = t;
> +
>          t = cpu->isar.id_aa64mmfr1;
>          t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
>          t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
