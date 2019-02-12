Received: from eggs.gnu.org ([209.51.188.92]:58696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtaiR-0004xl-HV
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtagL-0001Fv-VH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:13:14 -0500
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
	<1549694366-1284-23-git-send-email-thuth@redhat.com>
	<3d8e2191-12b2-ebdf-7e35-594d160653ec@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32f173b5-ffa5-60f2-04db-3763d41004ff@redhat.com>
Date: Tue, 12 Feb 2019 17:13:00 +0100
MIME-Version: 1.0
In-Reply-To: <3d8e2191-12b2-ebdf-7e35-594d160653ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/25] hw/arm: Express dependencies of
 nrf51 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, pbonzini@redhat.com, qemu-arm@nongnu.org

On 2019-02-11 18:37, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 2/9/19 7:39 AM, Thomas Huth wrote:
>> Add Kconfig dependencies for the NRF51 / microbit machine.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/arm/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index c4b3cd2..aad2dd3 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -379,6 +379,8 @@ config FSL_IMX6UL
>> =20
>>  config NRF51_SOC
>>      bool
>> +    select I2C
>> +    select ARM_V7M
>=20
> Don't we need a microbit config too?

As long as we do not have another board that uses the NRF51-SoC, it does
not matter that much ... but yes, it's likely cleaner to have a proper
switch for the machine right from the start. I'll fix it in v2 ...

 Thomas
