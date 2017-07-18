Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXNKX-0002Dx-U6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXNKU-0007lk-R6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:54:05 -0400
Received: from hall.aurel32.net ([163.172.24.10]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXNKU-0007lC-Jq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:54:02 -0400
Date: Tue, 18 Jul 2017 09:51:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170718075135.hjjuqz6upbe73473@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 00/27] target/sh4 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:20, Richard Henderson wrote:
> This fixes two problems with atomic operations on sh4,
> including an attempt at supporting the user-space atomics
> technique used by most sh-linux-user binaries.
> 
> Changes since v1:
>   * Rebase on Aurelien's recent sh4 patchset.
>   * Patch 3,5 split out of patch 6.
>   * Patch 4 fixes the sh4-softmmu problem that Aurelien reported.
>   * Handle more cases of atomic_fetch_op seen in debian images.
>   * More cleanups for register banking.
>   * Fix for 64-bit fp memory operations.
>   * Tidy illegal instruction checks.
>   * Implement fpchg (missing from sh4a)
>   * Implement fsrra (had a nop implementation)
>   * Use tcg_gen_lookup_and_goto_ptr for simple branches.

I have finally finished reviewing all patches, how do you want to
proceed from there? Do you want to post a new version or should I just
pick your patches and apply the small fixes that are needed?

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
