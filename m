Received: from eggs.gnu.org ([2001:4830:134:3::10]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJL8q-0008Dp-I4
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJL8p-00057J-7O
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:48:32 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJL8p-00057A-1M
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:48:31 -0400
Received: by mail-ot0-x244.google.com with SMTP id h8-v6so5585728otb.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:48:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516205543.29305-8-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
	<20180516205543.29305-8-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:48:09 +0100
Message-ID: <CAFEAcA_a9i6ArK2WX7xUH1+EwuQ1bch2haw7xrFMDV1akir8_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/8] linux-user: copy sparc/sockbits.h
 definitions from linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 16 May 2018 at 21:55, Laurent Vivier <laurent@vivier.eu> wrote:
> Values defined for sparc are not correct.
> Copy the content of "arch/sparc/include/uapi/asm/socket.h"
> to fix them.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/sparc/sockbits.h | 131 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 92 insertions(+), 39 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
