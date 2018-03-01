Received: from eggs.gnu.org ([2001:4830:134:3::10]:33815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO17-00054n-RL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO16-00059F-Vl
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:13:01 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erO16-00058Z-QD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:13:00 -0500
Received: by mail-ot0-x241.google.com with SMTP id l5so5475827otf.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 05:13:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-3-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 13:12:39 +0000
Message-ID: <CAFEAcA_yW5DvBehZfec0jKvobiqL=pQxNBi2h0RbBvcA=HH5UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 02/16] target/arm: Refactor
 disas_simd_indexed decode
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

On 28 February 2018 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Include the U bit in the switches rather than testing separately.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 129 +++++++++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 68 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
