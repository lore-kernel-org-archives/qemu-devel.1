Received: from eggs.gnu.org ([2001:4830:134:3::10]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwc1i-0005qc-DS
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwc1h-0005KZ-Ji
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:38:58 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:55246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwc1h-0005KI-DT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:38:57 -0400
Received: by mail-wr0-x22d.google.com with SMTP id g29so10390835wrg.11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 15:38:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKO19A7ZKEKkLToW23jFZH1pdtv17Y4Hj==TE7ZGGFpW6w@mail.gmail.com>
References: <150555367996.36.15771330325496067998@69b6ddf88678>
	<20170916103523.1482-1-m.olbrich@pengutronix.de>
	<CAKmqyKP_5dC1td8DMCEM_4v74XBZy5-rWH2z4XA8VCw4165SAg@mail.gmail.com>
	<20170919082358.43upqf3lawg2aqtg@pengutronix.de>
	<CAKmqyKOeYQHRytnhzmC0Tr3rp4KU8NomgnFhhcrKE5KP75WMow@mail.gmail.com>
	<20170920061905.rbv3g2ubd4c5zvn4@pengutronix.de>
	<CAFEAcA89F3RVOyu3SPHxZiPB-ws2sQhL71e21fAGP-_TCgOC3w@mail.gmail.com>
	<CAKmqyKO19A7ZKEKkLToW23jFZH1pdtv17Y4Hj==TE7ZGGFpW6w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 23:38:35 +0100
Message-ID: <CAFEAcA98UwfYcHgX0V-ghe1JhO4RjNDKa0WVWBJZM27g02rdig@mail.gmail.com>
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
To: Alistair Francis <alistair23@gmail.com>
Cc: Michael Olbrich <m.olbrich@pengutronix.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 25 September 2017 at 22:16, Alistair Francis <alistair23@gmail.com> wrote:
> On Mon, Sep 25, 2017 at 12:27 PM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> Alistair, were you planning to provide a reviewed-by: for this
>> patch (or did you have more review comments on it)?
>
> Ah woops, this slipped through. Looks fine to me then.
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Cheers. Should we cc:stable on this too? I'm inclined towards 'yes'.

thanks
-- PMM
