Received: from eggs.gnu.org ([2001:4830:134:3::10]:50743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJ5fY-0001lI-GS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJ5fV-0003Sb-7v
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:17:16 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJ5fV-0003SS-1s
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:17:13 -0400
Received: by mail-qt0-x242.google.com with SMTP id f13-v6so3424346qtp.10
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 16:17:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516205543.29305-1-laurent@vivier.eu>
	<20180516205543.29305-6-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e676844-2918-77b0-521a-16ded3228de9@amsat.org>
Date: Wed, 16 May 2018 20:17:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180516205543.29305-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 05/16/2018 05:55 PM, Laurent Vivier wrote:
> No code change.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/generic/sockbits.h |  9 +--------
>  linux-user/ppc/sockbits.h     | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
> index 093faf0a48..5ad43eb0c8 100644
> --- a/linux-user/generic/sockbits.h
> +++ b/linux-user/generic/sockbits.h
> @@ -30,14 +30,7 @@
>  #define TARGET_SO_LINGER       13
>  #define TARGET_SO_BSDCOMPAT    14
>  /* To add :#define TARGET_SO_REUSEPORT 15 */
> -#if defined(TARGET_PPC)
> -#define TARGET_SO_RCVLOWAT     16
> -#define TARGET_SO_SNDLOWAT     17
> -#define TARGET_SO_RCVTIMEO     18
> -#define TARGET_SO_SNDTIMEO     19
> -#define TARGET_SO_PASSCRED     20
> -#define TARGET_SO_PEERCRED     21
> -#else
> +#ifndef TARGET_SO_PASSCRED /* powerpc only differs in these */

#ifndef TARGET_PPC ?

>  #define TARGET_SO_PASSCRED     16
>  #define TARGET_SO_PEERCRED     17
>  #define TARGET_SO_RCVLOWAT     18
> diff --git a/linux-user/ppc/sockbits.h b/linux-user/ppc/sockbits.h
> index 0e4c8f012d..3593bc44ac 100644
> --- a/linux-user/ppc/sockbits.h
> +++ b/linux-user/ppc/sockbits.h
> @@ -1 +1,20 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation, or (at your option) any
> + * later version. See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_SOCKBITS_H
> +#define PPC_SOCKBITS_H
> +
> +#define TARGET_SO_RCVLOWAT     16
> +#define TARGET_SO_SNDLOWAT     17
> +#define TARGET_SO_RCVTIMEO     18
> +#define TARGET_SO_SNDTIMEO     19
> +#define TARGET_SO_PASSCRED     20
> +#define TARGET_SO_PEERCRED     21
> +
>  #include "../generic/sockbits.h"
> +
> +#endif
> 
