Received: from eggs.gnu.org ([2001:4830:134:3::10]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff0Mk-0005Jj-Iu
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff0Mj-0002xV-KC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff0Mj-0002we-Eb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id i12-v6so73692240oik.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:04:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180715195242.6645-1-laurent@vivier.eu>
References: <20180715195242.6645-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 11:04:03 +0100
Message-ID: <CAFEAcA9911Uro7x71sBUWZKTQoNnMPY1jCVez1V8e_icHa3OMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Linux user for 3.0 patches
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

On 15 July 2018 at 20:52, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 9277d81f5c2c6f4d0b5e47c8476eb7ee7e5c0beb:
>
>   docs: Grammar and spelling fixes (2018-07-13 10:16:04 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to 1d3d1b23e1c8f52ec431ddaa8deea1322bc25cbf:
>
>   Zero out the host's `msg_control` buffer (2018-07-15 16:04:38 +0200)
>
> ----------------------------------------------------------------
> Some fixes for linux-user:
> - workaround for CMSG_NXTHDR bug
> - two patches for ppc64/ppc64le host:
>   fix fcntl() with *LK64 commands
>   (seen when dpkg wants to lock the DB)
>   fix reserved_va alignment (ppc64 needs
>   a 64kB alignment)
> - convert a forgotten fcntl() to safe_fcntl()

Applied, thanks.

-- PMM
