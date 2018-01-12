Received: from eggs.gnu.org ([2001:4830:134:3::10]:44452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1ea76Q-0008BZ-8H
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1ea76P-0001rj-EN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:43:06 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:59066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1ea76P-0001o9-7j
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:43:05 -0500
Date: Fri, 12 Jan 2018 22:42:54 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20180112214254.x6k76ht7zomn24vs@aurel32.net>
References: <20180112210613.14124-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112210613.14124-1-richard.henderson@linaro.org>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PULL 0/4] TCG queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 2018-01-12 13:06, Richard Henderson wrote:
> This includes a fix for the tcg/arm bug exposed by the ppc64 code change
> for comparisons.
> 
> It also includes improvements to tcg/arm and tcg/ppc to allow for larger
> CPUFooState structures, as exposed by expanding CPUARMState for 2048-bit
> vector registers.
> 
> Note that tcg/mips has the exact same problem.  However, the mips isa
> makes it more difficult to fix up.  I'd like someone with hardware to
> make this change.

Ok, I'll try to have a look at that.
 
-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
