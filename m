Received: from eggs.gnu.org ([2001:4830:134:3::10]:53621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJL6B-0006Ei-Qn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJL6B-00044u-77
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:45:47 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJL6B-00044m-1o
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:45:47 -0400
Received: by mail-ot0-x243.google.com with SMTP id m11-v6so5578250otf.3
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:45:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516205543.29305-7-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
	<20180516205543.29305-7-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:45:25 +0100
Message-ID: <CAFEAcA8q2maj0iWgk066xBQs7biH6dBafWm6qUSK5tV2myaj1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 6/8] linux-user: update
 ARCH_HAS_SOCKET_TYPES use
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
> to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

> +/* Flags for socket, socketpair, accept4 */
> +#define TARGET_SOCK_CLOEXEC    TARGET_O_CLOEXEC
> +#ifndef TARGET_SOCK_NONBLOCK
> +#define TARGET_SOCK_NONBLOCK   O_NONBLOCK

Shouldn't this be TARGET_O_NONBLOCK ?

>  #endif
> +#endif /* TARGET_ARCH_HAS_SOCKET_TYPES */

thanks
-- PMM
