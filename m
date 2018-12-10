Received: from eggs.gnu.org ([2001:4830:134:3::10]:57003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMmn-0001sm-TX
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMmk-0003kx-3O
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:43:52 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWMmg-0003gU-RZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:43:48 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so9114398oie.10
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 06:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20181206175541.29508-1-richard.henderson@linaro.org>
	<20181206175541.29508-3-richard.henderson@linaro.org>
In-Reply-To: <20181206175541.29508-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 14:43:33 +0000
Message-ID: <CAFEAcA_rgsgduSsvND3DKLwAXdoMxDzEepgKjrV9J3Mxaqgc0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] target/arm: Use arm_hcr_el2_eff
 more places
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

On Thu, 6 Dec 2018 at 17:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since arm_hcr_el2_eff includes a check against
> arm_is_secure_below_el3, we can often remove a
> nearby check against secure state.
>
> In some cases, sort the call to arm_hcr_el2_eff
> to the end of a short-circuit logical sequence.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Do not change regime_translation_disabled.
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
