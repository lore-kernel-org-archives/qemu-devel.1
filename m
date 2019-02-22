Received: from eggs.gnu.org ([209.51.188.92]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxDmU-0001nv-0s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxDmT-0000lr-5w
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:34:33 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:45826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxDmS-0000eO-QL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:34:33 -0500
Received: by mail-ot1-x335.google.com with SMTP id 32so2315688ota.12
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190222105159-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 16:34:15 +0000
Message-ID: <CAFEAcA_qwuZFYkkrZ+BavjoNs48aPuArQsFYCX5G32=JN7542Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] pci, pc, virtio: fixes, cleanups,
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 22 Feb 2019 at 15:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 22, 2019 at 03:47:36PM +0000, Peter Maydell wrote:
> > Compile failure on clang:
> >
> > /home/petmay01/linaro/qemu-for-merges/hw/virtio/virtio-balloon.c:40:3:
> > error: redefinition of typedef 'PartiallyBalloonedPage' is a C11
> > feature [-Werror,-Wtypedef-redefinition]
> > } PartiallyBalloonedPage;
> >   ^
> > /home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-balloon.h:33:39:
> > note: previous definition is here
> > typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> >                                       ^
> > 1 error generated.
> > /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> > 'hw/virtio/virtio-balloon.o' failed

> Fixed up and re-pushed.
> David, pls note above and don't add duplicate typedefs in the future.
> There's always include/qemu/typedefs.h if you don't know where
> to put a typedef.

It's an easy mistake to make, and it's only clang that complains -- I
did it myself the other week :-)

thanks
-- PMM
