Received: from eggs.gnu.org ([2001:4830:134:3::10]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMIx-0004QM-UA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMIx-0004L3-1M
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:59:11 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOMIw-0004Kb-HM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:59:10 -0400
Date: Fri, 23 Jun 2017 12:59:08 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623105908.4inssotcamnbjs5r@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 02/18] target/s390x: change PSW_SHIFT_KEY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, David Hildenbrand <david@redhat.com>

On 2017-06-19 17:03, Richard Henderson wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Such shifts are usually used to easily extract the PSW KEY from the PSW
> mask, so let's avoid the confusing offset of 4.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20170614133819.18480-2-david@redhat.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu.h       | 2 +-
>  target/s390x/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
