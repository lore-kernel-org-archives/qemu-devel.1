Received: from eggs.gnu.org ([2001:4830:134:3::10]:48783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwVkU-0006av-PP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwVkT-0008Ew-Mh
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:24:30 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:34588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwVkT-0008EG-Ga
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:24:29 -0400
Received: by mail-wm0-x236.google.com with SMTP id w204so279252wmd.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:24:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Apr 2017 16:24:07 +0100
Message-ID: <CAFEAcA_u223rHUL=fqVQBQBArL+Xr-hrKiNfpgPncip=vNUKpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/10] Block layer fixes for 2.9.0-rc4
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

On 7 April 2017 at 14:47, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 5fe2339e6b09da7d6f48b9bef0f1a7360392b489:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170406.0' into staging (2017-04-07 10:29:56 +0100)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 19dd29e8a77cd820515de5289f566508e0ed4926:
>
>   mirror: Fix aio context of mirror_top_bs (2017-04-07 14:44:06 +0200)
>
> ----------------------------------------------------------------
> Block layer fixes for 2.9.0-rc4
>
> ----------------------------------------------------------------
> Fam Zheng (3):
>       block: Fix unpaired aio_disable_external in external snapshot
>       block: Assert attached child node has right aio context
>       mirror: Fix aio context of mirror_top_bs
>
> Jeff Cody (1):
>       qemu-img: img_create does not support image-opts, fix docs
>
> Kevin Wolf (4):
>       block: Ignore guest dev permissions during incoming migration
>       commit: Set commit_top_bs->aio_context
>       commit: Set commit_top_bs->total_sectors
>       block: Don't check permissions for copy on read
>
> Max Reitz (2):
>       block/mirror: Fix use-after-free
>       iotests: Add mirror tests for orphaned source

Applied, thanks.

-- PMM
