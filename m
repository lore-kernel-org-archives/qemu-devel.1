Received: from eggs.gnu.org ([2001:4830:134:3::10]:32927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erPBN-0004oq-LB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erPBM-00078P-St
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:27:41 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:35526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erPBM-00078E-ML
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:27:40 -0500
Received: by mail-oi0-x22f.google.com with SMTP id x10so4584967oig.2
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 06:27:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pUMgUnR0cWd9j7n0EyTeXkMTzhPQU_fqhyaXy1hMfxw@mail.gmail.com>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-13-richard.henderson@linaro.org>
	<CAFEAcA-pUMgUnR0cWd9j7n0EyTeXkMTzhPQU_fqhyaXy1hMfxw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 14:27:19 +0000
Message-ID: <CAFEAcA-+ZDFE6s7NYfkhcc8vxMD=R-3gt5gL1NPhr6gWX8pmoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/16] target/arm: Decode aa64 armv8.3
 fcmla
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

On 1 March 2018 at 13:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> Shouldn't there be a feature check on ARM_FEATURE_V8_FCMA somewhere
> in the three_reg_same_extra code path?

Oh, there is, because FCADD &c are also (feature bit name
notwithstanding) under that feature bit.


thanks
-- PMM
