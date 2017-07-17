Received: from eggs.gnu.org ([2001:4830:134:3::10]:46951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX8y5-0007q0-Fb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX8y4-0003UR-KP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:33:57 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX8y4-0003TN-D5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:33:56 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t70so20763936wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:33:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 17:33:34 +0100
Message-ID: <CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 14 June 2017 at 18:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> Paolo suggested offline that we send a pull request for this series.
> Here it is, I've run it through my testsuite + tested the LQSPI testcase
> on Zynq.

> ----------------------------------------------------------------
> mmio-exec.for-upstream
>
> ----------------------------------------------------------------
> KONRAD Frederic (7):
>       cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
>       cputlb: move get_page_addr_code
>       cputlb: fix the way get_page_addr_code fills the tlb
>       qdev: add MemoryRegion property
>       introduce mmio_interface
>       exec: allow to get a pointer for some mmio memory region
>       xilinx_spips: allow mmio execution

Hi Edgar -- can you or Fred explain how this code interacts with
VM migration? The mmio-interface device creates a RAM memory
region with memory_region_init_ram_ptr(), but it doesn't call
vmstate_register_ram(). On the other hand the core migration code
will try to migrate the contents of the RAMBlock anyway, just
without a name.

It's not clear to me how this works, and it would be nice to
get it clear so that we can make any necessary fixes before the
2.10 release hits and we lose the opportunity to make any
migration-compatibility-breaking changes.

thanks
-- PMM
