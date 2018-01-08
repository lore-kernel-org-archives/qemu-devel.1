Received: from eggs.gnu.org ([2001:4830:134:3::10]:47517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYXqD-0002eo-Di
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYXqC-0005Pk-BL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:51:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-5-f4bug@amsat.org>
	<20180108135437.4ab656fb@redhat.com>
	<cf14bfc3-3256-575a-fb4b-69f63d5bdb3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aaab7bfd-d3ed-aa50-f09e-89d6ccf556ff@amsat.org>
Date: Mon, 8 Jan 2018 10:51:38 -0300
MIME-Version: 1.0
In-Reply-To: <cf14bfc3-3256-575a-fb4b-69f63d5bdb3b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="wSj7HfeiGcq5zx0HWmgNdqc3bnn7jJFdf"
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
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wSj7HfeiGcq5zx0HWmgNdqc3bnn7jJFdf
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <aaab7bfd-d3ed-aa50-f09e-89d6ccf556ff@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] arm/xlnx-zynq: use FDT names for the
 Cadence UART
References: <20180104144046.30793-1-f4bug@amsat.org>
 <20180104144046.30793-5-f4bug@amsat.org> <20180108135437.4ab656fb@redhat.com>
 <cf14bfc3-3256-575a-fb4b-69f63d5bdb3b@redhat.com>
In-Reply-To: <cf14bfc3-3256-575a-fb4b-69f63d5bdb3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 10:17 AM, Thomas Huth wrote:
> On 08.01.2018 13:54, Igor Mammedov wrote:
>> On Thu,  4 Jan 2018 11:40:44 -0300
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/arm/xilinx_zynq.c | 1 +
>>>  hw/arm/xlnx-zynqmp.c | 2 +-
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>>> index 1836a4ed45..c45c364583 100644
>>> --- a/hw/arm/xilinx_zynq.c
>>> +++ b/hw/arm/xilinx_zynq.c
>>> @@ -236,6 +236,7 @@ static void zynq_init(MachineState *machine)
>>>      sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFS=
ET]);
>>>      sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFS=
ET]);
>>> =20
>>> +    /* "xlnx,xuartps" */
>>>      cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hds=
[0]);
>>>      cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hds=
[1]);
>>> =20
>>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>>> index 325642058b..38f038786c 100644
>>> --- a/hw/arm/xlnx-zynqmp.c
>>> +++ b/hw/arm/xlnx-zynqmp.c
>>> @@ -155,7 +155,7 @@ static void xlnx_zynqmp_init(Object *obj)
>>>      }
>>> =20
>>>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
>>> -        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_CADE=
NCE_UART);
>>> +        object_initialize(&s->uart[i], sizeof(s->uart[i]), "xlnx,zyn=
qmp-uart");
>>
>> I don't think that commas are valid symbol in type names
>> (if I recall correctly it should be letters, numbers and '-')
>=20
> At least commas are a real PITA when you try to use such devices with
> the "-device" CLI parameter. We should try to avoid this if possible, I=

> think.

Ok, good to know.

I was following Linux Device Tree names [1] to avoid handling some
fdt_qemu_to_linux[] & fdt_linux_to_qemu conversion arrays.

What about keeping using the QEMU default name for -device CLI param and
allow aliases for FDT parsing?
With this series the cadence_uart_info is now:

static const TypeInfo cadence_uart_info =3D {
    .name          =3D TYPE_CADENCE_UART,
    .aliases       =3D (const char * []) {
                        "cdns,uart-r1p8",
                        "xlnx,xuartps",
                        "cdns,uart-r1p12",
                        "xlnx,zynqmp-uart",
                        NULL
                     },

[1]:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/serial/cdns,uart.txt


--wSj7HfeiGcq5zx0HWmgNdqc3bnn7jJFdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpTd2oACgkQ4+MsLN6t
wN70XxAAoh73zsNWBKVajCReWorBZRCcG2ee1SQe3zj95lThiEUnpshaQ4K0qD8b
tSotZvHreUJp/jKBzv2EwdlBge31p24WJjmOixSaqSsWCk3PFDc3AC4xM5Lp/wTr
kK/3WF26tp6i/+na+qJrw+h4m6rR1LUICN81TrQNsxYeKA/M6yjmvxGOKTDYQcRK
joIKI9iAsYmZBqYZngdgfqQwrVHl0RTHarQAkmZrP7deTXWuxn3cRvoZ2wtMeEok
kznOhkRklNhAILZFmAoo02Jeg0eYOWs5GhVhJ5+gM05TqdPxbbZcAjVLZhLylYDs
173ZOzDXlHWVYM5Qb+F+2RrqCFT0WjOng63mFkn8A0l7ehBuTtCY5WKCJxZbVRrb
ltMhos1eBIHlyKjJ9f4hoXtbXRN0GcoMQeLay+XsVL1V3k5nekQ8HZID6J8Wt40V
qG9acJLCBhLD53BZwJR+CwmQsMmR0/OXgZeQEhThHcyFdxKA8KGsSGsV2DkTWQHg
r6YWh/37unntZ2UYvQOw0QkZLcVOSZren1499GDrxwXJ3l8x4qvWIwu1qNoaG/YH
tH9T23XMRh8VQ9eWBT9mIf7STfyEELTjJ9eXE5HZjvTXpZIxv7VV7SnYTlofBp0R
stl/ujNhrYumHNslrD/xo2kJOBXZmqCFpGIKhMUF6zIv3HkVS0E=
=zNCS
-----END PGP SIGNATURE-----

--wSj7HfeiGcq5zx0HWmgNdqc3bnn7jJFdf--
