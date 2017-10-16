Received: from eggs.gnu.org ([2001:4830:134:3::10]:48539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e44hu-0003jN-Al
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e44hp-0000gP-EF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:41:22 -0400
Received: from jessie.kos.to ([212.47.231.226]:52400 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1e44hp-0000fN-7X
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:41:17 -0400
Date: Mon, 16 Oct 2017 12:41:14 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171016124114.GD1918@kos.to>
References: <20171005143601.21584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005143601.21584-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] linux-user fixes for va mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Oct 05, 2017 at 10:35:57AM -0400, Richard Henderson wrote:
> Version 1 was back in July,
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02033.html
> 
>   > At first I was simply going to add TARGET_SH to the existing
>   > set of defines that trigger a 31-bit address space.  But then
>   > I realized that one could create non-working va configurations
>   > from the command-line.
> 
> Changes since v1:
>   * Peter fixes the elfload bug that prevented ARM using the proper
>     MAX_RESERVED_VA setting.
>   * Adjust the arm MAX_RESERVED_VA.
> 

Thanks, applied to linux-user
 
> r~
> 
> 
> Peter Maydell (1):
>   linux-user: Allow -R values up to 0xffff0000 for 32-bit ARM guests
> 
> Richard Henderson (3):
>   tcg: Fix off-by-one in assert in page_set_flags
>   linux-user: Tidy and enforce reserved_va initialization
>   linux-user/sh4: Reduce TARGET_VIRT_ADDR_SPACE_BITS to 31
> 
>  linux-user/arm/target_cpu.h |  4 ++++
>  target/mips/mips-defs.h     |  6 +++++-
>  target/nios2/cpu.h          |  6 +++++-
>  target/sh4/cpu.h            |  6 +++++-
>  accel/tcg/translate-all.c   |  2 +-
>  linux-user/elfload.c        |  2 +-
>  linux-user/main.c           | 38 +++++++++++++++++++++++++-------------
>  7 files changed, 46 insertions(+), 18 deletions(-)
> 
> -- 
> 2.13.6
> 
