Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDpg-0002lI-O6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDpb-0005vC-3h
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:48:08 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:43456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIDpa-0005v4-V3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:48:03 -0400
Received: by mail-ot0-x244.google.com with SMTP id y10-v6so14293345otg.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:48:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-11-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 14:47:41 +0100
Message-ID: <CAFEAcA_B0NvRJ+JskPMnqjUXhwcKv8RQJ4qVJd=YqwhL2eoirw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/27] fpu/softfloat: re-factor float to
 float conversions
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
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This allows us to delete a lot of additional boilerplate code which is
> no longer needed. Currently the ieee flag is ignored (everything is
> assumed to be ieee). Handling for ARM AHP will be in the next patch.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2
>   - pass FloatFmt to float_to_float instead of sizes
>   - split AHP handling to another patch
>   - use rth's suggested re-packing (+ setting .exp)
> v3
>   - also rm extractFloat16Sign
> v4
>   - update for canonical nan handling
> ---
>  fpu/softfloat-specialize.h |  40 ----
>  include/fpu/softfloat.h    |   8 +-
>  fpu/softfloat.c            | 437 ++++++-------------------------------
>  3 files changed, 73 insertions(+), 412 deletions(-)

This is a regression if you put it at this point in the patch series,
because we don't yet have the patches which pass the fp status
and squash FZ16 in the arm helper wrappers before calling the softfloat
code. I think it needs to go after patches 13 and 14.

thanks
-- PMM
