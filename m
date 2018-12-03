Received: from eggs.gnu.org ([2001:4830:134:3::10]:50017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gTowa-0006Za-BZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gTowX-000843-3Z
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:11:28 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gTowW-00083W-Tq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:11:25 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so7806441otl.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:11:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-3-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <daefe1bb-2da4-a7ab-5e2f-798db6c5f353@twiddle.net>
Date: Mon, 3 Dec 2018 08:11:19 -0600
MIME-Version: 1.0
In-Reply-To: <1543845937-300-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/7] Remove support for compilers
 that can not do 128-bit arithmetics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

On 12/3/18 8:05 AM, Thomas Huth wrote:
> +++ b/include/qemu/host-utils.h
> @@ -28,7 +28,6 @@
>  
>  #include "qemu/bswap.h"
>  
> -#ifdef CONFIG_INT128
>  static inline void mulu64(uint64_t *plow, uint64_t *phigh,
>                            uint64_t a, uint64_t b)
>  {
> @@ -76,35 +75,6 @@ static inline int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
>          return result != *plow;
>      }
>  }
> -#else
> -void muls64(uint64_t *phigh, uint64_t *plow, int64_t a, int64_t b);
> -void mulu64(uint64_t *phigh, uint64_t *plow, uint64_t a, uint64_t b);

No, because __int128 support requires a 64-bit host.
This will not compile for a 32-bit host.


r~
