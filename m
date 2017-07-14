Received: from eggs.gnu.org ([2001:4830:134:3::10]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dW7ll-0002FB-TC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dW7lk-0005Gz-Vz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:05:01 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dW7lk-0005GR-Or
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:05:00 -0400
Date: Fri, 14 Jul 2017 23:04:59 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170714210459.477a2kduvtjenad2@aurel32.net>
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710204521.2058-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-07-10 10:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |   6 +
>  target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   |  43 +++++++
>  target/s390x/insn-data.def |  13 ++
>  4 files changed, 372 insertions(+)
> 

Besides the check for even r1 and r3, this now looks good.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
