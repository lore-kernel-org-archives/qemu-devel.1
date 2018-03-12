Received: from eggs.gnu.org ([2001:4830:134:3::10]:48329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNFx-0007O3-Rg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNFt-0005YD-6q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:49 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:46513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNFt-0005XF-1Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:45 -0400
Received: by mail-oi0-x22e.google.com with SMTP id x12so12223555oie.13
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:12:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <053e7d2f-a551-793f-c990-d742de98a54a@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
	<053e7d2f-a551-793f-c990-d742de98a54a@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:12:12 +0000
Message-ID: <CAFEAcA8gP2q-23igwWJP4EAfmh2YZCYTdm4a0_wPSw3bxQuJbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 12:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 03/09/2018 06:03 PM, Peter Maydell wrote:
>> Previously we were writing 0x00, 0x01 to the first 2 bytes of data;
>> now we will write 0x01, 0x00. Are you sure that's right ? I guess
>> it's the difference between claiming 1mA and 256mA.
>> (I can't make any sense of the table in the spec so I have no idea.)
>
> Good catch. I'm not sure which default value we want here, I doubt 256
> mA matches the card used, but the hw tests pass so I'll keep it.
> We might change it to a property later.

Do the tests fail if we report 1mA ? If not, then I'd prefer us
to keep the current behaviour. (QEMU's implementation obviously
has no current draw limits, so reporting the lowest possible value
means we won't ever accidentally cause the guest to think it
can't do something because the current requirement is too high.)

thanks
-- PMM
