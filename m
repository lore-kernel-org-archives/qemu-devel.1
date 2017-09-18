Received: from eggs.gnu.org ([2001:4830:134:3::10]:45251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dtpZ0-0000IF-DW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 02:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dtpYz-0005yl-71
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 02:29:50 -0400
MIME-Version: 1.0
In-Reply-To: <3618281c-b4f9-3a1a-8b6f-f87dfeb54e45@amsat.org>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-3-git-send-email-sundeep.lkml@gmail.com>
	<a9891f10-9643-96ee-7f99-7a384b9ea302@amsat.org>
	<3618281c-b4f9-3a1a-8b6f-f87dfeb54e45@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 18 Sep 2017 11:59:46 +0530
Message-ID: <CALHRZuoba-57L-95NrCHBn-+_DUcg9PQTbaOz4ENwPyX+Ysa3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Philippe,

On Mon, Sep 18, 2017 at 5:27 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Sundeep,
>
> On 09/14/2017 01:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> On 09/07/2017 04:24 PM, Subbaraya Sundeep wrote:
>>
> [...]
>
>> +static inline int msf2_divbits(uint32_t div)
>>>
>>
>> Please directly use ctz32() instead of msf2_divbits()
>>
>
> It seems you missed this review comment in your v9.


ctz32(1) =3D 0
ctz32(2) =3D 1
ctz32(4) =3D 2
ctz32(8) =3D 3
ctz32(16) =3D 4
ctz32(32) =3D 5

but for inputs 8,16,32 output should be 4,5,6 so didn't use ctz32().
I replied to this comment in the same mail chain earlier. Please check.

Thanks,
Sundeep

>
>
>
>> +{
>>> +    int ret =3D 0;
>>> +
>>> +    switch (div) {
>>> +    case 1:
>>> +        ret =3D 0;
>>> +        break;
>>> +    case 2:
>>> +        ret =3D 1;
>>> +        break;
>>> +    case 4:
>>> +        ret =3D 2;
>>> +        break;
>>> +    case 8:
>>> +        ret =3D 4;
>>> +        break;
>>> +    case 16:
>>> +        ret =3D 5;
>>> +        break;
>>> +    case 32:
>>> +        ret =3D 6;
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>>
>>
