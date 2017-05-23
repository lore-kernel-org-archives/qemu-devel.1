Received: from eggs.gnu.org ([2001:4830:134:3::10]:37259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7N4-0003AU-TO
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7N4-00004y-3U
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:48:58 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD7N3-0008Ug-Us
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:48:58 -0400
Date: Tue, 23 May 2017 12:48:51 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523104851.37tseiq5zlpwevr6@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523030312.6360-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
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

On 2017-05-22 20:02, Richard Henderson wrote:
> Previously, helper_ex would construct the insn and then implement
> the insn via direct calls other helpers.  This was sufficient to
> boot Linux but that is all.
> 
> It is easy enough to go the whole nine yards by stashing state for
> EXECUTE within the cpu, and then relying on a new TB to be created
> that properly and completely interprets the insn.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu.h         |   4 +-
>  target/s390x/helper.h      |   2 +-
>  target/s390x/insn-data.def |   4 +-
>  target/s390x/machine.c     |  19 +++++++
>  target/s390x/mem_helper.c  | 136 +++++++++++----------------------------------
>  target/s390x/translate.c   | 124 +++++++++++++++++++++++++----------------
>  6 files changed, 133 insertions(+), 156 deletions(-)

This looks good on the principle, and finally removes a big hack. That
said it prevent my test system to boot. I haven't investigated why yet.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
