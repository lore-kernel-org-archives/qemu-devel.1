Received: from eggs.gnu.org ([2001:4830:134:3::10]:54877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epCvZ-0003hI-JG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epCvY-0008OB-VK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:58:17 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epCvY-0008NM-Ol
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:58:16 -0500
Received: by mail-pf0-x244.google.com with SMTP id s24so3484857pfm.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 04:58:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-14-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 12:57:54 +0000
Message-ID: <CAFEAcA9VrN4qwOJ8ch2tkRURQOEngSSEzTP5vAT5JcAf9LA9cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 13/67] target/arm: Implement SVE bitwise
 shift by wide elements (predicated)
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
>  target/arm/helper-sve.h    | 21 +++++++++++++++++++++
>  target/arm/sve_helper.c    | 35 +++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 25 +++++++++++++++++++++++++
>  target/arm/sve.decode      |  6 ++++++
>  4 files changed, 87 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
