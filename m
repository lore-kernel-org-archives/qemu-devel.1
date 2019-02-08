Received: from eggs.gnu.org ([209.51.188.92]:56208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grxo6-0006AQ-Og
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grxo4-0006xq-7F
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:30:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1grxnt-0006sf-7M
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:30:19 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-34-git-send-email-pbonzini@redhat.com>
	<alpine.BSF.2.21.9999.1902080014070.97736@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <be20ee93-a4c6-bb09-9296-50a962981f89@redhat.com>
Date: Fri, 8 Feb 2019 05:30:07 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1902080014070.97736@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 33/51] ppc: Express dependencies of the
 Sam460EX machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@redhat.com

On 2019-02-08 00:16, BALATON Zoltan wrote:
> On Thu, 7 Feb 2019, Paolo Bonzini wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Most of the dependencies are now directly selected by the SAM460EX
>> switch. We can drop CONFIG_VGA_CIRRUS since this device is already
>> selected automatically when CONFIG_PCI_DEVICES is set.
>>
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> default-configs/ppc-softmmu.mak |=C2=A0 8 --------
>> hw/display/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> hw/ppc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++++++++++
>> 3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/default-configs/ppc-softmmu.mak
>> b/default-configs/ppc-softmmu.mak
>> index caaff60..fb43cba 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -25,14 +25,6 @@ CONFIG_PCI_EXPRESS=3Dy
>>
>> # For Sam460ex
>> CONFIG_SAM460EX=3Dy
>> -CONFIG_USB_EHCI_SYSBUS=3Dy
>> -CONFIG_SM501=3Dy
>> -CONFIG_IDE_SII3112=3Dy
>> -CONFIG_AT24C=3Dy
>> -CONFIG_BITBANG_I2C=3Dy
>> -CONFIG_M41T80=3Dy
>> -CONFIG_VGA_CIRRUS=3Dy
>> -CONFIG_SMBUS_EEPROM=3Dy
>>
>> # For Macs
>> CONFIG_MAC_OLDWORLD=3Dy
>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>> index 0f659e9..69f8a7e 100644
>> --- a/hw/display/Kconfig
>> +++ b/hw/display/Kconfig
>> @@ -29,6 +29,7 @@ config SII9022
>> config SSD0303
>> =C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0 depends on I2C
>> +=C2=A0=C2=A0=C2=A0 select DDC
>=20
> What's SSD0303? It's not something sam460ex needs. Are you sure this
> hunk belongs to this patch?

That looks like a rebase error, inded. The line should belong to SM501
instead, see my original patch:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg08244.html

 Thomas
