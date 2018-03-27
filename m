Received: from eggs.gnu.org ([2001:4830:134:3::10]:50381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0tDQ-00077M-R9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0tDP-0006ye-Tk
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:21:00 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0tDP-0006xb-OR
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:20:59 -0400
Received: by mail-ot0-x242.google.com with SMTP id o9-v6so7542958otj.5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 11:20:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327144124.32533-1-stefanha@redhat.com>
References: <20180327144124.32533-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 19:20:38 +0100
Message-ID: <CAFEAcA-cWCf477KU3MRWvN6U9gLNoF5QxP5+AyAG90wi9-y+2A@mail.gmail.com>
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

On 27 March 2018 at 15:41, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit f58d9620aa4a514b1227074ff56eefd1334a6225:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-dt-20180326' into staging (2018-03-27 10:27:34 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to f5a53faad4bfbf1b86012a13055d2a1a774a42b6:
>
>   MAINTAINERS: add include/block/aio-wait.h (2018-03-27 13:05:48 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (4):
>   queue: add QSIMPLEQ_PREPEND()
>   coroutine: avoid co_queue_wakeup recursion
>   coroutine: add test-aio coroutine queue chaining test case
>   MAINTAINERS: add include/block/aio-wait.h
>
>  MAINTAINERS                  |   1 +
>  include/qemu/coroutine_int.h |   1 -
>  include/qemu/queue.h         |   8 ++++
>  block/io.c                   |   3 +-
>  tests/test-aio.c             |  65 ++++++++++++++++++++-----
>  util/qemu-coroutine-lock.c   |  34 -------------
>  util/qemu-coroutine.c        | 110 +++++++++++++++++++++++--------------------
>  7 files changed, 121 insertions(+), 101 deletions(-)
>

Applied, thanks.

-- PMM
