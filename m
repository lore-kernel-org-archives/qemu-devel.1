Received: from eggs.gnu.org ([2001:4830:134:3::10]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1eBnR6-0000wU-0d
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1eBnR1-0005KC-62
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:51:56 -0500
Received: from jessie.kos.to ([212.47.231.226]:49804 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1eBnR0-0005GA-Vs
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:51:51 -0500
Date: Mon, 6 Nov 2017 19:51:46 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171106195146.GA19281@kos.to>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/7] linux-user fixes, mostly for hppa
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

On Tue, Oct 31, 2017 at 01:53:51PM +0100, Richard Henderson wrote:
> I believe these were last posted back in March.
> I must claim responsibility for not pinging earlier.

Thanks, applied to linux-user 
 
> 
> r~
> 
> 
> Helge Deller (5):
>   linux-user/hppa: Fix TARGET_SA_* defines
>   linux-user/hppa: Fix typo for TARGET_NR_epoll_wait
>   linux-user/hppa: Fix TARGET_MAP_TYPE
>   linux-user/hppa: Fix TARGET_F_RDLCK, TARGET_F_WRLCK, TARGET_F_UNLCK
>   linux-user: Handle TARGET_MAP_STACK and TARGET_MAP_HUGETLB
> 
> Richard Henderson (2):
>   linux-user: Restrict usage of sa_restorer
>   linux-user/hppa: Fix cpu_clone_regs
> 
>  linux-user/hppa/syscall_nr.h |  2 +-
>  linux-user/hppa/target_cpu.h |  4 ++++
>  linux-user/syscall_defs.h    | 40 +++++++++++++++++++++++++++++++++++++++-
>  linux-user/signal.c          |  4 ++--
>  linux-user/syscall.c         | 31 ++++++++++++++++++++-----------
>  5 files changed, 66 insertions(+), 15 deletions(-)
> 
> -- 
> 2.13.6
> 
> 
