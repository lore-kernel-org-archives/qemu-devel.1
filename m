Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8Lct-0002WA-2H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8Lcr-0007rf-7K
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:35 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8Lcr-0007qk-04
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:33 -0400
Date: Wed, 10 May 2017 09:00:59 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170510070059.4n5t5zeq3s4h4xjg@aurel32.net>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-15-aurelien@aurel32.net>
	<2d3e6a02-940b-c985-d191-02a68f57667a@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d3e6a02-940b-c985-d191-02a68f57667a@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 14/14] target/sh4: trap unaligned
 accesses
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

On 2017-05-09 14:13, Richard Henderson wrote:
> On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> > +void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> > +                                    MMUAccessType access_type,
> > +                                    int mmu_idx, uintptr_t retaddr)
> > +{
> > +    if (retaddr) {
> > +        cpu_restore_state(cs, retaddr);
> > +    }
> ...
> > +    cpu_loop_exit(cs);
> > +}
> > +
> 
> cpu_loop_exit_restore?

Right, I forgot that this function now exit. I'll change that and
convert the other few place where this sequence is used.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
