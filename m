Received: from eggs.gnu.org ([2001:4830:134:3::10]:43467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq08p-0001RY-28
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq08o-0003jq-7B
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:03:30 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpxm4-0001To-GP
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:32:03 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so2587815oie.7
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 08:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56981299-9424-66b1-9e3b-26bf35f58a82@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-15-peter.maydell@linaro.org>
	<56981299-9424-66b1-9e3b-26bf35f58a82@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 16:31:07 +0100
Message-ID: <CAFEAcA8nv3hPEEnpv94CPA0n7_hE_dLgvdpfPfQiV8SvnkyOnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 14/16] hw/dma/pl080: Correct bug
 in register address decode logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 15 August 2018 at 15:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
>> index a7aacad74f0..8f92550392b 100644
>> --- a/hw/dma/pl080.c
>> +++ b/hw/dma/pl080.c
>> @@ -229,7 +229,7 @@ static uint64_t pl080_read(void *opaque, hwaddr offs=
et,
>>          i =3D (offset & 0xe0) >> 5;
>>          if (i >=3D s->nchannels)
>>              goto bad_offset;
>> -        switch (offset >> 2) {
>> +        switch ((offset >> 2) & 7) {
>
> So only the first channel ever worked...

Not even that -- the per-channel registers are in the
0x100..0x200 region, so channel 0's registers start at 0x100.


> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


thanks
-- PMM
