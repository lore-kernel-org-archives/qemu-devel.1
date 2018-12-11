Received: from eggs.gnu.org ([2001:4830:134:3::10]:42737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWkDv-00008F-LI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWkDu-0006iQ-UP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:45:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWkDu-0006iA-P1
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:45:26 -0500
Received: by mail-ot1-x341.google.com with SMTP id 81so14463353otj.2
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-25-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:45:14 +0000
Message-ID: <CAFEAcA_rYiGZN=hXBYWbMhu-rH86xJAreHkpisz=zKUfa773SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 24/26] target/arm: Enable PAuth for
 user-only -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:37, Richard Henderson
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
>          t = cpu->isar.id_aa64pfr0;

I don't see why this is enabling for user-only and
not also for system: what am I missing ?

thanks
-- PMM
