Received: from eggs.gnu.org ([209.51.188.92]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIDZ-0005Ys-4K
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIDY-0008Hl-4f
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:43:05 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:43316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzIDX-0008H5-MC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:43:04 -0500
Received: by mail-ot1-x32b.google.com with SMTP id n71so17075597ota.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 01:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20190225152053.15976-1-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 09:42:51 +0000
Message-ID: <CAFEAcA_L0QkSBn6vpOHoMT4sdv7rKat28pzHQ96fNcWR=0d5vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/71] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 25 Feb 2019 at 15:21, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 59a568b57848b10e8a44518a889323f12ccdd8f4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190222-pull-request' into staging (2019-02-25 12:49:07 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1b967e9f348d48788a2ab481d45398b80ce71fa6:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2019-02-25' into queue-block (2019-02-25 15:16:57 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Block graph change fixes (avoid loops, cope with non-tree graphs)
> - bdrv_set_aio_context() related fixes
> - HMP snapshot commands: Use only tag, not the ID to identify snapshots
> - qmeu-img, commit: Error path fixes
> - block/nvme: Build fix for gcc 9
> - MAINTAINERS updates
> - Fix various issues with bdrv_refresh_filename()
> - Fix various iotests
> - Include LUKS overhead in qemu-img measure for qcow2
> - A fix for vmdk's image creation interface
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
