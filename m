Received: from eggs.gnu.org ([208.118.235.92]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gehma-0007pC-M7
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gehmZ-0003Xv-T8
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:46:08 -0500
References: <1546433583-18397-1-git-send-email-thuth@redhat.com>
	<10359753-9573-629b-5c76-7c148e66cb91@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1146d00d-94e2-47f6-2c1d-977e86ecd55c@redhat.com>
Date: Wed, 2 Jan 2019 15:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <10359753-9573-629b-5c76-7c148e66cb91@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add ARM-related files for
 hw/[misc|input|timer]/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2019-01-02 15:42, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/2/19 1:53 PM, Thomas Huth wrote:
>> Some of the files in hw/input/, hw/misc/ and hw/timer/ are only
>> used by one of the ARM machines, so we can assign these files to
>> the corresponding boards.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  MAINTAINERS | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 180695f..693abdf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
[...]
>> @@ -688,10 +698,10 @@ L: qemu-arm@nongnu.org
>>  S: Odd Fixes
>>  F: hw/arm/sabrelite.c
>>  F: hw/arm/fsl-imx6.c
>> -F: hw/misc/imx6_src.c
>> +F: hw/misc/imx6_*.c
>>  F: hw/ssi/imx_spi.c
>>  F: include/hw/arm/fsl-imx6.h
>> -F: include/hw/misc/imx6_src.h
>> +F: include/hw/misc/imx6_*.h
>>  F: include/hw/ssi/imx_spi.h
>=20
> New models for the MCIMX6UL EVK might eventually match here.

The current files use "*imx6ul*" which do not match here due to the
underscore after the "6". So I hope future files will use this naming
scheme, too, then we should be fine.

>> =20
>>  Sharp SL-5500 (Collie) PDA
>> @@ -802,7 +812,9 @@ R: Joel Stanley <joel@jms.id.au>
>>  L: qemu-arm@nongnu.org
>>  S: Maintained
>>  F: hw/*/*aspeed*
>> +F: hw/misc/pca9552.c
>>  F: include/hw/*/*aspeed*
>> +F: include/hw/misc/pca9552*.h
>>  F: hw/net/ftgmac100.c
>>  F: include/hw/net/ftgmac100.h
>=20
> OK
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

 Thomas
