Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJcv-0008Qf-PY
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJcq-0001mm-TZ
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:20:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUJcq-0001me-PB
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:20:20 -0400
Date: Sun, 9 Jul 2017 17:20:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709212020.GA2834@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-4-git-send-email-cota@braap.org>
	<7eacd6bc-88e3-84de-30df-5c30bd2b8fe8@twiddle.net>
	<20170709205623.GA32582@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709205623.GA32582@flamenco>
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

On Sun, Jul 09, 2017 at 16:56:23 -0400, Emilio G. Cota wrote:
> On Sun, Jul 09, 2017 at 10:00:01 -1000, Richard Henderson wrote:
> > On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> > >+    atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
> > 
> > Want atomic_read here, so they're all the same.
> 
> It's not needed. Note that this thread is the only one ever writing
> to env->tlb_flush_count, so the thread can read this value without
> atomic accesses.
> 
> You'll see this pattern all across the patchset.

We already have this kind of pattern in QEMU. See this patch and
related discussion:
  https://patchwork.kernel.org/patch/9358939/

		E.
