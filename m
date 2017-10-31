Received: from eggs.gnu.org ([2001:4830:134:3::10]:42523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9aCe-0000Ug-62
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9aCd-0003NN-EP
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:19:52 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:47433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9aCd-0003MR-5l
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:19:51 -0400
Received: by mail-wm0-x22a.google.com with SMTP id r196so279681wmf.2
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 10:19:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710311001380.13766@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710251623560.574@sstabellini-ThinkPad-X260>
	<CAFEAcA8pvLNGReghJp0QATbBtC-KCgPqQheKnY=KzDPcjdym3g@mail.gmail.com>
	<alpine.DEB.2.10.1710301444460.7297@sstabellini-ThinkPad-X260>
	<CAFEAcA9GEpxHtPpe3OSZ5eycLB50i5Q_us8dzOjiUj1HxoFnKA@mail.gmail.com>
	<alpine.DEB.2.10.1710311001380.13766@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 17:19:29 +0000
Message-ID: <CAFEAcA91kisKT_wCj8swwJzUn52YycpigpGwv9Djsc-Q1Sq2SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On 31 October 2017 at 17:07, Stefano Stabellini <sstabellini@kernel.org> wrote:
> Sorry Peter, I copy/pasted the values from arm32/page.h instead of
> arm64/page.h in Xen :-/
>
> Xen is running at EL2, 64-bit (aarch64). The ATS instruction is "at
> s1e2r", used to translate Xen virtual addresses into physical addresses.
> This is what breaks.

Thanks. OK, so if we change the line in do_ats_write() from
     if (extended_addresses_enabled(env)) {
to
     if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {

does that fix your problem?

thanks
-- PMM
