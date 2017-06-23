Received: from eggs.gnu.org ([2001:4830:134:3::10]:49239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQtg-0008Nh-V4
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQtg-0002pK-4y
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:53:25 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOQtf-0002nj-UW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:53:24 -0400
Date: Fri, 23 Jun 2017 17:53:22 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623155322.2qze34ruak3qxdcj@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-17-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-17-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 16/18] target/s390x: Implement TRTR
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

On 2017-06-19 17:04, Richard Henderson wrote:
> Drop TRT from the set of insns handled internally by EXECUTE.
> It's more important to adjust the existing helper to handle
> both TRT and TRTR.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/mem_helper.c  | 20 +++++++++++++-------
>  target/s390x/translate.c   |  9 +++++++++
>  4 files changed, 25 insertions(+), 7 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
