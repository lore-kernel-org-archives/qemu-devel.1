Received: from eggs.gnu.org ([2001:4830:134:3::10]:45937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIB9o-0008PX-0W
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIB9n-00086W-7E
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:56:44 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIB9n-00086C-2M
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:56:43 -0400
Received: by mail-oi0-x241.google.com with SMTP id p62-v6so10228979oie.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:56:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-10-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:56:22 +0100
Message-ID: <CAFEAcA-zpU26D42tHMSyJjdhB7uFP2aLm0UE9XeeUFHd=HJmrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/27] fpu/softfloat: Replace
 float_class_msnan with parts_silence_nan
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
> With a canonical representation of NaNs, we can silence an SNaN
> immediately rather than delay until the final format is known.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 23 ++++++++++++++++++++++
>  fpu/softfloat.c            | 40 ++++++++++----------------------------
>  2 files changed, 33 insertions(+), 30 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
