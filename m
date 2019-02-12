Received: from eggs.gnu.org ([209.51.188.92]:56123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtTAd-00089l-5C
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 03:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtTAb-0001D3-Q3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 03:11:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gtTAb-0000vB-FH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 03:11:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so1941220wmt.0
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 00:11:41 -0800 (PST)
Date: Tue, 12 Feb 2019 09:11:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190212081136.uwa2gqyy2w37jlix@steredhat>
References: <20190211055040.13528-1-stefanha@redhat.com>
	<CAFEAcA-pkOanLBVCry15tSH3dMp-Kuby675LYd6wGidh6E1Wig@mail.gmail.com>
	<20190212035118.GD28401@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212035118.GD28401@stefanha-x1.localdomain>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Feb 12, 2019 at 11:51:18AM +0800, Stefan Hajnoczi wrote:
> On Mon, Feb 11, 2019 at 11:42:14AM +0000, Peter Maydell wrote:
> > 
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
> 

Hi Stefan,
I'll debug it! I also have a macOS here, so I'll try on it.

Thanks,
Stefano
