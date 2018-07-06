Received: from eggs.gnu.org ([2001:4830:134:3::10]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbOE7-0004iH-9t
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbOE6-0002HV-GH
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:44:35 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbOE6-0002F2-Bt
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:44:34 -0400
Received: by mail-oi0-x242.google.com with SMTP id k81-v6so22625867oib.4
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 03:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705191929.30773-1-richard.henderson@linaro.org>
References: <20180705191929.30773-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 11:44:13 +0100
Message-ID: <CAFEAcA8B6Y56h=LCX+NWp_7nAjXfhd80AC=kWEnbN4LYb_AhQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: SVE fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 5 July 2018 at 20:19, Richard Henderson <richard.henderson@linaro.org> wrote:
> RISU testing with ARM Fast Models and VQ=16 showed up two bugs,
> both affecting the PTRUE instruction.
>
>
> r~
>
>
> Richard Henderson (2):
>   tcg: Restrict check_size_impl to multiples of the line size
>   target/arm: Fix do_predset for large VL
>
>  target/arm/translate-sve.c | 10 ++--------
>  tcg/tcg-op-gvec.c          |  7 +++++--
>  2 files changed, 7 insertions(+), 10 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
