Received: from eggs.gnu.org ([2001:4830:134:3::10]:49084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxy0G-0002KM-Kj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxy0F-0004N3-JL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:46:48 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxy0F-0004MH-BQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:46:47 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t189so4320292wmt.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:46:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411134435.27271-1-mreitz@redhat.com>
References: <20170411134435.27271-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 16:46:25 +0100
Message-ID: <CAFEAcA9Fj0UUSEf6k_RAagN58E-CC-px15kM67raP2E1B-=qsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] Block patches for 2.9.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 14:44, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit aa388ddc36e8032f41cd17bef88cc3ebaeba77c9:
>
>   Merge remote-tracking branch 'remotes/famz/tags/block-pull-request' into staging (2017-04-11 13:27:05 +0100)
>
> are available in the git repository at:
>
>   git://github.com/XanClic/qemu.git tags/pull-block-2017-04-11
>
> for you to fetch changes up to 2ec9a782d159e2bc6655fc0b783deda197bbe0b7:
>
>   iscsi: Fix iscsi_create (2017-04-11 15:33:00 +0200)
>
> ----------------------------------------------------------------
> Block patches for 2.9.0-rc4
>
> ----------------------------------------------------------------
> Dong Jia Shi (1):
>       block: pass the right options for BlockDriver.bdrv_open()
>
> Eric Blake (1):
>       throttle: Remove block from group on hot-unplug
>
> Fam Zheng (1):
>       iscsi: Fix iscsi_create
>
>  block/block-backend.c |  3 +++
>  block/iscsi.c         | 10 ++++++++--
>  block/snapshot.c      | 26 +++++++++++++++++++++++---
>  3 files changed, 34 insertions(+), 5 deletions(-)

Applied, thanks.

-- PMM
