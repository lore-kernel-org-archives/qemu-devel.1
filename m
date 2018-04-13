Received: from eggs.gnu.org ([2001:4830:134:3::10]:50752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70dq-0004K4-BT
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70dp-0005Ia-IH
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:29:34 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:35990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70dp-0005IP-Bf
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:29:33 -0400
Received: by mail-ot0-x236.google.com with SMTP id n40-v6so10286431otd.3
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:29:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0703fdde-da82-d85f-3d68-e45e0839a9dc@mail.uni-paderborn.de>
References: <20180413140334.26622-1-alex.bennee@linaro.org>
	<20180413140334.26622-3-alex.bennee@linaro.org>
	<3a3a9132-8f03-c476-bd0d-b6c91a9cc3a4@mail.uni-paderborn.de>
	<CAFEAcA9FWu7VU1-RtXA4h-LQOXVoDfOG9P8aTs02B-NF9N93qg@mail.gmail.com>
	<0703fdde-da82-d85f-3d68-e45e0839a9dc@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:29:12 +0100
Message-ID: <CAFEAcA-ZzUVK_WWd6nA35YbHQHCCJHo93H7eomeq=2F9m59pnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] fpu/softfloat: raise float_invalid
 for NaN/Inf in round_to_int_and_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 13 April 2018 at 16:24, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> However, my risu-like tests found another flag raising problem with
> float32_div. I'll investigate it on Monday.

Is it a regression from our previous (2.11) behaviour?

thanks
-- PMM
