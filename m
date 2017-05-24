Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf8R-0005hj-3l
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf8Q-0006xh-9J
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:07 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDf8Q-0006xZ-5X
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:06 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so28187708qte.0
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:52:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-3-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <29068dca-b6ee-f475-3cf6-ebbc9848a710@twiddle.net>
Date: Wed, 24 May 2017 15:52:02 -0700
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] target/sh4: fix reset when using a
 kernel and an initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 03:47 PM, Aurelien Jarno wrote:
> When a masked exception happens, the SH4 CPU generates a non-masked
> reset exception, which then jumps to the reset vector at address
> 0xA0000000. While this is emulated correctly in QEMU, this does not
> work when using a kernel and initrd as this address then contain an
> illegal instruction (and there is no guarantee the kernel and initrd
> haven't been overwritten).
> 
> Therefore call qemu_system_reset_request to reload the kernel and initrd
> and load the program counter to the kernel entry point.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/helper.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
