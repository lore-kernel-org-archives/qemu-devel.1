Received: from eggs.gnu.org ([2001:4830:134:3::10]:59348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXZAt-0000Cx-69
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXZAq-0003IG-2g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:32:55 -0400
Received: from hall.aurel32.net ([163.172.24.10]:46132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXZAp-0003Gy-Rn
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:32:51 -0400
Date: Tue, 18 Jul 2017 22:32:48 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170718203248.i57tnha2mfea4qzw@aurel32.net>
References: <20170718200255.31647-1-rth@twiddle.net>
	<20170718200255.31647-8-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718200255.31647-8-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 07/30] target/sh4: Recognize common gUSA
 sequences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-07-18 10:02, Richard Henderson wrote:
> For many of the sequences produced by gcc or glibc,
> we can translate these as host atomic operations.
> Which saves the need to acquire the exclusive lock.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> 
> ---
> V2: Free constants loaded during the gUSA sequence.
> ---
>  target/sh4/translate.c | 321 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 321 insertions(+)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
