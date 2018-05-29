Received: from eggs.gnu.org ([2001:4830:134:3::10]:44181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNj6v-0006ML-Hc
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNj6u-0000LE-JU
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:12:41 -0400
Date: Tue, 29 May 2018 20:12:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529181232.GH4756@localhost.localdomain>
References: <20180528150128.31500-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528150128.31500-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix Coverity warning when
 calculating the refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Am 28.05.2018 um 17:01 hat Alberto Garcia geschrieben:
> MIN_REFCOUNT_CACHE_SIZE is 4 and the cluster size is guaranteed to be
> at most 2MB, so the minimum refcount cache size (in bytes) is always
> going to fit in a 32-bit integer.
> 
> Coverity doesn't know that, and since we're storing the result in a
> uint64_t (*refcount_cache_size) it thinks that we need the 64 bits and
> that we probably want to do a 64-bit multiplication to prevent the
> result from being truncated.
> 
> This is a false positive in this case, but it's a fair warning.
> We could do a 64-bit multiplication to get rid of it, but since we
> know that a 32-bit variable is enough to store this value let's simply
> reuse min_refcount_cache, make it a normal int and stop doing casts.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, applied to the block branch.

Kevin
