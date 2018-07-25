Received: from eggs.gnu.org ([2001:4830:134:3::10]:51369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiFfG-0000ua-HI
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiFfD-0003dl-Js
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:58 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fiFfD-0003ch-D9
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:55 -0400
Received: by mail-oi0-x242.google.com with SMTP id i12-v6so12587132oik.2
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 02:00:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jul 2018 10:00:34 +0100
Message-ID: <CAFEAcA-WVfswDpDGoDCTqv-ZRege8kJ5hPjcy43DkODRKZfGZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm: check fw_cfg return value
 before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, radoslaw.biernacki@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 25 July 2018 at 06:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> The fw_cfg value returned from fw_cfg_find() may be NULL, so check it
> before using.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

Hi -- this patch series seems to be missing its cover letter.
Please could you include a cover letter for any patchset
with more than one patch -- some of our automated patch
email handling tools rely on it.

thanks
-- PMM
