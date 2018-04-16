Received: from eggs.gnu.org ([2001:4830:134:3::10]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f860X-0007xT-Ke
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f860W-0002ye-P5
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:25:29 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f860W-0002y2-BC
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:25:28 -0400
Received: by mail-ot0-x242.google.com with SMTP id a14-v6so17817471otf.6
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:25:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416123822.11744-1-mreitz@redhat.com>
References: <20180416123822.11744-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 16:25:07 +0100
Message-ID: <CAFEAcA9kJG-ndvRP18vkNW_sh9g4JJQtq2iobA_LCM=hsHNGKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches for 2.12.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On 16 April 2018 at 13:38, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit ae2b1b4e1bb89ea949446597c8776255da0a79d3:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2018-04-16 10:11:17 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/XanClic/qemu.git tags/pull-block-2018-04-16
>
> for you to fetch changes up to 25bf2426f3b27857afa35194227040eab821a047:
>
>   iotests: fix 169 (2018-04-16 13:35:32 +0200)
>
> ----------------------------------------------------------------
> A fix for handling dirty bitmaps stored in qcow2 files.  This is not
> absolutely necessary for 2.12, but if there is an rc4, it should go in.
>
> ----------------------------------------------------------------
> Vladimir Sementsov-Ogievskiy (2):
>   qcow2: try load bitmaps only once
>   iotests: fix 169
>
>  block/qcow2.h          |  1 +
>  block/qcow2.c          | 16 ++++++++--------
>  tests/qemu-iotests/169 | 48 +++++++++++++++++++++++++++---------------------
>  3 files changed, 36 insertions(+), 29 deletions(-)

Applied, thanks.

-- PMM
