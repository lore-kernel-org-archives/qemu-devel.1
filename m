Received: from eggs.gnu.org ([2001:4830:134:3::10]:42422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYUJb-0001Ee-Th
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYUJb-0000gW-2w
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:38:15 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYUJa-0000em-SE
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:38:14 -0400
Received: by mail-oi0-x241.google.com with SMTP id r16-v6so4206142oie.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 03:38:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627043328.11531-14-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 11:37:53 +0100
Message-ID: <CAFEAcA8Yfarg8juu_MJmDruYmsCsb6Y8fAxFS-wtw6dcDypteA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 13/35] target/arm: Implement SVE gather
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 June 2018 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v6:
>   * Finish esz == msz && u==1 decode in sve.decode.
>   * Remove duplicate decode in trans_ST1_zprz.
>   * Add xs=2 comment.
>   * Reformat tables to leave room for ff helpers.
> ---
>  target/arm/helper-sve.h    |  67 +++++++++++++++++++++++++
>  target/arm/sve_helper.c    |  77 ++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 100 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  57 +++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
