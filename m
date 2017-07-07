Received: from eggs.gnu.org ([2001:4830:134:3::10]:34124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbYu-0008TF-8g
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbYt-0005to-Cp
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:17:20 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbYt-0005tW-6o
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:17:19 -0400
Date: Sat, 8 Jul 2017 00:17:17 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707221717.rsmbkt5fr5frzoxw@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-19-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-19-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 18/27] target/sh4: Unify code for
 CHECK_NOT_DELAY_SLOT
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
>  target/sh4/translate.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
