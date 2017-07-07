Received: from eggs.gnu.org ([2001:4830:134:3::10]:37871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbgJ-0005rT-MM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbgI-0002zr-NV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:24:59 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbgI-0002zZ-HC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:24:58 -0400
Date: Sat, 8 Jul 2017 00:24:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707222456.m6y3y4nvaw2ljjv4@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-26-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-26-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 25/27] target/sh4: Add missing FPSCR.PR
 == 0 checks
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
> Both frchg and fschg require PR == 0, otherwise undefined_operation.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
