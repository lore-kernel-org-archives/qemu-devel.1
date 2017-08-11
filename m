Received: from eggs.gnu.org ([2001:4830:134:3::10]:49998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dg5Ll-0008RC-J4
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dg5Lk-0000wa-F7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:31:21 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dg5Lk-0000uz-69
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:31:20 -0400
Received: by mail-wm0-x235.google.com with SMTP id t201so36578134wmt.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 01:31:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170810174824.9580-1-stefanha@redhat.com>
References: <20170810174824.9580-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2017 09:30:58 +0100
Message-ID: <CAFEAcA_ZLapAkp7W+VqP1zCQzuJLq_j8UviFr_qSp-oWZB+WMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 August 2017 at 18:48, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit b38df311c174c98ef8cce7dec9f46603b083018e:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170809' into staging (2017-08-10 11:12:36 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 17d0bc01bfcce0ad4fb5105d4502595224569ff0:
>
>   virtio-blk: handle blk_getlength() errors (2017-08-10 14:33:43 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Kevin Wolf (1):
>   IDE: test flush on empty CDROM
>
> Stefan Hajnoczi (2):
>   IDE: Do not flush empty CDROM drives
>   virtio-blk: handle blk_getlength() errors
>
>  hw/block/virtio-blk.c |  4 +++-
>  hw/ide/core.c         | 10 +++++++++-
>  tests/ide-test.c      | 19 +++++++++++++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> --

Applied, thanks.

-- PMM
