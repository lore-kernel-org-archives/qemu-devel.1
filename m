Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIF1g-0000Ei-Ka
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIF1f-0007Gu-OV
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:04:36 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:46661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIF1f-0007Ga-KT
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:04:35 -0400
Received: by mail-ot0-x230.google.com with SMTP id t1-v6so14630390ott.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:04:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:04:14 +0100
Message-ID: <CAFEAcA-Q9+sNcbA8YS+So-LASryU-p70jbEHWAwn0p0Ty=Mpug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/27] softfloat patch roundup
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

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
> This is my SNaN patch set, Alex's float-float refactor, and a couple
> of other random outstanding fpu patches.  This has been reordered so
> as to be bisectable, since the float-float refactor requires the snan
> work to avoid breakage.
>
> It probably doesn't matter, but this was built on top of my arm fp16
> patch set simply to make it easier to test.  The whole tree is
>
>   git://github.com/rth7680/qemu.git fpu-roundup

I've added patches 1, 2, and 15 to target-arm.next:
>   fpu/softfloat: int_to_float ensure r fully initialised
>   fpu/softfloat: Don't set Invalid for float-to-int(MAXINT)
>   target/arm: Fix fp_status_f16 tininess before rounding

thanks
-- PMM
