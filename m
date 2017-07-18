Received: from eggs.gnu.org ([2001:4830:134:3::10]:51930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXSK4-0001lC-EU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXSK3-00025o-Iv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:13:56 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXSK3-00023k-BW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:13:55 -0400
Received: by mail-wr0-x231.google.com with SMTP id y43so28885676wrd.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 06:13:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717154026.32697-1-stefanha@redhat.com>
References: <20170717154026.32697-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 14:13:33 +0100
Message-ID: <CAFEAcA_E7oyJyEDLXtS2Va4xVNBK3iGfn=2DRzJaT3JYgfRO6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 16:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e25:
>
>   vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 593ed6f0a3c827a13a274e47f6fa980344234f9c:
>
>   block: fix shadowed variable in bdrv_co_pdiscard (2017-07-17 15:58:37 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Alistair Francis (1):
>   util/aio-win32: Only select on what we are actually waiting for
>
> Denis V. Lunev (1):
>   block: fix shadowed variable in bdrv_co_pdiscard
>
>  block/io.c       |  1 -
>  util/aio-win32.c | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
