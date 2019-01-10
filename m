Received: from eggs.gnu.org ([209.51.188.92]:49731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghfKd-0003u1-A2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghfKY-0002ch-8R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:45:29 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghfKV-0002Yp-C9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:45:24 -0500
Received: by mail-oi1-x22e.google.com with SMTP id v6so10126165oif.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20190110083737.5036-1-laurent@vivier.eu>
In-Reply-To: <20190110083737.5036-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 18:45:09 +0000
Message-ID: <CAFEAcA8sfEbEGEqKguXsqKJwapRZzUBi=_QEV6LcMe=mf_x0mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Linux user for 4.0 patches
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

On Thu, 10 Jan 2019 at 09:01, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request
>
> for you to fetch changes up to 2bd3f8998e1e7dcd9afc29fab252fb9936f9e956:
>
>   linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0 (2019-01-10 09:36:41 +0100)
>
> ----------------------------------------------------------------
> Minor linux-user update (2019-01-10)
> Fixes LTP tests pwrite03 and pwrite03_64
>
> ----------------------------------------------------------------
>
> Peter Maydell (1):
>   linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0
>
> Tom Deseyn (1):
>   Add getsockopt for settable SOL_IPV6 options
>
>  linux-user/syscall.c | 61 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 4 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
