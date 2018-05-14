Received: from eggs.gnu.org ([2001:4830:134:3::10]:55597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEkC-0006j4-OV
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEkB-0006TZ-Vi
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:46:32 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEkB-0006TV-R4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:46:31 -0400
Received: by mail-ot0-x244.google.com with SMTP id l13-v6so14567790otk.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:46:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-26-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:46:10 +0100
Message-ID: <CAFEAcA_oTOJbpQdy=ehrZ1Djp6XhotpXM3Qaxfc13ax3tEPtdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 25/27] fpu/softfloat: Make is_nan et al
 available to softfloat-specialize.h
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
> We will need these helpers within softfloat-specialize.h, so move
> the definitions above the include.  After specialization, they will
> not always be used so mark them to avoid the Werror.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 15a272759d..bafb3b17ec 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -181,6 +181,22 @@ typedef enum __attribute__ ((__packed__)) {
>      float_class_snan,
>  } FloatClass;
>
> +/* Simple helpers for checking if what NaN we have */

"if/what" (ditto below).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
