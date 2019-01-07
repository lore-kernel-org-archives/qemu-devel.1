Received: from eggs.gnu.org ([209.51.188.92]:56791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVk0-000655-Vy
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVk0-00018M-Af
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:18:56 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggVk0-00016I-5i
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:18:56 -0500
Received: by mail-oi1-x242.google.com with SMTP id w13so393245oiw.9
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-26-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:18:43 +0000
Message-ID: <CAFEAcA-vVFjgyiJmZz8O8tmr7=Gn_aN35r0srExyka8zMvoLLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 25/27] target/arm: Enable PAuth for -cpu
 max
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 1d57be0c91..84f70b2a24 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -316,6 +316,10 @@ static void aarch64_max_initfn(Object *obj)
>
>          t = cpu->isar.id_aa64isar1;
>          t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
> +        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
>          cpu->isar.id_aa64isar1 = t;
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
