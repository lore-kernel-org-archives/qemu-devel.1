Received: from eggs.gnu.org ([2001:4830:134:3::10]:42426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsxsN-0002p6-UW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsxsJ-0003B8-Tu
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:10:15 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:43899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsxsJ-0003Ak-Pe
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:10:11 -0400
Received: by mail-qt0-x232.google.com with SMTP id i50so3308088qtf.0
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 14:10:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<20170915193313.86362-1-jrtc27@jrtc27.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9965e38-5e75-0d3a-33cb-ce1d8c21ab1d@amsat.org>
Date: Fri, 15 Sep 2017 18:10:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170915193313.86362-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On 09/15/2017 04:33 PM, James Clarke wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> Changes since v2:
>   * Fixed opening curly brace formatting, both for my new SH4-specific
>     regpairs_aligned function, as well as the Arm one I touched, to appease
>     checkpatch.pl
> 
> Changes since v1:
>   * Removed all changes in v1 :)
>   * Added syscall num argument to regpairs_aligned
>   * Added SH4-specific implementation of regpairs_aligned to return 1 for
>     p{read,write}64
