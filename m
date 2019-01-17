Received: from eggs.gnu.org ([209.51.188.92]:53134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkAQF-0007Gq-8k
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkAQE-0000IJ-Jy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:21:39 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkAQE-0000EC-Bp
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:21:38 -0500
Received: by mail-ot1-x336.google.com with SMTP id n8so11613145otl.6
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 08:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20190115200252.25911-1-mst@redhat.com>
	<CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
	<20190117084350-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190117084350-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 16:21:24 +0000
Message-ID: <CAFEAcA_G_og2AXsDKYnPVhRXsvMUb8MnR0yc8JzCwS4xaPJpGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 at 13:44, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 17, 2019 at 12:48:22PM +0000, Peter Maydell wrote:
> > This fails 'make check' on s390x host:

> Oh. I am pretty sure it's endian-ness :(
>
> Any chance you can quickly test the below?

Yes, that change allows the tests to pass on the s390 box.

thanks
-- PMM
