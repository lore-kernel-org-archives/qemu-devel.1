Received: from eggs.gnu.org ([2001:4830:134:3::10]:58317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEsM-0004yi-Iw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEsL-0001aZ-SM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:54:58 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEsL-0001aB-OD
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:54:57 -0400
Received: by mail-oi0-x241.google.com with SMTP id a6-v6so10943882oia.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:54:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-28-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:54:36 +0100
Message-ID: <CAFEAcA-5QUgb0uDQKevdjvdXv0jTci0PGKXf2--6s-rqDF8G+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 27/27] fpu/softfloat: Pass FloatClass to
 pickNaNMulAdd
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

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> For each operand, pass a single enumeration instead of a pair of booleans.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 70 +++++++++++++++-----------------------
>  fpu/softfloat.c            |  5 +--
>  2 files changed, 28 insertions(+), 47 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
