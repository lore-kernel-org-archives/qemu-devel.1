Received: from eggs.gnu.org ([209.51.188.92]:34410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtcaj-0001yo-M9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtca8-0006qP-1j
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:14:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gtca7-0006i5-Rv
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:14:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so6028842otk.8
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20190212141234.2814-1-stefanha@redhat.com>
	<CAFEAcA_3T9zVLm8DmOdFk=FddEMuQ4NzfTNhQhh5mB+swYyDvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_3T9zVLm8DmOdFk=FddEMuQ4NzfTNhQhh5mB+swYyDvQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 12 Feb 2019 19:14:37 +0100
Message-ID: <CAGxU2F4H4DvAz8A3-zOJ3eeiKg-8+TZBiNK=JJe6cJasRA=YHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PULL 0/6] Block sgarzare test patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Tue, Feb 12, 2019 at 6:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 14:12, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > ----------------------------------------------------------------
> > Block pull request for testing
> >
> > Peter hit a virtio-blk-test failure caused by the new DISCARD/WRITE_ZEROES
> > patches that Stefano and I have been unable to reproduce.  Here are the patches
> > so they can be tested again in Peter's environment.
> >
> > ----------------------------------------------------------------
>
> x86-64 host seems to be a bit random about whether it reproducibly
> fails (it failed in the test merge builds but not when I run the
> test program by hand) but aarch64 host seems more definitely
> fails-every-time:
>
> pm215@gcc113:~/qemu/build/all$
> QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 strace -tt -f -o
> ~/strace.log  tests/virtio-blk-test
> /ppc64/virtio/blk/pci/basic: **
> ERROR:/home/pm215/qemu/tests/virtio-blk-test.c:272:test_basic:
> assertion failed (status == 0): (1 == 0)
> Aborted (core dumped)
>
> The strace.log from that is at
> http://people.linaro.org/~peter.maydell/strace.log
> (3.6MB file; the -f means it will have the trace for
> both the test binary and the QEMU process it spawns).
>
> thanks
> -- PMM

I found the error. I forgot the endianness in the test, so now it
works on ppc64 guest and x86_64 host.
Maybe the randomness of the fails was the different endianness between
guest and host.

I'll send a v5 of the series with the fix.

Thanks and sorry for that,
Stefano
