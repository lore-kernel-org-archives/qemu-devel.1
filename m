Received: from eggs.gnu.org ([2001:4830:134:3::10]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUrie-0006i9-Sg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUrie-0002Fh-1J
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:49:08 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fUrid-0002FH-RL
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:49:07 -0400
Received: by mail-oi0-x242.google.com with SMTP id k190-v6so14372092oib.9
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 03:49:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <be965630-767c-4721-6239-474f61a08e6e@mail.ru>
References: <20180612204632.28780-1-jusual@mail.ru>
	<CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
	<826808f0-4dc4-261d-4c54-46c807bb75c9@linaro.org>
	<CAFEAcA9BVi_yzA6wPjrE62mdd21d9QtVixc1OvB9PWLN2ydq+A@mail.gmail.com>
	<be965630-767c-4721-6239-474f61a08e6e@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Jun 2018 11:48:46 +0100
Message-ID: <CAFEAcA95CxL+S8X4FLU7HGhonucDnvSogA3D3smir3rWi-nnEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>

On 17 June 2018 at 19:48, Julia Suvorova <jusual@mail.ru> wrote:
> I can make it if you wish.
> In addition, we can simplify following "if" by removing ARM_FEATURE_V6
> since V7M and V8M define V6:
>
>     if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
>         !(arm_dc_feature(s, ARM_FEATURE_V6) &&
>           arm_dc_feature(s, ARM_FEATURE_M))) {
>         goto illegal_op;
>     }
>
> Like this:
>
>     if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
>         !arm_dc_feature(s, ARM_FEATURE_M)) {
>         goto illegal_op;
>     }
>
> What do you think?

Yes; that would be reasonable. I did consider making that
change when I applied the patch, but decided I didn't really
care much either way. So if you want to send a patch for it
that's fine; if you don't, that's also fine.

thanks
-- PMM
