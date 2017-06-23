Received: from eggs.gnu.org ([2001:4830:134:3::10]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOMF9-00030f-6k
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOMF8-0002Wx-Ei
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:55:15 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOMF8-0002Wi-7Q
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:55:14 -0400
Received: by mail-wr0-x22a.google.com with SMTP id c11so60363873wrc.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 03:55:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 11:54:52 +0100
Message-ID: <CAFEAcA9OibH=kz7iTc95YBgHM1WGOdHRYSsudx=OfaBHHZbJrg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 14 June 2017 at 18:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Hi,
>
> Paolo suggested offline that we send a pull request for this series.
> Here it is, I've run it through my testsuite + tested the LQSPI testcase
> on Zynq.
>
> Cheers,
> Edgar
>
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/mmio-exec.for-upstream
>
> for you to fetch changes up to 63ef40dd6bc6cfdae5fa67ccac1cb11e7a5161b0:
>
>   xilinx_spips: allow mmio execution (2017-06-14 17:31:08 +0200)
>
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

Hi Edgar -- since these patches have come via your tree they should
have your signed-off-by line, not just Fred's. They also seem to
still have all the V1->V2->V3 revision notes in the commit logs.

I'd be happier with a reviewed-by: from somebody for the exec:
patch, if possible...

thanks
-- PMM
