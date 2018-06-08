Received: from eggs.gnu.org ([2001:4830:134:3::10]:41089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRGIB-0003M5-JK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRGIA-0007vS-O1
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:14:55 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRGIA-0007ut-IQ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:14:54 -0400
Received: by mail-oi0-x244.google.com with SMTP id i205-v6so11634193oib.1
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:14:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180607180641.874-1-f4bug@amsat.org>
References: <20180607180641.874-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 13:14:33 +0100
Message-ID: <CAFEAcA9N9XyQrU9Y1XmgLDU9viUB1+U8iQH5QguAkxzqop4piw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] sdcard: cleanup the SD_SPEC version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 7 June 2018 at 19:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Since v2:
> - heavy documentation improvements
> - squashed previous 3+4 "add spec_version property default to v2" for ato=
micity
> - SSI/SD patch downgraded to RFC
> - added Alistair R-b tags

> Philippe Mathieu-Daud=C3=A9 (7):
>   sdcard: Update the Configuration Register (SCR) to Spec Version 1.10
>   sdcard: Allow commands valid in SPI mode
>   sdcard: Add a 'spec_version' property, default to Spec v2.00
>   sdcard: Disable SEND_IF_COND (CMD8) for Spec v1
>   sdcard: Reflect when the Spec v3 is supported in the Config Register (S=
CR)
>   sdcard: Disable CMD19/CMD23 for Spec v2
>   hw/sd/ssi-sd: Force cards connected in SPI mode to use Spec v1.10

Hi; I've applied patches 1-6 to target-arm.next. 7 I had a
question about.

thanks
-- PMM
