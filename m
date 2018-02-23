Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFBl-0002eY-UG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epFBl-0002kR-6C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:23:09 -0500
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:38497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epFBk-0002k9-W5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:23:09 -0500
Received: by mail-pf0-x233.google.com with SMTP id d26so3636237pfn.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:23:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-30-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 15:22:47 +0000
Message-ID: <CAFEAcA93H77dHU8fEc0=O=6hyF-sLkv_Vw0=9uhjYBBgpv7sZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 29/67] target/arm: Implement
 SVE Permute - Interleaving Group
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 15 ++++++++++
>  target/arm/sve_helper.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 10 +++++++
>  4 files changed, 166 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
