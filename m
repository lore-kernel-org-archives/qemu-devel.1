Received: from eggs.gnu.org ([209.51.188.92]:33588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gt9yo-0004E3-55
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gt9ym-00029D-HS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:42:30 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gt9yk-00028J-Qi
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:42:28 -0500
Received: by mail-ot1-x32d.google.com with SMTP id z19so12858642otm.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20190211055040.13528-1-stefanha@redhat.com>
In-Reply-To: <20190211055040.13528-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Feb 2019 11:42:14 +0000
Message-ID: <CAFEAcA-pkOanLBVCry15tSH3dMp-Kuby675LYd6wGidh6E1Wig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On Mon, 11 Feb 2019 at 05:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit e47f81b617684c4546af286d307b69014a83538a:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-02-07 18:53:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 55140166667bb555c5d05165b93b25557d2e6397:
>
>   tests/virtio-blk: add test for WRITE_ZEROES command (2019-02-11 11:58:17 +0800)
>
> ----------------------------------------------------------------
> Pull request
>
> User-visible changes:
>
>  * virtio-blk: DISCARD and WRITE_ZEROES support

Hi; this fails to pass "make check" (all platforms):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
tests/virtio-blk-test -m
=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="virtio-blk-test"
**
ERROR:/home/pm215/qemu/tests/virtio-blk-test.c:272:test_basic:
assertion failed (status == 0): (1 == 0)
ERROR - too few tests run (expected 1, got 0)

thanks
-- PMM
