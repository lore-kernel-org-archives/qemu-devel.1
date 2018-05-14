Received: from eggs.gnu.org ([2001:4830:134:3::10]:36788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAdg-0003ri-Go
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAdf-0007VU-PZ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:23:32 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAdf-0007VD-LN
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:23:31 -0400
Received: by mail-ot0-x241.google.com with SMTP id t1-v6so13617781ott.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:23:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-5-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:23:10 +0100
Message-ID: <CAFEAcA_LmCJGU7CQb8Mv5UucBauprVTBtDHn2c_Y7vH1=YxD0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/27] fpu/softfloat: Split
 floatXX_silence_nan from floatXX_maybe_silence_nan
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

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> The new function assumes that the input is an SNaN and
> does not double-check.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 174 +++++++++++++++++++++++++------------
>  include/fpu/softfloat.h    |   5 ++
>  2 files changed, 123 insertions(+), 56 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
