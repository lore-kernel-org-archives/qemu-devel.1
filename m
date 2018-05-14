Received: from eggs.gnu.org ([2001:4830:134:3::10]:57902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEqs-00069q-HU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEqr-0000lM-UM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:53:26 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEqr-0000lB-PU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:53:25 -0400
Received: by mail-ot0-x241.google.com with SMTP id n3-v6so14594225ota.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:53:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-27-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:53:04 +0100
Message-ID: <CAFEAcA9ULhcXDacLgM4GrmWBycRX4Dzg6oqPCovkHjTnqqV4Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 26/27] fpu/softfloat: Pass FloatClass to
 pickNaN
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
>  fpu/softfloat-specialize.h | 168 ++++++++++++++++++-------------------
>  fpu/softfloat.c            |   3 +-
>  2 files changed, 82 insertions(+), 89 deletions(-)

The commit also merges multiple different ifdef-selected implementations
of pickNaN into a single function whose body is ifdef-selected.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
