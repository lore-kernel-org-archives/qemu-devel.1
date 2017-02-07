Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9ag-0004L7-5g
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9af-0004Uq-8z
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:30:06 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb9af-0004Ud-2d
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:30:05 -0500
Received: by mail-wr0-x22c.google.com with SMTP id i10so42585373wrb.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 09:30:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131122416.10284-1-ppandit@redhat.com>
References: <20170131122416.10284-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 17:29:43 +0000
Message-ID: <CAFEAcA_GoD3h2tfM7R5mBQPV9V4bCkA5oKL9EYXiaGq2Gbd3DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 31 January 2017 at 12:24, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Hello,
>
> In SDHCI emulation, the 'Block Count Enable' bit of the Transfer Mode
> register is used to control 's->blkcnt' value. One, this bit is not
> relevant in single block transfers. Second, Transfer Mode register
> value could be set such that 's->blkcnt' would not see an update
> during multi block transfers. Thus leading to an infinite loop.
>
> This patch set attempts to correct 'Block Count Enable' bit usage.

Edgar, Alistair: the zynq models are our major SDHCI user -- would
you like to have a look at this patchset, please?

thanks
-- PMM
