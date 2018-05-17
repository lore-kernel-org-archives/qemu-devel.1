Received: from eggs.gnu.org ([2001:4830:134:3::10]:60965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLZV-0002UF-5S
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLZU-0002Qh-5t
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:16:05 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJLZU-0002Pn-0H
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:16:04 -0400
Received: by mail-ot0-x242.google.com with SMTP id 77-v6so5697380otd.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:16:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
	<CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
	<99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 17:15:43 +0100
Message-ID: <CAFEAcA_jMUurJy1z_REhbmmsHcwcJqAiaTy0fWBKkxWHGpTRWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 15 May 2018 at 14:13, Stefan Weil <sw@weilnetz.de> wrote:
> That fix will work for the moment, but is not sufficient for the future
> because it only supports gcc 7.x, but not gcc 8.x or later:
>
> +#elif __GNUC__ == 7

Fix to make that use >= is currently going through upstream vixl
code review: https://review.linaro.org/#/c/25282/

thanks
-- PMM
