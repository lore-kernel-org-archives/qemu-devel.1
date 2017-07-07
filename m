Received: from eggs.gnu.org ([2001:4830:134:3::10]:49309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTb1Y-0003a9-9X
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTb1X-0001r7-HH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:42:52 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTb1X-0001qi-B8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:42:51 -0400
Date: Fri, 7 Jul 2017 23:42:49 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707214249.qpvw55ktd3whgih4@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-5-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-5-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 04/27] target/sh4: Keep env->flags clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:20, Richard Henderson wrote:
> If we mask off any out-of-band bits before we assign to the
> variable, then we don't need to clean it up when reading.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/cpu.h | 2 +-
>  target/sh4/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
