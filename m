Received: from eggs.gnu.org ([2001:4830:134:3::10]:51832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpFuo-0000yt-30
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpFue-0008GM-DD
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:37:26 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpFue-0008Eo-4I
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:37:16 -0400
Received: by mail-wr0-x22f.google.com with SMTP id y15so9578906wrc.2
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:37:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905132908.30931-1-stefanha@redhat.com>
References: <20170905132908.30931-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 16:36:54 +0100
Message-ID: <CAFEAcA8iis1JEgUzF=eS2HTc1t29F+CNDaw=zg5bQy9mdhhy9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Block patches
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

On 5 September 2017 at 14:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 2b483739791b33c46e6084b51edcf62107058ae1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170904-2' into staging (2017-09-04 17:21:24 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to b461151ff31c7925f271c297e8abed20231ac7d3:
>
>   block: document semantics of bdrv_co_preadv|pwritev (2017-09-05 11:07:02 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   block: document semantics of bdrv_co_preadv|pwritev
>
> Stefan Hajnoczi (3):
>   qemu.py: make VM() a context manager
>   iotests.py: add FilePath context manager
>   qemu-iotests: use context managers for resource cleanup in 194
>
>  include/block/block_int.h     |  31 +++++++++++
>  scripts/qemu.py               |  16 +++++-
>  tests/qemu-iotests/194        | 117 +++++++++++++++++++++---------------------
>  tests/qemu-iotests/iotests.py |  26 ++++++++++
>  4 files changed, 130 insertions(+), 60 deletions(-)

Applied, thanks.

-- PMM
