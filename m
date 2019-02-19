Received: from eggs.gnu.org ([209.51.188.92]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8xv-00013Z-Ub
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8xp-00040T-GU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:13:50 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw8xe-0003pu-Sz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:13:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id z19so35507552otm.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-9-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 17:13:13 +0000
Message-ID: <CAFEAcA-0SrtsyH2GFPQT84LOxY4wd49YQgnxA7E87dU0WgpRig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 8/8] target/arm: Enable ARMv8.2-FHM for
 -cpu max
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

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c   | 1 +
>  target/arm/cpu64.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8ea6569088..b9fa548718 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2003,6 +2003,7 @@ static void arm_max_initfn(Object *obj)
>              t = cpu->isar.id_isar6;
>              t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
>              t = FIELD_DP32(t, ID_ISAR6, DP, 1);
> +            t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
>              cpu->isar.id_isar6 = t;
>
>              t = cpu->id_mmfr4;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 69e4134f79..1b0c427277 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -308,6 +308,7 @@ static void aarch64_max_initfn(Object *obj)
>          t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);
>          t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
>          t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
>          cpu->isar.id_aa64isar0 = t;
>
>          t = cpu->isar.id_aa64isar1;
> @@ -347,6 +348,7 @@ static void aarch64_max_initfn(Object *obj)
>          u = cpu->isar.id_isar6;
>          u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
>          u = FIELD_DP32(u, ID_ISAR6, DP, 1);
> +        u = FIELD_DP32(u, ID_ISAR6, FHM, 1);
>          cpu->isar.id_isar6 = u;
>
>          /*

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

We also need to set the HWCAP_ASIMDFHM and HWCAP_JSCVT hwcaps
for linux-user based on the ID regs, but we can do that as
an extra patch on top of this set.

thanks
-- PMM
