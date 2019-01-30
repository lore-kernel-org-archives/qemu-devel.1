Received: from eggs.gnu.org ([209.51.188.92]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gooan-0007IX-Jg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gooam-0001m7-Ca
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:03:45 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-5-git-send-email-thuth@redhat.com>
	<alpine.BSF.2.21.9999.1901301224420.42161@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d14bfd8e-7087-19fb-5fd3-ac09c28932f6@redhat.com>
Date: Wed, 30 Jan 2019 13:03:38 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901301224420.42161@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/5] ppc: Express dependencies of the
 Sam460EX machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com, qemu-ppc@nongnu.org

On 2019-01-30 12:29, BALATON Zoltan wrote:
> Hello,
>=20
> On Wed, 30 Jan 2019, Thomas Huth wrote:
>> Most of the dependencies are now directly selected by the SAM460EX
>> switch. We can drop CONFIG_VGA_CIRRUS since this device is already
>> selected automatically when CONFIG_PCI_DEVICES is set.
>>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> default-configs/ppc-softmmu.mak | 10 ----------
>> hw/display/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> hw/ppc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
>> hw/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> 4 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/default-configs/ppc-softmmu.mak
>> b/default-configs/ppc-softmmu.mak
>> index 513a8e9..5265d8a 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -25,16 +25,6 @@ CONFIG_PCI_EXPRESS=3Dy
>>
>> # For Sam460ex
>> CONFIG_SAM460EX=3Dy
>> -CONFIG_USB_EHCI_SYSBUS=3Dy
>> -CONFIG_SM501=3Dy
>> -CONFIG_DDC=3Dy
>> -CONFIG_IDE_SII3112=3Dy
>> -CONFIG_I2C=3Dy
>> -CONFIG_AT24C=3Dy
>> -CONFIG_BITBANG_I2C=3Dy
>> -CONFIG_M41T80=3Dy
>> -CONFIG_VGA_CIRRUS=3Dy
>> -CONFIG_SMBUS_EEPROM=3Dy
>>
>> # For Macs
>> CONFIG_MAC_OLDWORLD=3Dy
>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>> index c784fe8..f8e6136 100644
>> --- a/hw/display/Kconfig
>> +++ b/hw/display/Kconfig
>> @@ -76,6 +76,7 @@ config MILKYMIST_TMU2
>> config SM501
>> =C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0 depends on I2C
>> +=C2=A0=C2=A0=C2=A0 select DDC
>>
>> config TCX
>> =C2=A0=C2=A0=C2=A0 bool
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index f6b4206..8bd25ed 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -24,9 +24,21 @@ config PPC440
>>
>> config PPC4XX
>> =C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 select BITBANG_I2C
>> +=C2=A0=C2=A0=C2=A0 select PCI
>>
>> config SAM460EX
>> =C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 select AT24C
>=20
> I don't recognise this as needed. Is it for dependency of something?

Oh, sorry, I apparently missed that one up. The device has been
added for the e500 machine instead:

 https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03492.html

... so this line belongs to the "config E500" section instead.

>> +=C2=A0=C2=A0=C2=A0 select PFLASH_CFI01
>> +=C2=A0=C2=A0=C2=A0 select IDE_SII3112
>> +=C2=A0=C2=A0=C2=A0 select ISA_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # FIXME: Currently required for IDE_SII3112
>=20
> This is not really a dependency of SII3112 but of ide/core so this mayb=
e
> this belongs to IDE config?

It definitely needs fixing, that's why I've got a FIXME here :-)

I've now had a closer look, and the problem is that CONFIG_IDE_PCI
currently causes ioport.o to be pulled in. That seems unnecessary. I'll
continue the discussion in the related patch ("ide: split ioport
registration to a separate file")...

> Otherwise I don't care much if it still compiles so
>=20
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks!

  Thomas
