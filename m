Received: from eggs.gnu.org ([2001:4830:134:3::10]:41884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXgd-0007EE-4H
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXgX-0006KZ-Ku
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:00:07 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXgX-0006Jp-G7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:00:01 -0400
Received: by mail-oi0-x244.google.com with SMTP id t27-v6so13539404oij.9
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 04:00:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-24-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:59:40 +0100
Message-ID: <CAFEAcA8=TRh1=vm5CzDpuGBYRqfOziwcEAMxj0kdPmnwBGLuuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 23/28] fpu/softfloat: Make is_nan et al
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

On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> wrote:
> We will need these helpers within softfloat-specialize.h, so move
> the definitions above the include.  After specialization, they will
> not always be used so mark them to avoid the Werror.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
