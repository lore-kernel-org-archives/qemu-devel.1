Received: from eggs.gnu.org ([209.51.188.92]:53891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grngM-0001zt-94
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grngK-0003Bs-AU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:41:50 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grngD-00034M-B3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:41:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so1270449otk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-11-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:41:14 +0000
Message-ID: <CAFEAcA-mZ01Za4SA92ZABGsfHJ+C=zZgLbDYMMxVoTWqUEaiQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/17] target/arm: Implement LDG, STG,
 ST2G instructions
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

On Mon, 14 Jan 2019 at 01:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h    |   3 ++
>  target/arm/mte_helper.c    |  53 +++++++++++++++++++
>  target/arm/translate-a64.c | 106 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
>

I'm going to skip review of this one, since it will need
updating for the STG/LDG spec change.

thanks
-- PMM
