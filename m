Received: from eggs.gnu.org ([2001:4830:134:3::10]:48085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6uf-0007CM-U1
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6uf-0005Mj-3x
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:12:41 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH6ue-0005MB-Va
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:12:41 -0400
Received: by mail-ot0-x242.google.com with SMTP id t1-v6so5947921ott.13
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:12:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510222601.19944-5-laurent@vivier.eu>
References: <20180510222601.19944-1-laurent@vivier.eu>
	<20180510222601.19944-5-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:12:20 +0100
Message-ID: <CAFEAcA988cQ4eBOGVmvMkYPUynp6zA73wW=0vRB8GYBL8-fJ7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

On 10 May 2018 at 23:26, Laurent Vivier <laurent@vivier.eu> wrote:
> No code change.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> --- a/linux-user/socket.h
> +++ b/linux-user/socket.h
> @@ -1,6 +1,6 @@
>
>  #if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA) || \
> -    defined(TARGET_SPARC)
> +    defined(TARGET_SPARC) || defined(TARGET_PPC)
>  #include "sockbits.h"
>  #else

Follow-on cleanup: rather than having this long list of target ifdefs,
we should just have every target supply a sockbits.h (perhaps deferring
to a generic set of values the way that lots of archs use the asm-generic
versions).

thanks
-- PMM
