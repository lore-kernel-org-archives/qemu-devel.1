Received: from eggs.gnu.org ([2001:4830:134:3::10]:51173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDYD-00039B-Va
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDYA-0001XH-6d
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:49:02 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egDY9-0001Wa-Vt
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:48:58 -0500
Received: by mail-oi0-x22b.google.com with SMTP id l8so5712145oig.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:48:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-5-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 17:48:36 +0000
Message-ID: <CAFEAcA_E7hfOprBiDm+ivnAmJM-rKwsVPS9_P9jP22USZzhZwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/arm: Add ZCR_ELx
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
> Define ZCR_EL[1-3].
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |   5 ++
>  target/arm/helper.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+)
>

Apart from the issue you've noticed about not wanting to specify
.type:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
