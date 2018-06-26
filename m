Received: from eggs.gnu.org ([2001:4830:134:3::10]:53456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXsYw-00031F-35
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXsYv-0001gF-7a
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:34 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:41898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXsYv-0001g6-1s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:33 -0400
Received: by mail-ot0-x22d.google.com with SMTP id d19-v6so20068333oti.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:19:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 19:19:11 +0100
Message-ID: <CAFEAcA8vm341HSotwYEjOdib90i8stOq46U1W+S_cepvVPWJfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 26 June 2018 at 17:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue: mostly smallish stuff. I expect to send
> out another pullreq at the end of this week, but since this
> is up to 32 patches already I'd rather send it out now
> than accumulate a monster sized patchset.
>
> thanks
> -- PMM
>
>
> The following changes since commit 0ab4c574a55448a37b9f616259b82950742c9427:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180626-pull-request' into staging (2018-06-26 16:44:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180626
>
> for you to fetch changes up to 9b945a9ee36a34eaeca412ef9ef35fbfe33c2c85:
>
>   aspeed/timer: use the APB frequency from the SCU (2018-06-26 17:50:42 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * aspeed: set APB clocks correctly (fixes slowdown on palmetto)
>  * smmuv3: cache config data and TLB entries
>  * v7m/v8m: support read/write from MPU regions smaller than 1K
>  * various: clean up logging/debug messages
>  * xilinx_spips: Make dma transactions as per dma_burst_size
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
