Received: from eggs.gnu.org ([2001:4830:134:3::10]:57780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fSUvE-0003Px-N9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fSUvD-0005iw-SA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:04:20 -0400
MIME-Version: 1.0
In-Reply-To: <bfdc313f-f8b0-77a5-e87b-cc9c75f8e110@kaod.org>
References: <20180611171518.3390-1-clg@kaod.org>
	<bfdc313f-f8b0-77a5-e87b-cc9c75f8e110@kaod.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Jun 2018 15:03:47 -0700
Message-ID: <CAKmqyKOm6O_Tj1Bru9DpQN_uWsHQ+V1Jh2cN3EzwMCFOu=hOUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] m25p80: add support for two bytes WRSR for
 Macronix chips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>

On Mon, Jun 11, 2018 at 10:18 AM, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
> On 06/11/2018 07:15 PM, C=C3=A9dric Le Goater wrote:
>> On Macronix chips, two bytes can written to the WRSR. First byte will
>> configure the status register and the second the configuration
>> register. It is important to save the configuration value as it
>> contains the dummy cycle setting when using dual or quad IO mode.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>> ---
>>  hw/block/m25p80.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index b49c8e9caa04..29775e055a24 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -699,6 +699,7 @@ static void complete_collecting_data(Flash *s)
>>          case MAN_MACRONIX:
>>              s->quad_enable =3D extract32(s->data[0], 6, 1);
>>              if (s->len > 1) {
>> +                s->volatile_cfg =3D s->data[1];
>>                  s->four_bytes_address_mode =3D extract32(s->data[1], 5,=
 1);
>>              }
>>              break;
>>
>
> I sent this patch to qemu-ppc instead of qemu-devel ...
>
> Sorry for the noise.
>
> C.
>
