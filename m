Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWVv3-0002eO-A0
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWVv2-0004c5-8h
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:52:13 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWVv2-0004a5-26
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:52:12 -0400
Date: Sun, 16 Jul 2017 00:52:04 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170715225204.fe4zpekrhdl72dsh@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-9-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
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
> We translate gUSA regions atomically in a parallel context.
> But in a serial context a gUSA region may be interrupted.
> In that case, restart the region as the kernel would.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/signal.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

With my limited knowledge of linux-user:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
