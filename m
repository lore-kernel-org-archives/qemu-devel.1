Received: from eggs.gnu.org ([2001:4830:134:3::10]:59025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWIQy-0001X9-KT
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWIQx-0002dv-Qt
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:28:16 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWIQx-0002db-KI
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:28:15 -0400
Date: Sat, 15 Jul 2017 10:28:13 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170715082813.zlvqkoeqw6ye3mu5@aurel32.net>
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-2-rth@twiddle.net>
	<20170714210105.mchifmgphjjmaehz@aurel32.net>
	<dba696e6-5e94-dedc-417e-c5723880454e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba696e6-5e94-dedc-417e-c5723880454e@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-07-14 14:22, Richard Henderson wrote:
> On 07/14/2017 11:01 AM, Aurelien Jarno wrote:
> > > +    if (parallel_cpus) {
> > > +        int mask = 0;
> > > +#if !defined(CONFIG_ATOMIC64)
> > > +        mask = -8;
> > > +#elif !defined(CONFIG_ATOMIC128)
> > > +        mask = -16;
> > > +#endif
> > > +        if (((4 << fc) | (1 << sc)) & mask) {
> > > +            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> > > +        }
> > > +    }
> > 
> > This doesn't look correct. For a 16-byte store, ie sc = 4, and with
> > ATOMIC128 support, ie mask = -16, the condition is true.
> 
> That's WITHOUT atomic128 support that mask = -16.
> If we have atomic128, then mask = 0.

Oh, right, it all looks correct then.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
