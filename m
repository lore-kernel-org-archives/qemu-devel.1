Received: from eggs.gnu.org ([2001:4830:134:3::10]:51010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUuDf-0000Ch-Pe
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUu2v-0006yL-Ai
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:50:35 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUu2v-0006xV-3X
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:50:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id e12so441924otl.5
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-7-richard.henderson@linaro.org>
	<CAFEAcA9-jB-RhEPb4CnnrCZ9y+SWu_1Ec6GYw7dyQyrVi3fd7w@mail.gmail.com>
	<f5e828de-24d5-73a2-27e3-dac101926faa@linaro.org>
In-Reply-To: <f5e828de-24d5-73a2-27e3-dac101926faa@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 13:50:17 +0000
Message-ID: <CAFEAcA_Az1yj=b6cJ92LmMsdaR-SeZqSSscUJ3+TubVOM0tv+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/10] target/arm: Use arm_hcr_el2_eff
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

On Thu, 6 Dec 2018 at 13:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/6/18 7:06 AM, Peter Maydell wrote:
> > Changing this in this function makes me nervous, because
> > arm_hcr_el2_eff() looks at the current CPU state via
> > arm_is_secure_below_el3() rather than at the security state
> > of the translation regime we're asking about. I think
> > it probably doesn't change behaviour, but I'm finding
> > it hard to reason about...
>
> Oops, I missed that we weren't talking about "current" here.
>
> I can either just revert this function for now, or introduce a new
> arm_hcr_el2_eff_ns that does not take secure into effect, but does adjust all
> of the other flags within HCR relative to its own contents.

I think I'd just not change this function.

thanks
-- PMM
