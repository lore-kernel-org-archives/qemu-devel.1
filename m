Received: from eggs.gnu.org ([2001:4830:134:3::10]:44277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3fQU-0005HB-MS
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3fQT-0005Yx-Q5
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:13:58 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3fQT-0005Yl-K3
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:13:57 -0400
Received: by mail-oi0-x242.google.com with SMTP id z8-v6so18742861oix.2
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:13:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403103540.7303-1-laurent@vivier.eu>
References: <20180403103540.7303-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 11:13:36 +0100
Message-ID: <CAFEAcA8A6DVp6sjwJ=d0Z4fnG6aJLwzkdoCWNwy1b6iM0gKo=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] linux-user fixes for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 3 April 2018 at 11:35, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>
> for you to fetch changes up to 3ea7f4a226cd3a4d107772569976dbb13400a632:
>
>   linux-user: fix TARGET___O_TMPFILE for sparc (2018-04-03 11:50:24 +0200)
>
> ----------------------------------------------------------------
> Alpha and sparc32plus have broken signal frame handler.
> With these fixes, we can now:
> - with alpha target, successfully debootstrap debian sid
> - with sparc32plus target, run "ls" in a bash in a chroot without error
> ----------------------------------------------------------------
>
> Laurent Vivier (3):
>   linux-user: fix alpha signal emulation
>   linux-user: define TARGET_ARCH_HAS_KA_RESTORER
>   linux-user: fix TARGET___O_TMPFILE for sparc
>
>  linux-user/signal.c       | 8 ++++----
>  linux-user/syscall.c      | 7 +++++--
>  linux-user/syscall_defs.h | 5 +++++
>  3 files changed, 14 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
