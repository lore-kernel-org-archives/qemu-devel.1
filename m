Received: from eggs.gnu.org ([2001:4830:134:3::10]:48155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUshF-0001b7-Tl
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUsV1-0002MV-CI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:11:24 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUsV0-0002LD-S7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:11:23 -0500
Received: by mail-oi1-x244.google.com with SMTP id j21so158580oii.8
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-5-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 12:11:07 +0000
Message-ID: <CAFEAcA_Dt=Mv7jAt_80=pb_TyTcKKaiNg5LV6xgkqyz0NPTKWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 04/10] target/arm: Fix HCR_EL2.TGE check
 in arm_phys_excp_target_el
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
> The enable for TGE has already occurred within arm_hcr_el2_amo
> and friends.  Moreover, when E2H is also set, the sense is
> supposed to be reversed, which has also already occurred within
> the helpers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
