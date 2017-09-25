Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwcG9-0000no-E6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwcG8-0002LE-Ou
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:53:53 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:54307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwcG8-0002L4-Id
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:53:52 -0400
Received: by mail-wr0-x231.google.com with SMTP id g29so10431361wrg.11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 15:53:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98UwfYcHgX0V-ghe1JhO4RjNDKa0WVWBJZM27g02rdig@mail.gmail.com>
References: <150555367996.36.15771330325496067998@69b6ddf88678>
	<20170916103523.1482-1-m.olbrich@pengutronix.de>
	<CAKmqyKP_5dC1td8DMCEM_4v74XBZy5-rWH2z4XA8VCw4165SAg@mail.gmail.com>
	<20170919082358.43upqf3lawg2aqtg@pengutronix.de>
	<CAKmqyKOeYQHRytnhzmC0Tr3rp4KU8NomgnFhhcrKE5KP75WMow@mail.gmail.com>
	<20170920061905.rbv3g2ubd4c5zvn4@pengutronix.de>
	<CAFEAcA89F3RVOyu3SPHxZiPB-ws2sQhL71e21fAGP-_TCgOC3w@mail.gmail.com>
	<CAKmqyKO19A7ZKEKkLToW23jFZH1pdtv17Y4Hj==TE7ZGGFpW6w@mail.gmail.com>
	<CAFEAcA98UwfYcHgX0V-ghe1JhO4RjNDKa0WVWBJZM27g02rdig@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 25 Sep 2017 15:53:20 -0700
Message-ID: <CAKmqyKO_z2_LVMnibA38H4Ny242UJSaZ-aOk9dZ3QHC00r+_2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/sd: fix out-of-bounds check for
 multi block reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Olbrich <m.olbrich@pengutronix.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Sep 25, 2017 at 3:38 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 September 2017 at 22:16, Alistair Francis <alistair23@gmail.com> wrote:
>> On Mon, Sep 25, 2017 at 12:27 PM, Peter Maydell
>> <peter.maydell@linaro.org> wrote:
>>> Alistair, were you planning to provide a reviewed-by: for this
>>> patch (or did you have more review comments on it)?
>>
>> Ah woops, this slipped through. Looks fine to me then.
>>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Cheers. Should we cc:stable on this too? I'm inclined towards 'yes'.

Yeah, I don't see a reason not to.

Thanks,
Alistair

>
> thanks
> -- PMM
