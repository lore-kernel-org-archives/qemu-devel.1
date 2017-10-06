Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0VkE-0002ZC-Gh
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0VkD-0000Az-OL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:45:02 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:52974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0VkD-00009v-JK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:45:01 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k62so13413599wrc.9
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 09:45:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 17:44:39 +0100
Message-ID: <CAFEAcA-=d2eTaZSzsZKAujOXbJFNreLYND91cQMEqJGch_9RkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 6 October 2017 at 16:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> Mostly my stuff with a few easy patches from others. I know I have
> a few big series in my to-review queue, but I've been too jetlagged
> to try to tackle those :-(
>
> thanks
> -- PMM
>
> The following changes since commit a26a98dfb9d448d7234d931ae3720feddf6f0651:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20171006' into staging (2017-10-06 13:19:03 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171006
>
> for you to fetch changes up to 04829ce334bece78d4fa1d0fdbc8bc27dae9b242:
>
>   nvic: Add missing code for writing SHCSR.HARDFAULTPENDED bit (2017-10-06 16:46:49 +0100)
>
> ----------------------------------------------------------------
> target-arm:
>  * v8M: more preparatory work
>  * nvic: reset properly rather than leaving the nvic in a weird state
>  * xlnx-zynqmp: Mark the "xlnx, zynqmp" device with user_creatable = false
>  * sd: fix out-of-bounds check for multi block reads
>  * arm: Fix SMC reporting to EL2 when QEMU provides PSCI
>

Applied, thanks.

-- PMM
