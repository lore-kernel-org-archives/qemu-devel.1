Received: from eggs.gnu.org ([209.51.188.92]:35334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwkRo-0006tP-C2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwkRn-0001dI-BZ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:15:16 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwkRl-0000tT-L8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:15:15 -0500
Received: by mail-ot1-x344.google.com with SMTP id t7so27906973otk.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 01:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
	<alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
	<CAFEAcA84=uU8XTy=4jXdM80XBnn3CS0gJxspakhZpdxWnvo_+A@mail.gmail.com>
	<alpine.BSF.2.21.9999.1902202345230.9479@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1902210138340.95753@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1902210138340.95753@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 09:14:54 +0000
Message-ID: <CAFEAcA8rrUTda-TVwOmf8L0aU4FpYPHsBcjGFhyydb9=WYywsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 21 Feb 2019 at 00:51, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 21 Feb 2019, BALATON Zoltan wrote:
> > On Tue, 19 Feb 2019, Peter Maydell wrote:
> >> On Tue, 12 Feb 2019 at 23:59, BALATON Zoltan <balaton@eik.bme.hu> wrot=
e:
> >>> On Tue, 12 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> I'd have use a pair of extract32/deposit32 but this is probably easi=
er
>
> By the way, should these lines in include/qemu/bitops.h have 1ULL instead=
 of 1UL?
>
> 22 #define BIT(nr)                 (1UL << (nr))
> 23 #define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))

No, those are part of the bitmap API borrowed from the Linux
kernel, which works on bitmaps defined as arrays of "unsigned long"
values. (These are an annoying mismatch with how QEMU generally
prefers to work in types of well-defined sizes, but they are what
they are.)

thanks
-- PMM
