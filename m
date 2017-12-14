Received: from eggs.gnu.org ([2001:4830:134:3::10]:58242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePZL1-00073W-Qz
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePZL1-0001Zl-0C
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:38:35 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePZL0-0001XQ-PZ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:38:34 -0500
Received: by mail-wm0-x244.google.com with SMTP id 64so13534827wme.3
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 11:38:34 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAAdtpL45Yd98nrtc1LtAAVgc+-g3zhF=gDyevXgVJ-V+i-_Ydg@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-11-f4bug@amsat.org>
	<CAKmqyKOanQAp26iXxqWQ_HtrLtg_ctgC2_q8nU4qxLSpRt_eyw@mail.gmail.com>
	<CAAdtpL45Yd98nrtc1LtAAVgc+-g3zhF=gDyevXgVJ-V+i-_Ydg@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 11:38:02 -0800
Message-ID: <CAKmqyKNgEsr5EL6fZNJgbUNmHv=BAMiOqJ-fjiyP9+qCUj3wxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/14] sdhci: use qemu_log_mask(UNIMP)
 instead of fprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Sai Pavan Boddu <saipava@xilinx.com>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Dec 14, 2017 at 10:14 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> On Thu, Dec 14, 2017 at 2:47 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
>> <f4bug@amsat.org> wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/sd/sdhci.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 044e3d62f1..8fcd48f849 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -936,7 +936,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr off=
set, unsigned size)
>>>          ret =3D (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
>>>          break;
>>>      default:
>>> -        ERRPRINT("bad %ub read: addr[0x%04x]\n", size, (int)offset);
>>> +        qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
>>> +                      "not implemented\n", size, offset);
>>
>> Is this actually unimplemented? Or is it just a guest error?
>
> So far we don't have those registers implemented, that's why I decided
> to use UNIMP to remove the fprintf().

Ah, very confusing. I'll let you decide here what to do.

Alistair

>
> This log become useful when we pretend to support the Spec v3, as the
> guest start using register we don't have yet implemented.
>
> However depending on the Spec version implemented, this might be a GUEST_=
ERROR.
>
> I'll sort this out for the current version, v2 (we don't care about v1
> since all QEMU models support at least v2).
>
> Thanks,
>
> Phil.
>
