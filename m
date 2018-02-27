Received: from eggs.gnu.org ([2001:4830:134:3::10]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfiM-0007Qx-VC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfiM-0005Mb-6M
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:43 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfiM-0005MH-1N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:42 -0500
Received: by mail-ot0-x22a.google.com with SMTP id w2so1252941otg.2
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:54:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-50-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-50-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:54:20 +0000
Message-ID: <CAFEAcA8AJTKy750C+Gy0Lhz0Wrr_4H7Miu84nzCeE-Ex68EuqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 49/67] target/arm: Implement
 SVE FP Multiply-Add Group
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 16 ++++++++++++++
>  target/arm/sve_helper.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 41 +++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 17 +++++++++++++++
>  4 files changed, 127 insertions(+)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
