Received: from eggs.gnu.org ([2001:4830:134:3::10]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkcP-000800-7y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkcN-0006K0-P9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:21:00 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:44578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkcN-0006J4-Lc
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:59 -0500
Received: by mail-ot0-x242.google.com with SMTP id 79so8675477oth.11
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:20:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-9-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-9-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:20:38 +0000
Message-ID: <CAFEAcA8oNiHrdCP+8-ZVSgbqg8tPLmp5oSxf4sYmA7RZxtcLSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/10] linux-user: init_guest_space: Don't
 try to align if we'll reject it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
> From: Luke Shumaker <lukeshu@parabola.nu>
>
> If the ensure-alignment code gets triggered, then the
> "if (host_start && real_start != current_start)" check will always trigger,
> so save 2 syscalls and put that check first.
>
> Note that we can't just switch to using MAP_FIXED for that check, because
> then we couldn't differentiate between a failure because "there isn't
> enough space" and "there isn't enough space *here*".
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
