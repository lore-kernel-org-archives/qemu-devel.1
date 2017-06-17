Received: from eggs.gnu.org ([2001:4830:134:3::10]:52840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dMMmp-0006Lq-N1
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 19:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dMMmo-0006a2-9b
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 19:05:47 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dMMmn-0006XL-TS
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 19:05:46 -0400
Date: Sun, 18 Jun 2017 01:05:33 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170617230533.sz4wc7evosnqdz6s@aurel32.net>
References: <1497536433-28009-1-git-send-email-miodrag.dinic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497536433-28009-1-git-send-email-miodrag.dinic@rt-rk.com>
Subject: Re: [Qemu-devel] [PATCH] target/mips: fix msa copy_[s|u]_df rd = 0
 corner case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miodrag Dinic <miodrag.dinic@rt-rk.com>
Cc: yongbok.kim@imgtec.com, qemu-devel@nongnu.org, aleksandar.markovic@imgtec.com, petar.jovanovic@imgtec.com, raghu.gandham@imgtec.com, miodrag.dinic@imgtec.com

On 2017-06-15 16:20, Miodrag Dinic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> This patch fixes the msa copy_[s|u]_df instruction emulation when
> the destination register rd is zero. Without this patch the zero
> register would get clobbered, which should never happen because it
> is supposed to be hardwired to 0.
> 
> Fix this corner case by explicitly checking rd = 0 and effectively
> making these instructions emulation no-op in that case.
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> ---
>  target/mips/translate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
