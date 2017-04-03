Received: from eggs.gnu.org ([2001:4830:134:3::10]:44842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cuz1s-0001UR-LK
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cuz1r-00076C-RH
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:16:08 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cuz1r-000747-KP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:16:07 -0400
Received: by mail-wr0-x231.google.com with SMTP id l43so164036559wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 03:16:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170401012508.24665-1-jcody@redhat.com>
References: <20170401012508.24665-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 11:15:44 +0100
Message-ID: <CAFEAcA81XBm9Yxd6o+RQu3J6d3uzrkUMcG-hzkxVdhiwCx5GLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 1 April 2017 at 02:25, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 95b31d709ba343ad237c3630047ee7438bac4065:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170331.0' into staging (2017-03-31 18:06:13 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 34634ca28688652198f77d7001c0f1e204434663:
>
>   block/curl: Check protocol prefix (2017-03-31 15:53:22 -0400)
>
> ----------------------------------------------------------------
> Block patches for -rc3
> ----------------------------------------------------------------
>
> Eric Blake (1):
>   rbd: Fix regression in legacy key/values containing escaped :
>
> Max Reitz (2):
>   qapi/curl: Extend and fix blockdev-add schema
>   block/curl: Check protocol prefix
>
>  block/curl.c         |  10 +++++
>  block/rbd.c          |  83 +++++++++++++++++++++--------------------
>  qapi/block-core.json | 103 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 146 insertions(+), 50 deletions(-)

Applied, thanks.

-- PMM
