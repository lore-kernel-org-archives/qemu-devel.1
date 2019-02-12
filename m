Received: from eggs.gnu.org ([209.51.188.92]:44572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtbTz-0005pQ-45
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtbTp-0005wz-1d
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:04:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtbTo-0005vE-M1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:04:20 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so5712604otl.0
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 09:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20190212141234.2814-1-stefanha@redhat.com>
In-Reply-To: <20190212141234.2814-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 17:04:07 +0000
Message-ID: <CAFEAcA_3T9zVLm8DmOdFk=FddEMuQ4NzfTNhQhh5mB+swYyDvQ@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefano Garzarella <sgarzare@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Tue, 12 Feb 2019 at 14:12, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> ----------------------------------------------------------------
> Block pull request for testing
>
> Peter hit a virtio-blk-test failure caused by the new DISCARD/WRITE_ZEROES
> patches that Stefano and I have been unable to reproduce.  Here are the patches
> so they can be tested again in Peter's environment.
>
> ----------------------------------------------------------------

x86-64 host seems to be a bit random about whether it reproducibly
fails (it failed in the test merge builds but not when I run the
test program by hand) but aarch64 host seems more definitely
fails-every-time:

pm215@gcc113:~/qemu/build/all$
QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 strace -tt -f -o
~/strace.log  tests/virtio-blk-test
/ppc64/virtio/blk/pci/basic: **
ERROR:/home/pm215/qemu/tests/virtio-blk-test.c:272:test_basic:
assertion failed (status == 0): (1 == 0)
Aborted (core dumped)

The strace.log from that is at
http://people.linaro.org/~peter.maydell/strace.log
(3.6MB file; the -f means it will have the trace for
both the test binary and the QEMU process it spawns).

thanks
-- PMM
