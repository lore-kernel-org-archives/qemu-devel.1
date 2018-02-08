Received: from eggs.gnu.org ([2001:4830:134:3::10]:37985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejnHn-0001Js-Gk
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejnHh-0006mi-VW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:34:51 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:41161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejnHh-0006lt-QC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:34:45 -0500
Received: by mail-oi0-x229.google.com with SMTP id m83so3608404oik.8
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:34:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-1-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 14:34:24 +0000
Message-ID: <CAFEAcA-bYjdgQy3y_nX1a2mLx5BzVj5+kcoB9_T+v2x0h9fDwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] target/arm: Preparatory work for SVE
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

On 23 January 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Based on PMM's target-arm.next branch, which now has most of v2.
>
> While looking again at ZCR_ELx, I think that there's an existing
> bug in the FPCR/FPSR system registers, wherein we do not have an
> access function for when the FPU is disabled.

Applied to target-arm.next, thanks.

-- PMM
