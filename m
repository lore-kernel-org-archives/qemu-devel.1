Received: from eggs.gnu.org ([2001:4830:134:3::10]:53187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9axz-0000Od-Lj
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9axy-0004Vr-Rk
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:08:47 -0400
Date: Tue, 31 Oct 2017 11:08:38 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA91kisKT_wCj8swwJzUn52YycpigpGwv9Djsc-Q1Sq2SQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710311035560.13766@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710251623560.574@sstabellini-ThinkPad-X260>
	<CAFEAcA8pvLNGReghJp0QATbBtC-KCgPqQheKnY=KzDPcjdym3g@mail.gmail.com>
	<alpine.DEB.2.10.1710301444460.7297@sstabellini-ThinkPad-X260>
	<CAFEAcA9GEpxHtPpe3OSZ5eycLB50i5Q_us8dzOjiUj1HxoFnKA@mail.gmail.com>
	<alpine.DEB.2.10.1710311001380.13766@sstabellini-ThinkPad-X260>
	<CAFEAcA91kisKT_wCj8swwJzUn52YycpigpGwv9Djsc-Q1Sq2SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] don't hardcode EL1 in
 extended_addresses_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On Tue, 31 Oct 2017, Peter Maydell wrote:
> On 31 October 2017 at 17:07, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > Sorry Peter, I copy/pasted the values from arm32/page.h instead of
> > arm64/page.h in Xen :-/
> >
> > Xen is running at EL2, 64-bit (aarch64). The ATS instruction is "at
> > s1e2r", used to translate Xen virtual addresses into physical addresses.
> > This is what breaks.
> 
> Thanks. OK, so if we change the line in do_ats_write() from
>      if (extended_addresses_enabled(env)) {
> to
>      if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
> 
> does that fix your problem?

Yes, it does! Thank you! Are you going to submit a patch?
