Received: from eggs.gnu.org ([2001:4830:134:3::10]:48775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1CuL-0007R8-GP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1CuK-0007ZB-Kb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:05 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1CuK-0007Yi-CO
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:18:04 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m123so38957024wma.0
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 07:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL43f=RFUJJ+pOXLUaGpx=Vg=Wy3gML9=EWpCGBAu80nww@mail.gmail.com>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-4-git-send-email-peter.maydell@linaro.org>
	<CAAdtpL43f=RFUJJ+pOXLUaGpx=Vg=Wy3gML9=EWpCGBAu80nww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 15:17:42 +0100
Message-ID: <CAFEAcA8BUqU_Z1OKfhbx0ViYXfGwhx1POdeYGGAc9AQmjUBi8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 03/11] armv7m: QOMify the armv7m
 container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 17 April 2017 at 04:59, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On Mon, Feb 20, 2017 at 12:35 PM, Peter Maydell <peter.maydell@linaro.org=
>
> wrote:
>> +static const hwaddr bitband_input_addr[ARMV7M_NUM_BITBANDS] =3D {
>> +    0x20000000, 0x40000000
>> +};
>
>
> What do you think about adding a
>
> #define ARMV7M_BITBAND_[REGION/IOMEM]_SIZE (1ULL << 25) or 0x2000000
>
> and use it at least with memory_region_init_io() and eventually to get th=
e
> output base addr?

I don't think the size of the bitbanding region and the output base
address are inherently related: it's just a coincidence that the
output-region base address is at input-region-base + output-region-size.

I don't particularly object to a constant for the region size,
but I don't currently have any plans to come back to this particular
bit of code for a while (this patch is already in master).

thanks
-- PMM
