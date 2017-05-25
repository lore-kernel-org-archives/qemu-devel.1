Received: from eggs.gnu.org ([2001:4830:134:3::10]:48818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dE1hi-00029p-MW
	for qemu-devel@nongnu.org; Thu, 25 May 2017 18:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dE1hh-0000K4-Pb
	for qemu-devel@nongnu.org; Thu, 25 May 2017 18:58:02 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dE1hh-0000IS-JD
	for qemu-devel@nongnu.org; Thu, 25 May 2017 18:58:01 -0400
Date: Fri, 26 May 2017 00:57:55 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170525225755.usblikum5gxh25f7@aurel32.net>
References: <20170524220827.21154-1-rth@twiddle.net>
	<20170524220827.21154-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524220827.21154-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 1/4] target/s390x: Save current ilen during
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-05-24 15:08, Richard Henderson wrote:
> Use this saved value instead of recomputing from next_pc difference.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/translate.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
