Received: from eggs.gnu.org ([2001:4830:134:3::10]:33017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIWvg-0007Kt-BF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIWvf-0003Q8-Fs
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:11:36 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:43113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIWvf-0003Pv-8E
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:11:35 -0400
Received: by mail-oi0-x230.google.com with SMTP id p62-v6so13419774oie.10
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514181928.18034-1-laurent@vivier.eu>
References: <20180514181928.18034-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:11:14 +0100
Message-ID: <CAFEAcA9p==io_-uvqbzOxTrbo2XqLzFF41eqvKrcH+zBDJ-gEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Linux user for 2.13 patches
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

On 14 May 2018 at 19:19, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit c74e62ee3e2dc2955e07d004c71badecb68a84eb:
>
>   Merge remote-tracking branch 'remotes/rth/tags/cota-target-pull-request' into staging (2018-05-11 15:41:29 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request
>
> for you to fetch changes up to f606e4d6258fa82c3f6c1cc762ebe483db5f5db6:
>
>   linux-user: correctly align types in thunking code (2018-05-14 12:01:21 +0200)
>
> ----------------------------------------------------------------
> Mostly sparc fixes, allowing to do a "debootstrap --second-stage",
> including some structures alignment fixes.
> This series fixes following LTP 20180118 tests on a x86_64 host:
> armhf:    epoll_wait02 getpriority01 nice03 pselect01 pselect01_64
> arm64:    epoll_wait02 getpriority01 nice03 poll02 pselect01 pselect01_64 select04
> s390x:    epoll_wait02 getpriority01 nice03 poll02 pselect01 pselect01_64 select04
> mips:     epoll_wait02 getpriority01 nice03 poll02 pselect01 pselect01_64
> mips64el: epoll_wait02 getpriority01 nice03 pselect01 pselect01_64 select04
> mipsel:   epoll_wait02 getpriority01 nice03 madvise06 poll02 select04
> ppc64:    epoll_wait02 getpriority01 nice03 poll02 select04
> ppc64el:  getpriority01 nice03 pselect01 select04
> sh4:      getpriority01 nice03 madvise06 poll02 pselect01 select04
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
