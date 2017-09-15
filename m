Received: from eggs.gnu.org ([2001:4830:134:3::10]:44052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dswxs-00068F-FJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dswxn-0000wo-Sy
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:11:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dswxn-0000vm-Iv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:11:47 -0400
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<20170915193313.86362-1-jrtc27@jrtc27.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6422964f-50d1-337b-5ea8-185686f27ca1@vivier.eu>
Date: Fri, 15 Sep 2017 22:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170915193313.86362-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Le 15/09/2017 à 21:33, James Clarke a écrit :
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
