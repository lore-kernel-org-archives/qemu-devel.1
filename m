Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dnxUb-0005H4-VQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 21:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dnxUY-0005I0-UF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 21:45:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dnxUY-0005Dt-LP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 21:44:58 -0400
Date: Fri, 1 Sep 2017 21:44:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170902014456.GA29493@flamenco>
References: <20170829063313.10237-1-bobby.prani@gmail.com>
	<20170829063313.10237-4-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829063313.10237-4-bobby.prani@gmail.com>
Subject: Re: [Qemu-devel] [RFC v3 PATCH 4/5] mttcg: Implement implicit
 ordering semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>, pbonzini@redhat.com

On Tue, Aug 29, 2017 at 02:33:12 -0400, Pranith Kumar wrote:
> Currently, we cannot use mttcg for running strong memory model guests
> on weak memory model hosts due to missing ordering semantics.
> 
> We implicitly generate fence instructions for stronger guests if an

This confused me. By "We implicitly" are we still talking about
the current state (as per the "currently" above?). If not, I'd
rephrase as:

"We cannot use [...].

To fix it, generate fences [...]"

Also, I think you meant s/stronger/weaker/ in the last sentence.

> ordering mismatch is detected. We generate fences only for the orders
> for which fence instructions are necessary, for example a fence is not
> necessary between a store and a subsequent load on x86 since its
> absence in the guest binary tells that ordering need not be
> ensured. Also note that if we find multiple subsequent fence
> instructions in the generated IR, we combine them in the TCG
> optimization pass.

A before/after example of -d out_asm would be great to have here.
> 
> This patch allows us to boot an x86 guest on ARM64 hosts using mttcg.

A test with a simple program that *cannot* work without this patch
would be even better.

Thanks,

		Emilio
