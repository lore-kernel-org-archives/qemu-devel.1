Received: from eggs.gnu.org ([2001:4830:134:3::10]:34522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbZo-0000Vv-PG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbZn-0006Rb-RW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:18:16 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbZn-0006RG-LC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:18:15 -0400
Date: Sat, 8 Jul 2017 00:18:13 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707221813.wyox2te76gq3ftia@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-21-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-21-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 20/27] target/sh4: Unify code for
 CHECK_FPU_ENABLED
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

On 2017-07-06 16:21, Richard Henderson wrote:
> We do not need to emit N copies of raising an exception.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
