Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJFj-0005NE-Qf
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJFg-0000AI-QJ
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:56:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUJFg-00008z-GC
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:56:24 -0400
Date: Sun, 9 Jul 2017 16:56:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709205623.GA32582@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-4-git-send-email-cota@braap.org>
	<7eacd6bc-88e3-84de-30df-5c30bd2b8fe8@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eacd6bc-88e3-84de-30df-5c30bd2b8fe8@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 03/22] cputlb: bring back tlb_flush_count
 under !TLB_DEBUG
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

On Sun, Jul 09, 2017 at 10:00:01 -1000, Richard Henderson wrote:
> On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> >+    atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
> 
> Want atomic_read here, so they're all the same.

It's not needed. Note that this thread is the only one ever writing
to env->tlb_flush_count, so the thread can read this value without
atomic accesses.

You'll see this pattern all across the patchset.

Thanks,

		E.
