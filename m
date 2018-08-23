Received: from eggs.gnu.org ([2001:4830:134:3::10]:48938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssAB-0002mw-RA
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssAB-0001xR-6F
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:08:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssAA-0001wu-Ut
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:08:47 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so10151341oie.13
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:08:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-18-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:08:25 +0100
Message-ID: <CAFEAcA-YhMDpTEoac2aW=Z-HYtaSe03=LtR1P8CvogDa4PKMDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/20] target/arm: Rewrite vector gather
 loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This fixes the endianness problem for softmmu, and does
> move the main loop out of a macro and into an inlined function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  84 +++++++++----
>  target/arm/sve_helper.c    | 218 +++++++++++++++++++++++----------
>  target/arm/translate-sve.c | 244 +++++++++++++++++++++++++------------
>  3 files changed, 380 insertions(+), 166 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
