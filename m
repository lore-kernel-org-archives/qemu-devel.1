Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUtd3-0002wH-Ic
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUtcy-0003RY-Ty
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:23:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUtcy-0003QJ-Ob
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:23:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id k98so378733otk.3
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-8-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 13:23:28 +0000
Message-ID: <CAFEAcA8axQ=eGry5xYqxVuDhZ2RWUcNgXVibSKknHR+V4a-p4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/10] target/arm: Tidy scr_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Because EL3 has a fixed execution mode, we can properly decide
> which of the bits are RES{0,1}.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  2 --
>  target/arm/helper.c | 14 +++++++++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
