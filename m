Received: from eggs.gnu.org ([209.51.188.92]:56302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3NsH-0007Jc-8p
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3NsG-0003ac-FM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:34:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3NsG-0003Zx-5T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:34:00 -0400
References: <20190309165740.0755B7480BD@zero.eik.bme.hu>
	<e514ff3c-4769-83bb-3640-a2320f9d5e3b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f478a98-f7df-07d2-4347-5037951355c8@redhat.com>
Date: Mon, 11 Mar 2019 17:33:54 +0100
MIME-Version: 1.0
In-Reply-To: <e514ff3c-4769-83bb-3640-a2320f9d5e3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] isa: Add APM and ACPI dependencies for
 VT82C686
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 11/03/19 15:54, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/9/19 5:48 PM, BALATON Zoltan wrote:
>> Compiling vt82c686.c fails without APM and ACPI_PM funtions. Add
>> dependency on these in Kconfig to fix this.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/isa/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>> index 57e09a0cb8..e092da3fc3 100644
>> --- a/hw/isa/Kconfig
>> +++ b/hw/isa/Kconfig
>> @@ -36,6 +36,8 @@ config VT82C686
>>      select ACPI_SMBUS
>>      select SERIAL_ISA
>>      select FDC
>> +    select APM
>=20
> Correct, I missed this one.
>=20
>> +    select ACPI_X86
>=20
> NACK it does require ACPI but not X86.
>=20
> ACPI_X86 is messy. I tried to fix VT82C686 in my "Kconfig MIPS" series,
> but I might have to include this in my 'Kconfig PIIX' series.
>=20
>> =20
>>  config SMC37C669
>>      bool
>>

Oh, I thought this was a build fix.  But since MIPS does select these,
I've unqueued this patch and I'll let the maintainers pick Philippe's
series.

Paolo
