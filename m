Received: from eggs.gnu.org ([2001:4830:134:3::10]:37961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBlS-0008Is-AP
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBlR-0001NA-Jy
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:43:46 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:43974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epBlR-0001Me-Eg
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:43:45 -0500
Received: by mail-pf0-x230.google.com with SMTP id z14so3404684pfe.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 03:43:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8h-Y8_zDL1mQuZTarMqWo9LwDgvgwEmpPbmYLfBvtRyw@mail.gmail.com>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-4-richard.henderson@linaro.org>
	<CAFEAcA8h-Y8_zDL1mQuZTarMqWo9LwDgvgwEmpPbmYLfBvtRyw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 11:43:24 +0000
Message-ID: <CAFEAcA9T-sqz740ux0YfhM357-BS6ONs4cYX_iMiy0NLzM1yWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 03/67] target/arm: Add SVE
 decode skeleton
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

On 23 February 2018 at 11:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> I realized while working through the rest of the series that this is
> too early to do the sve_access_check() and fp_access_check(). Those
> only apply to instructions which actually exist, so we mustn't
> do the checks until after we've dealt with all the unallocated_encoding()
> cases. I think you need to push them down inside disas_sve() somehow.
> See also my comments on patch 8.

...I meant "patch 9".

-- PMM
