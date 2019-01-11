Received: from eggs.gnu.org ([209.51.188.92]:60495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghqkM-0007gu-1V
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghqdM-0002wF-P0
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:49:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghqdJ-0002ef-4y
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:49:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id c14so14014829wrr.0
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 22:49:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
In-Reply-To: <e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 11 Jan 2019 06:49:05 +0000
Message-ID: <CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Max Moroz <mmoroz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

On Thu, Jan 10, 2019 at 11:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/01/19 17:07, Max Moroz via Qemu-devel wrote:
> > +Oliver and Jonathan
> >
> > I'm a little confused. Do you want to fuzz QEMU or to fuzz something else
> > using QEMU? In case of the latter, there was some discussion on OSS-Fuzz
> > and (I think) even a build support was (sort of) added:
> > https://github.com/google/oss-fuzz/issues/1754
>
> We want to fuzz QEMU.
>
> The input is a sequence of operations on a PCI device or on guest
> memory, and you try and crash QEMU by passing it crazy operations.
>
> The qtest mode that Stefan mentioned provides something like a "JTAG
> over ASCII" where a testcase can inject elementary I/O operations into
> QEMU.  However, that is certainly too much for AFL to fuzz effectively;
> it would have to "learn" the qtest protocol, how to drive the PCI host
> bridge, how to setup a PCI device, and only then it would be able to
> find bugs.  So one idea would be to build another layer on top of qtest,
> that accepts higher-level operations and builds the qtest ASCII input
> from those.

Question for the oss-fuzz folks: QEMU's qtest protocol involves a
2-process architecture with a qtest process that connects to a QEMU
process.  We don't care about the code coverage/sanitizers/etc on the
test process, only the QEMU process.  The LLVMFuzzerTestOneInput()
entry point would nevertheless be in the qtest process.  Does this fit
into the oss-fuzz architecture?

Thanks,
Stefan
