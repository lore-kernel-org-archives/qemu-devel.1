Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eviKW-000086-QU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eviKV-0006gH-T3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:42:56 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eviKV-0006fs-NT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:42:55 -0400
Received: by mail-ot0-x241.google.com with SMTP id h8so18596966oti.6
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 04:42:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312160125.7596-1-stefanha@redhat.com>
References: <20180312160125.7596-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 11:42:34 +0000
Message-ID: <CAFEAcA9zfh+QXf_DFW+LyNnMVkQpZzZD5cCmG5jaeKpPHQ3Jrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 12 March 2018 at 16:01, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 7376eda7c2e0451e819e81bd05fabc56a9deb946:
>
>   block: make BDRV_POLL_WHILE() re-entrancy safe (2018-03-12 11:07:37 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   block: make BDRV_POLL_WHILE() re-entrancy safe
>
>  include/block/aio-wait.h | 61 ++++++++++++++++++++++++------------------------
>  util/aio-wait.c          |  2 +-
>  2 files changed, 31 insertions(+), 32 deletions(-)

Applied, thanks.

-- PMM
