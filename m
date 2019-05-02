Received: from eggs.gnu.org ([209.51.188.92]:50365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFvd-0005JZ-5u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFvc-0003hP-8m
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:55:29 -0400
MIME-Version: 1.0
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
	<0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
In-Reply-To: <0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 May 2019 10:53:26 -0700
Message-ID: <CAKmqyKNFxWDd1f-87+fODFP363Ttb3AvixLv=EWQNZj38XCjaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>

On Wed, May 1, 2019 at 7:12 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/30/19 4:28 PM, Alistair Francis wrote:
> >      for (i = 0; i < usbports; i++) {
> > +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));
>
> I would hope that it works to move this out of the loop:
>
>   g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));

Yes, that also works. I have updated the patch.

Alistair

>
>
> r~
