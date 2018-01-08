Received: from eggs.gnu.org ([2001:4830:134:3::10]:35257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYXJd-0007Rz-Qn
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYXJc-0000Lv-T0
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:18:13 -0500
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-5-f4bug@amsat.org>
	<20180108135437.4ab656fb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf14bfc3-3256-575a-fb4b-69f63d5bdb3b@redhat.com>
Date: Mon, 8 Jan 2018 14:17:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180108135437.4ab656fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] arm/xlnx-zynq: use FDT names for
 the Cadence UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 08.01.2018 13:54, Igor Mammedov wrote:
> On Thu,  4 Jan 2018 11:40:44 -0300
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/arm/xilinx_zynq.c | 1 +
>>  hw/arm/xlnx-zynqmp.c | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>> index 1836a4ed45..c45c364583 100644
>> --- a/hw/arm/xilinx_zynq.c
>> +++ b/hw/arm/xilinx_zynq.c
>> @@ -236,6 +236,7 @@ static void zynq_init(MachineState *machine)
>>      sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSE=
T]);
>>      sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSE=
T]);
>> =20
>> +    /* "xlnx,xuartps" */
>>      cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hds[=
0]);
>>      cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hds[=
1]);
>> =20
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index 325642058b..38f038786c 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -155,7 +155,7 @@ static void xlnx_zynqmp_init(Object *obj)
>>      }
>> =20
>>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
>> -        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_CADEN=
CE_UART);
>> +        object_initialize(&s->uart[i], sizeof(s->uart[i]), "xlnx,zynq=
mp-uart");
>
> I don't think that commas are valid symbol in type names
> (if I recall correctly it should be letters, numbers and '-')

At least commas are a real PITA when you try to use such devices with
the "-device" CLI parameter. We should try to avoid this if possible, I
think.

 Thomas
