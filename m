Received: from eggs.gnu.org ([2001:4830:134:3::10]:52038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL5G7-00007K-1R
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL5Fz-0002S6-EZ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:47:25 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gL5Ft-00026L-O7
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:47:19 -0500
Received: by mail-oi1-x232.google.com with SMTP id i138-v6so1232908oib.1
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 03:47:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108204111.786455-1-groug@kaod.org>
References: <20181108204111.786455-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 11:46:45 +0000
Message-ID: <CAFEAcA8E_Yd-6cPsstWUqyQ=RVpyHa99R3X=PYFSe_P-y3nWvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] 9p fixes for v3.1.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 November 2018 at 20:41, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit a7ce790a029bd94eb320d8c69f38900f5233997e:
>
>   tcg/tcg-op.h: Add multiple include guard (2018-11-08 15:15:32 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5b76ef50f62079a2389ba28cacaf6cce68b1a0ed:
>
>   9p: write lock path in v9fs_co_open2() (2018-11-08 21:19:05 +0100)
>
> ----------------------------------------------------------------
> Fixes a potential use-after-free issue that could be triggered by a
> misbehaving guest.
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       9p: write lock path in v9fs_co_open2()
>
>  hw/9pfs/cofile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
