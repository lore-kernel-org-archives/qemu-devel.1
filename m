Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEW1Y-0002di-U7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEW1X-0006sB-T5
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:25:04 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEW1X-0006ru-O0
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:25:03 -0400
Received: by mail-oi0-x243.google.com with SMTP id c203-v6so18456234oib.7
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 01:25:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 09:24:42 +0100
Message-ID: <CAFEAcA9XOeazu7KB5G8oNyrsAdSTvgii+nPmhf7Wq-RdSZeBwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 3 May 2018 at 19:21, Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
> The following changes since commit 59255887e6cafeff747250d2613003a41d1d9dff:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180502' into staging (2018-05-03 11:25:14 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to fe355cbda28b5e3dfc6a70b902343b84c466aa17:
>
>   MAINTAINERS: update Marcel Apfelbaum email (2018-05-03 20:52:29 +0300)
>
> ----------------------------------------------------------------
> * fix PVRDMA coverity errors
> * update MAINTAINERS file
>
> ----------------------------------------------------------------
> Marcel Apfelbaum (4):
>       hw/rdma: Fix possible munmap call on a NULL pointer
>       hw/rdma: Fix possible usage of a NULL pointer
>       hw/rdma: Fix possible out of bounds access to port GID index
>       MAINTAINERS: update Marcel Apfelbaum email
>
> Yuval Shaia (4):
>       hw/rdma: Delete port's pkey table
>       hw/rdma: Fix possible out of bounds access to GID table
>       hw/rdma: Fix possible out of bounds access to regs array
>       hw/rdma: Delete duplicate definition of MAX_RM_TBL_NAME

Applied, thanks.

-- PMM
