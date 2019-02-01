Received: from eggs.gnu.org ([209.51.188.92]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpd3p-0007if-NP
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpd3k-0006wz-Bd
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:57:02 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:42715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpd3k-0006vy-5M
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:57:00 -0500
Received: by mail-oi1-x234.google.com with SMTP id w13so6495293oiw.9
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20190201160653.13829-1-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 17:56:46 +0000
Message-ID: <CAFEAcA8TXwf8J78Y=rhhvry98HoG1y7uWtKQu+V4xRScwe5j5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/47] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 1 Feb 2019 at 16:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> As promised, more Arm patches. The big thing in here is the
> MPS2-AN521 board model.
>
> thanks
> -- PMM
>
> The following changes since commit cfe6c547690b06fbce54a6d0f7b05dd7f18e36ea:
>
>   Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2019-01-31' into staging (2019-01-31 19:26:09 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190201
>
> for you to fetch changes up to 7743b70ffe7a8ce168adce2cf50ad156b1fefb8c:
>
>   tests/microbit-test: Add tests for nRF51 NVMC (2019-02-01 15:32:17 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * New machine mps2-an521 -- this is a model of the AN521 FPGA image for the MPS2 devboard
>  * Fix various places where we failed to UNDEF invalid A64 instructions
>  * Don't UNDEF a valid FCMLA on 32-bit inputs
>  * Fix some bugs in the newly-added PAuth implementation
>  * microbit: Implement NVMC non-volatile memory controller
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
