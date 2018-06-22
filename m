Received: from eggs.gnu.org ([2001:4830:134:3::10]:33205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWTNN-00051c-0b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWTNM-0001lq-7G
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:13:48 -0400
Date: Fri, 22 Jun 2018 17:13:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180622211341.GB11346@flamenco>
References: <20180621173635.21537-1-richard.henderson@linaro.org>
	<20180621173635.21537-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621173635.21537-3-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Use pthread_rwlock_t for
 mmap_rd/wrlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-arm@nongnu.org

On Thu, Jun 21, 2018 at 07:36:35 -1000, Richard Henderson wrote:
>  void mmap_wrlock(void)
>  {
> -    mmap_lock_internal();
> +    if (likely(mmap_lock_held == 0)) {
> +        pthread_rwlock_rdlock(&mmap_rwlock);

s/rwlock_rdlock/rwlock_wrlock/

		E.
