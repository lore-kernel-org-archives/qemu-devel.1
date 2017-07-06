Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dT8CA-0002ts-OG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dT8C9-0007Zf-Fz
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:55:54 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dT8C9-0007Z5-9r
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:55:53 -0400
Date: Thu, 6 Jul 2017 16:55:37 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170706145537.h3vzo2z5i3qtzb5j@aurel32.net>
References: <20170706002401.10507-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 00/11] target/sh4 improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, bruno@clisp.org

On 2017-07-05 14:23, Richard Henderson wrote:
> This fixes two problems with atomic operations on sh4,
> including an attempt at supporting the user-space atomics
> technique used by most sh-linux-user binaries.
> 
> This is good enough to run the one occurrence in linux-user-test-0.3.
> I'm still downloading enough of a cross environment to be able to run
> more recent sh4 binaries.  Including the one in the LP bug report.
> 
> Thoughts and more extensive testing appreciated.

Thanks for you work. For the next version, could you please base it on
this patchset:

http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00095.html

I'll try to review it over the next days, but unfortunately I'll have
little time before Monday.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
