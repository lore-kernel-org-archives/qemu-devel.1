Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faKlT-0002aJ-1w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faKlS-0000wd-Ap
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:50:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faKlS-0000up-59
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:50:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so3524993ois.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 05:50:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703034655.792039-1-jcody@redhat.com>
References: <20180703034655.792039-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 13:50:16 +0100
Message-ID: <CAFEAcA_=msuB7gCwBDQkk9Vz6cVy7rdJ+Z7cpW2+q9ifDSO-UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 3 July 2018 at 04:46, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 9ded4a0114968e98b41494fc035ba14f84cdf700:
>
>   backup: Use copy offloading (2018-07-02 23:23:45 -0400)
>
> ----------------------------------------------------------------
> Block backup patches
> ----------------------------------------------------------------
>
> Fam Zheng (3):
>   block: Fix parameter checking in bdrv_co_copy_range_internal
>   block: Honour BDRV_REQ_NO_SERIALISING in copy range
>   backup: Use copy offloading
>
>  block/backup.c        | 150 ++++++++++++++++++++++++++++++------------
>  block/io.c            |  35 +++++-----
>  block/trace-events    |   1 +
>  include/block/block.h |   5 +-
>  4 files changed, 132 insertions(+), 59 deletions(-)

Applied, thanks.

-- PMM
