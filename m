Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJgLs-0002al-2T
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJgLq-0004Lc-VP
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:27:24 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJgLq-0004LA-QL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:27:22 -0400
Received: by mail-oi0-x244.google.com with SMTP id p62-v6so7259700oie.10
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:27:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518091828.12814-1-famz@redhat.com>
References: <20180518091828.12814-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 15:27:01 +0100
Message-ID: <CAFEAcA_QrAzx0+iNCnuo3HG2xa8vqgM43DWJTk_ihJwyhyNCsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 10:18, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit a4207e3b00e89f934adb231057dcf9a75ac2ae=
45:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-05-17 11:59:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>
> for you to fetch changes up to cd0a6d2b2c3d5cbf82a868d8c6c80961bcda6db5:
>
>   iothread: fix epollfd leak in the process of delIOThread (2018-05-18 17=
:09:54 +0800)
>
> ----------------------------------------------------------------
> Docker and block patches
>
> Two fairly small fixes.
>
> ----------------------------------------------------------------
>
> Jie Wang (1):
>   iothread: fix epollfd leak in the process of delIOThread
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   docker: Fix trivial typo
>
>  include/block/aio.h           |  8 ++++++++
>  tests/docker/Makefile.include |  2 +-
>  util/aio-posix.c              | 13 ++++++++++---
>  util/aio-win32.c              |  4 ++++
>  util/async.c                  |  1 +
>  5 files changed, 24 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
