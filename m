Received: from eggs.gnu.org ([2001:4830:134:3::10]:50834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQxoo-00064i-45
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQxol-0000os-4e
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:31:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-6-f4bug@amsat.org>
	<CAKmqyKPRbvPF8gSwpZ3e4xzbpvb0sii=HF7Av==F-chDqBojzA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f00d6c18-ae7b-75fb-d1c0-c71abf93c330@amsat.org>
Date: Thu, 7 Jun 2018 13:31:04 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPRbvPF8gSwpZ3e4xzbpvb0sii=HF7Av==F-chDqBojzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/8] hw/sd/ssi-sd: Force cards
 connected in SPI mode to use Spec v1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/04/2018 03:26 PM, Alistair Francis wrote:
> On Sat, Jun 2, 2018 at 5:08 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Can you add a justification for this in the commit message?

Oops, I misplaced the justification in the following patch
(6/8: Disable SEND_IF_COND (CMD8) for Spec v1)

> 
> Alistair
> 
>> ---
>>  hw/sd/ssi-sd.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>> index ae04b6641b..c62fdc871c 100644
>> --- a/hw/sd/ssi-sd.c
>> +++ b/hw/sd/ssi-sd.c
>> @@ -253,6 +253,8 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
>>      /* FIXME use a qdev drive property instead of drive_get_next() */
>>      dinfo = drive_get_next(IF_SD);
>>      carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
>> +    object_property_set_uint(OBJECT(carddev),
>> +                             SD_PHY_SPECv1_10_VERS, "spec_version", &err);
>>      if (dinfo) {
>>          qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
>>      }
>> --
>> 2.17.1
>>
>>
> 
