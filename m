Received: from eggs.gnu.org ([2001:4830:134:3::10]:51763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dE1wF-0000MX-Kn
	for qemu-devel@nongnu.org; Thu, 25 May 2017 19:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dE1wE-0005gT-N9
	for qemu-devel@nongnu.org; Thu, 25 May 2017 19:13:03 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dE1wE-0005gG-H4
	for qemu-devel@nongnu.org; Thu, 25 May 2017 19:13:02 -0400
Date: Fri, 26 May 2017 01:12:59 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170525231259.nkzs2rdmscufnezw@aurel32.net>
References: <20170524220827.21154-1-rth@twiddle.net>
	<20170524220827.21154-5-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524220827.21154-5-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 4/4] target/s390x: Re-implement a few
 EXECUTE target insns directly
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
> While the previous patch is required for proper conformance,
> the vast majority of target insns are MVC and XC for implementing
> memmove and memset respectively.  The next most common are CLC,
> TR, and SVC.
> 
> Implementing these (and a few others for which we already have
> an implementation) directly is faster than going through full
> translation to a TB.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 66 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 15 deletions(-)

I have mixed feelings about this patch. On one side it is correct. On
the other side, I don't know if it really worth it. With the goto_ptr
optimization, it can be executed quite fast once it has been translated
once.

So in short, I leave you decide:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
