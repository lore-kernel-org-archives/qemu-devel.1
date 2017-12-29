Received: from eggs.gnu.org ([2001:4830:134:3::10]:39560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyLd-0003YG-C5
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyLc-0003FD-63
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:21:33 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-5-f4bug@amsat.org>
	<CAKmqyKM-Ar=Ld=6KBvJ1D1T0z2wPhvFR52tvKXKp=SEWoFJ=XQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f261cae0-9026-9ef0-65c5-fb24076564d8@amsat.org>
Date: Fri, 29 Dec 2017 14:21:15 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM-Ar=Ld=6KBvJ1D1T0z2wPhvFR52tvKXKp=SEWoFJ=XQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="WTNMl5JGKpcdBTAgBclkGxkFWzepowXab"
Subject: Re: [Qemu-devel] [PATCH v2 04/20] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WTNMl5JGKpcdBTAgBclkGxkFWzepowXab
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alistair Francis <alistair.francis@xilinx.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>,
 Xiaoqiang Zhao <zxq_yx_007@163.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Andrzej Zaborowski <balrogg@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Andrey Yurovsky <yurovsky@gmail.com>, Prasad J Pandit
 <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>
Message-ID: <f261cae0-9026-9ef0-65c5-fb24076564d8@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 04/20] sdhci: refactor same sysbus/pci
 properties into a common one
References: <20171215031547.31006-1-f4bug@amsat.org>
 <20171215031547.31006-5-f4bug@amsat.org>
 <CAKmqyKM-Ar=Ld=6KBvJ1D1T0z2wPhvFR52tvKXKp=SEWoFJ=XQ@mail.gmail.com>
In-Reply-To: <CAKmqyKM-Ar=Ld=6KBvJ1D1T0z2wPhvFR52tvKXKp=SEWoFJ=XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

On 12/18/2017 10:13 PM, Alistair Francis wrote:
> On Thu, Dec 14, 2017 at 7:15 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
>> add sysbus/pci/sdbus separator comments to keep it clearer
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> I'm still unsure about this. Won't this leave us with properties that
> have no impact on the device? That seems very confusing to me.

(from previous series)
> [...] but aren't we now going to
> have device properties that aren't actually connected to anything?

I'm also confused :)

My understanding is the "pending-insert-quirk" worries you.
This property is dependent of the HCI IP, so regardless the HCI is
accessed through a MMIO sysbus or a PCI bus the quirk might exists (for
this property, only the BCM implementation).

With v3 series applied, the monitor 'qtree' output is:

$ qemu-system-aarch64 -M xlnx-zcu102 -monitor stdio -S
(qemu) info qtree
  dev: generic-sdhci, id ""
    gpio-out "sysbus-irq" 1
    sd-spec-version =3D 3 (0x3)
    timeout-freq =3D 0 (0x0)
    freq-in-mhz =3D true
    clock-freq =3D 0 (0x0)
    max-block-length =3D 512 (0x200)
    dma =3D true
    sdma =3D true
    adma1 =3D false
    adma2 =3D true
    suspend =3D true
    high-speed =3D true
    3v3 =3D true
    3v0 =3D false
    1v8 =3D true
    64bit =3D true
    slot-type =3D 0 (0x0)
    bus-speed =3D 7 (0x7)
    driver-strength =3D 7 (0x7)
    maxcurr =3D 0 (0x0)
    pending-insert-quirk =3D false
    dma-memory =3D ""
    mmio 00000000ff170000/0000000000000100
    bus: sd-bus
      type sdhci-bus
      dev: sd-card, id ""
        drive =3D ""
        spi =3D false

Are you worried about this output?

