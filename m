Received: from eggs.gnu.org ([2001:4830:134:3::10]:38948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXZdh-0002Ck-4x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXZdc-0002C5-DU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:02:41 -0400
Received: from hall.aurel32.net ([163.172.24.10]:46324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXZdc-0002BL-6r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:02:36 -0400
Date: Tue, 18 Jul 2017 23:02:34 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170718210234.m3bgvlx2s2at4krx@aurel32.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 00/30] target/sh4 improvements
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
> The big ticket item in this series is the support for
> user-space atomics.  But a lot of other cleanup has
> crept in as well.
> 
> Changes since v2 incorporate feedback from Aurelien.
> I've tried to remember to add individual changelogs
> to the patches, but I may have forgotten some.
> 
> I do now include the linux-user reserved_va changes
> that I posted subsequent to posting v2.
> 
> I believe there are only 4 patches that have not 
> seen a Reviewed-by yet.

Thanks for this new version. I have applied patches 2-27 to my tree. I
believe the patch 1 doesn't provide the correct (corner case) behaviour
in system mode. As for the last 3 patches, given they touch non-sh4
specific part of linux-user, I guess they should at least be acked by
a linux-user maintainer.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
