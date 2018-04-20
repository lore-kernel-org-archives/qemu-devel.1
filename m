Received: from eggs.gnu.org ([2001:4830:134:3::10]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9WbD-0001NT-3G
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Wb8-00053j-98
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:01:15 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:44687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Wb8-00051C-2d
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:01:10 -0400
Received: by mail-ot0-x242.google.com with SMTP id g7-v6so454021otj.11
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 07:01:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ad37af41-feda-0a6a-89a2-38abd452401c@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-2-f4bug@amsat.org>
	<CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
	<f89278ba-b805-e47d-7e5e-d103ab9c4294@amsat.org>
	<CAFEAcA9zuoVDJqZ88jBG0fEpC2imDuj2OAAMpgqiQ=MbtE3QSg@mail.gmail.com>
	<ad37af41-feda-0a6a-89a2-38abd452401c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:00:48 +0100
Message-ID: <CAFEAcA8UKgV2_YYOPYZ1SfcHwSaE=t_VCyn1grKUOp0x-izkUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/isa/superio: Fix inconsistent use
 of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 20 April 2018 at 14:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 04/20/2018 09:59 AM, Peter Maydell wrote:
>> Incidentally I was wondering if we could sensibly get rid of
>> the compile time MAX_SERIAL_PORTS. Right now there's no way
>> to model a device with five UARTs such that they can all
>> be sent to interesting places. I think there's no reason
>> for this except that the PC traditionally has 4 UARTs and
>> nobody's ever changed the code...
>
> Yes, I thought the same and planned to relax this limit (and few others)
> in my "remove i386/pc dependency from non-PC world" series...

It seems fairly straightforward so I've put some patches
together, might be able to get them onto the list this
afternoon.

thanks
-- PMM
