Received: from eggs.gnu.org ([2001:4830:134:3::10]:57682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7sWK-0001BC-UN
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7sWJ-0000vq-P6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d7sWJ-0000vi-Ii
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:51 -0400
Date: Tue, 9 May 2017 01:56:49 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508235649.mcsjjvyopdbxflzm@aurel32.net>
References: <20170508151707.5434-1-rth@twiddle.net>
	<20170508151707.5434-7-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508151707.5434-7-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] target/s390x: Use atomic operations
 for LOAD AND OP
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

On 2017-05-08 08:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/insn-data.def | 20 ++++++------
>  target/s390x/translate.c   | 78 +++++++++++++++++++++++++++++-----------------
>  2 files changed, 60 insertions(+), 38 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
