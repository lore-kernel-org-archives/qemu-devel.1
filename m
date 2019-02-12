Received: from eggs.gnu.org ([209.51.188.92]:45511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtUhJ-0007WP-L3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtUhF-0002Rp-H3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:49:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtUh7-00021c-Tz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:49:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so3408101otk.3
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 01:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20190211055040.13528-1-stefanha@redhat.com>
	<CAFEAcA-pkOanLBVCry15tSH3dMp-Kuby675LYd6wGidh6E1Wig@mail.gmail.com>
	<20190212035118.GD28401@stefanha-x1.localdomain>
In-Reply-To: <20190212035118.GD28401@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 09:49:12 +0000
Message-ID: <CAFEAcA8YK1q7vawTgiFL7QpakHpTRm34qZWvNzbHeXG8X6ENxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 0/9] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 12 Feb 2019 at 03:51, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, Feb 11, 2019 at 11:42:14AM +0000, Peter Maydell wrote:
> > Hi; this fails to pass "make check" (all platforms):
> >
> > MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
> > tests/virtio-blk-test -m
> > =quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> > --test-name="virtio-blk-test"
> > **
> > ERROR:/home/pm215/qemu/tests/virtio-blk-test.c:272:test_basic:
> > assertion failed (status == 0): (1 == 0)
> > ERROR - too few tests run (expected 1, got 0)
>
> Stefano, I'm dropping the virtio-blk DISCARD/WRITE_ZEROES series.
> Please debug this failure.
>
> I cannot reproduce it on a Linux host so maybe it's related to macOS.
> First I thought it's because write zeroes is not supported on macOS, but
> QEMU should fall back to writing a bounce buffer of zeroes.

The test failed everywhere, including the Linux platforms, not just OSX.

thanks
-- PMM
