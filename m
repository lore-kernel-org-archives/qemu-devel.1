Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1elJ7j-0006Ep-M5
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1elJ7g-0001Sc-Md
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:46:43 -0500
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d54c87e3-6919-2834-82a2-aab319d94b04@redhat.com>
Date: Mon, 12 Feb 2018 19:46:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180212
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/02/2018 04:40, David Gibson wrote:
> The following changes since commit c7b02d7d032d6022060e4b393827c963c93ce63f:
> 
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-090218-1' into staging (2018-02-09 16:12:34 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180212
> 
> for you to fetch changes up to 51f233ec92cdab7030cb7407dd7f009911c805b0:
> 
>   misc: introduce new mos6522 VIA device and enable it for ppc builds (2018-02-11 10:18:52 +1100)
> 
> ----------------------------------------------------------------
> ppc patch queue 2018-02-12
> 
> Here's the accumulatead ppc and pseries related patches for the last
> while.  Highlights are:
>     * A number of Macintosh / CUDA cleanups from Mark Cave-Ayland
>     * An important bug fix (missing "break;") for
>       H_GET_CPU_CHARACTERISTICS
>     * Yet another fix for SMT mode handling
>     * Assorted other cleanups and fixes
> 
> ----------------------------------------------------------------
> Daniel Henrique Barboza (1):
>       hw/ppc: rename functions in comments
> 
> Greg Kurz (1):
>       spapr: add missing break in h_get_cpu_characteristics()
> 
> Laurent Vivier (1):
>       spapr: set vsmt to MAX(8, smp_threads)
> 
> Mark Cave-Ayland (9):
>       cuda: do not use old_mmio accesses
>       cuda: don't allow writes to port output pins
>       cuda: introduce CUDAState parameter to get_counter()
>       cuda: rename frequency property to tb_frequency
>       cuda: minor cosmetic tidy-ups to get_next_irq_time()
>       cuda: don't call cuda_update() when writing to ACR register
>       cuda: set timer 1 frequency property to CUDA_TIMER_FREQ
>       cuda: factor out timebase-derived counter value and load time
>       misc: introduce new mos6522 VIA device and enable it for ppc builds

David, following patches from Mark's series are missing in your pull
request, is that normal?

  cuda: convert to use the shared mos6522 device
  ppc: move CUDAState and other CUDA-related definitions into separate
       cuda.h file
  cuda: convert to trace-events

Thanks,
Laurent
