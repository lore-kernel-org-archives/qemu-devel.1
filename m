Received: from eggs.gnu.org ([2001:4830:134:3::10]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbD4-00008B-5k
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbD3-0008Km-7q
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:54:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbD3-0008KG-1N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:54:45 -0400
Date: Fri, 7 Jul 2017 23:54:41 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707215441.3ev4ymmjt6kiw7e3@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-12-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-12-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 11/27] target/sh4: Unify cpu_fregs into
 FREG
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
> We were treating FREG as an index and REG as a TCGv.
> Making FREG return a TCGv is both less confusing and
> a step toward cleaner banking of cpu_fregs.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 125 ++++++++++++++++++++-----------------------------
>  1 file changed, 52 insertions(+), 73 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
