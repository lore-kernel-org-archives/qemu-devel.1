Received: from eggs.gnu.org ([2001:4830:134:3::10]:33773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eaT2N-0007Bg-Tb
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 16:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eaT2M-0008CU-QA
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 16:08:23 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eaT2M-0008Az-LM
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 16:08:22 -0500
Received: by mail-oi0-x22e.google.com with SMTP id j139so3066528oih.2
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 13:08:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3b39502a-5c54-c4ca-38af-6ac4c04fb22b@mail.uni-paderborn.de>
References: <3b39502a-5c54-c4ca-38af-6ac4c04fb22b@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2018 21:08:01 +0000
Message-ID: <CAFEAcA9HE0iRGJ+apCb59TCoMUDsyYbhTEN-euAvaZs7BDeCig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 01/23] scripts: Add decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 13 January 2018 at 17:14, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> Hi Richard,
>
> +# Field examples:
> +#
> +#   %disp   0:s16          -- sextract(i, 0, 16)
> +#   %imm9   16:6 10:3      -- extract(i, 16, 6) << 3 | extract(i, 10, 3)
>
> startindex:endindex for unnamed_field is more intuitive. As any ISA
> manual would specify those.

I find start:len easier to work with personally (and it matches
what we use in QEMU for the extract/deposit APIs, and for what
little it's worth, what RISU data file syntax does). You're probably
right that ISA manuals will tend to give bit positions though.

thanks
-- PMM
