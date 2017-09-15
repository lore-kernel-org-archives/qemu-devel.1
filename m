Received: from eggs.gnu.org ([2001:4830:134:3::10]:44165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dswyA-0006GG-NJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dswy6-00014E-PG
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:12:10 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:43279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dswy6-00013G-IO
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:12:06 -0400
Received: by mail-pg0-x22a.google.com with SMTP id u18so2116024pgo.0
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 13:12:05 -0700 (PDT)
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<20170915193313.86362-1-jrtc27@jrtc27.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ea1b56b-cafa-82fc-2e55-1564b09c97d9@linaro.org>
Date: Fri, 15 Sep 2017 13:12:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170915193313.86362-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 09/15/2017 12:33 PM, James Clarke wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
> 
> Changes since v2:
>  * Fixed opening curly brace formatting, both for my new SH4-specific
>    regpairs_aligned function, as well as the Arm one I touched, to appease
>    checkpatch.pl
> 
> Changes since v1:
>  * Removed all changes in v1 :)
>  * Added syscall num argument to regpairs_aligned
>  * Added SH4-specific implementation of regpairs_aligned to return 1 for
>    p{read,write}64
> 
>  linux-user/syscall.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
