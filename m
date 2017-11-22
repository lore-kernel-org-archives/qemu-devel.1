Received: from eggs.gnu.org ([2001:4830:134:3::10]:59624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbyo-00017q-Kw
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbyn-00031Q-S3
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:50:46 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9YDiTNPX4gxG9uidUbMarLK7gHaeBOFs-+a=6qsuothA@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-13-andrew.smirnov@gmail.com>
	<CAFEAcA9YDiTNPX4gxG9uidUbMarLK7gHaeBOFs-+a=6qsuothA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:50:42 -0800
Message-ID: <CAHQ1cqG3mR6onU+z5=_OZwJz=NuhOwn0Z0znmOB83A2EbKFwpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/30] sdhci: Implement write method of
 ACMD12ERRSTS register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 10:04 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/sd/sdhci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index f561cc44e3..53e5e011a7 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -1139,6 +1139,9 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>>          s->admasysaddr =3D (s->admasysaddr & (0x00000000FFFFFFFFULL |
>>                  ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
>>          break;
>> +    case SDHC_ACMD12ERRSTS:
>> +        MASKED_WRITE(s->acmd12errsts, mask, value);
>> +        break;
>>      case SDHC_FEAER:
>>          s->acmd12errsts |=3D value;
>>          s->errintsts |=3D (value >> 16) & s->errintstsen;
>> --
>> 2.13.6
>
> Is this part of the stock SDHCI spec that we just forgot to implement?

Yes it is. I don't know if missing that code critical for anything,
but since the rest of the plumbing is there I thought that we may as
well implement it.

Thanks,
Andrey Smirnov
