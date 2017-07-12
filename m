Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMEp-0005Lf-6X
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMEm-0005DL-3z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:19:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dVMEl-0005Cu-Mj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:19:48 -0400
Date: Wed, 12 Jul 2017 14:19:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170712181945.GA7547@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-4-git-send-email-cota@braap.org>
	<87pod5946r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pod5946r.fsf@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 14:26:36 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > This patch does the latter by embedding tlb_flush_count in CPUArchState.
> > The global count is then easily obtained by iterating over the CPU list.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> As it actually fixes unintentional breakage:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> That said I'm not sure if this number alone is helpful given the range
> of flushes we have. Really from a performance point of view we should
> differentiate between inline per-vCPU flushes as well as the cross-vCPU
> flushes of both asynchronus and synced varieties.
> 
> I had a go at this using QEMUs tracing infrastructure:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04076.html
> 
> But I guess the ideal way would be something that both keeps counters
> and optionally enable tracepoints.

Yeah the counters in my patch are there to fix the breakage while
not hurting scalability in MTTCG.

Having those counters always on + the tracers in your patchset
for more detailed info seems reasonable to me.

Maybe it's time to push to get those tracers changes in?

		Emilio