>> ---
>>  hw/sd/sdhci.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 2823da00da..dbdfd54350 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -1265,13 +1265,17 @@ const VMStateDescription sdhci_vmstate =3D {
>>
>>  /* Capabilities registers provide information on supported features o=
f this
>>   * specific host controller implementation */
>> -static Property sdhci_pci_properties[] =3D {
>> +static Property sdhci_properties[] =3D {
>>      DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>>              SDHC_CAPAB_REG_DEFAULT),
>>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_inse=
rt_quirk,
>> +                     false),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>
>> +/* --- qdev PCI --- */
>> +
>>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>>  {
>>      SDHCIState *s =3D PCI_SDHCI(dev);
>> @@ -1304,7 +1308,7 @@ static void sdhci_pci_class_init(ObjectClass *kl=
ass, void *data)
>>      k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>      dc->vmsd =3D &sdhci_vmstate;
>> -    dc->props =3D sdhci_pci_properties;
>> +    dc->props =3D sdhci_properties;
>>      dc->reset =3D sdhci_poweron_reset;
>>  }
>>
>> @@ -1319,14 +1323,7 @@ static const TypeInfo sdhci_pci_info =3D {
>>      },
>>  };
>>
>> -static Property sdhci_sysbus_properties[] =3D {
>> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
>> -            SDHC_CAPAB_REG_DEFAULT),
>> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>> -    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_inse=
rt_quirk,
>> -                     false),
>> -    DEFINE_PROP_END_OF_LIST(),
>> -};
>> +/* --- qdev SysBus --- */
>>
>>  static void sdhci_sysbus_init(Object *obj)
>>  {
>> @@ -1359,7 +1356,7 @@ static void sdhci_sysbus_class_init(ObjectClass =
*klass, void *data)
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>>
>>      dc->vmsd =3D &sdhci_vmstate;
>> -    dc->props =3D sdhci_sysbus_properties;
>> +    dc->props =3D sdhci_properties;
>>      dc->realize =3D sdhci_sysbus_realize;
>>      dc->reset =3D sdhci_poweron_reset;
>>  }
>> @@ -1373,6 +1370,8 @@ static const TypeInfo sdhci_sysbus_info =3D {
>>      .class_init =3D sdhci_sysbus_class_init,
>>  };
>>
>> +/* --- qdev bus master --- */
>> +
>>  static void sdhci_bus_class_init(ObjectClass *klass, void *data)
>>  {
>>      SDBusClass *sbc =3D SD_BUS_CLASS(klass);
>> --
>> 2.15.1
>>
>>


--WTNMl5JGKpcdBTAgBclkGxkFWzepowXab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpGeZAACgkQ4+MsLN6t
wN4dag/+JcEj5WOb0sWgIV99ufP9i0CXSgZMgysISdeUaNF4WVvfXGBpwzqDhua1
UMiZzj/wTrJNiaSYFGeI1lGxz3WGeKRLtiAweaXN61ZKMHt2XGArO4VcXIyLzsad
p7pTzcVeRqNiFyYG2aGHIdx7SZCXNkiftS1C0WkkurNcagmqCWSb2MIhXtt+D4u0
S8dzypDUNkLnxYu+QueJhX1Sqi7bMY5GCibpr3ueaVl6C8m4cYmQS9vqXwJASiV1
kQg780lfl8iexH/C6vwhTCIlGEleuYL1LGgFcz+ja+HjS2W4rFqVvwvIvZfK4lUi
4KHUZME1rGtL0TV8SqI4V1xSjPJV6iSDWuTEEcSV3h8GUPuYonXBNALleIqeYY43
S5Q5Okejf4zov+lIeLUonb9GwnnuMS1Y/YSGCgUh6vHcZU0kyEuNhfnRdgexDwNq
V+VyAGTcfIb9te4G+HsPkvkkGSN3M5FC2uTE6J+Bxg9QbdvRc0Ilpu0nFLxRerFX
Quhrhz5eo4MCkfY/irdtPG/QZ11/V5x1VEIFvZOzeeEAQCn8XL7tRIEAiW7Aeh3s
ClM4RsC7l1ioQjPlwfmGmkhIb7JAm94mvi51ysWqEEICciJOeOnn6akg72cvKqkd
sVFmaHEoGiDSLdWX4Px7fIQJOhMwo8A7NM9h/igGSjA8WU0qOQ0=
=Rv4j
-----END PGP SIGNATURE-----

--WTNMl5JGKpcdBTAgBclkGxkFWzepowXab--
