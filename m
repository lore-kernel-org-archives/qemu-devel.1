Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzkD-0007tP-1z
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzkC-0004LY-Ba
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:52:29 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzkC-0004LP-5Z
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:52:28 -0400
Date: Thu, 25 May 2017 22:52:26 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170525205226.4fjft62wabiypcps@aurel32.net>
References: <20170524192246.15905-1-rth@twiddle.net>
	<20170524192246.15905-33-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524192246.15905-33-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 32/33] target/s390x: Use atomic
 operations for COMPARE SWAP PURGE
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

On 2017-05-24 12:22, Richard Henderson wrote:
> Also provide the cross-cpu tlb flushing required by the PoO.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  2 +-
>  target/s390x/insn-data.def |  2 +-
>  target/s390x/mem_helper.c  | 32 ++++++++------------------------
>  target/s390x/translate.c   | 42 ++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 48 insertions(+), 30 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
