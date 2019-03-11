Received: from eggs.gnu.org ([209.51.188.92]:42543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3EnA-0002TC-NL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3EXh-0004IW-SL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:36:10 -0400
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
	<1551968334-18982-20-git-send-email-thuth@redhat.com>
	<7e477c03-59d0-f6a4-a557-a8f5740d259a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8cf27b8a-2868-12e7-9b21-483884067029@redhat.com>
Date: Mon, 11 Mar 2019 07:35:52 +0100
MIME-Version: 1.0
In-Reply-To: <7e477c03-59d0-f6a4-a557-a8f5740d259a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 19/29] hw/arm: Express dependencies of
 the MPS2 boards with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 10/03/2019 22.33, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 3/7/19 3:18 PM, Thomas Huth wrote:
>> Add Kconfig dependencies for the mps2-an* machines.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 20 +-------------------
>>  hw/arm/Kconfig                  | 18 ++++++++++++++++++
>>  2 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index b6f3d60..b8509fd 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -27,6 +27,7 @@ CONFIG_Z2=3Dy
>>  CONFIG_COLLIE=3Dy
>>  CONFIG_ASPEED_SOC=3Dy
>>  CONFIG_NETDUINO2=3Dy
>> +CONFIG_MPS2=3Dy
>> =20
>>  CONFIG_VGA=3Dy
>>  CONFIG_SSI_M25P80=3Dy
>> @@ -35,28 +36,9 @@ CONFIG_IMX_FEC=3Dy
>>  CONFIG_FRAMEBUFFER=3Dy
>> =20
>>  CONFIG_DIGIC=3Dy
>> -CONFIG_MPS2=3Dy
>>  CONFIG_RASPI=3Dy
>>  CONFIG_NRF51_SOC=3Dy
>> =20
>> -CONFIG_CMSDK_APB_TIMER=3Dy
>> -CONFIG_CMSDK_APB_DUALTIMER=3Dy
>> -CONFIG_CMSDK_APB_UART=3Dy
>> -CONFIG_CMSDK_APB_WATCHDOG=3Dy
>> -
>> -CONFIG_MPS2_FPGAIO=3Dy
>> -CONFIG_MPS2_SCC=3Dy
>> -
>> -CONFIG_TZ_MPC=3Dy
>> -CONFIG_TZ_MSC=3Dy
>> -CONFIG_TZ_PPC=3Dy
>> -CONFIG_ARMSSE=3Dy
>> -CONFIG_IOTKIT_SECCTL=3Dy
>> -CONFIG_IOTKIT_SYSCTL=3Dy
>> -CONFIG_IOTKIT_SYSINFO=3Dy
>> -CONFIG_ARMSSE_CPUID=3Dy
>> -CONFIG_ARMSSE_MHU=3Dy
>> -
>>  CONFIG_FSL_IMX6=3Dy
>>  CONFIG_FSL_IMX25=3Dy
>>  CONFIG_FSL_IMX7=3Dy
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 743c78b..32c8663 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -308,6 +308,13 @@ config ASPEED_SOC
>> =20
>>  config MPS2
>>      bool
>> +    select ARMSSE
>> +    select LAN9118
>> +    select MPS2_FPGAIO
>> +    select MPS2_SCC
>> +    select PL022    # Serial port
>> +    select PL080    # DMA controller
>> +    select TZ_MPC
>=20
> Can we move TZ_MPC to ARMSSE?

Oh, right, armsse_init() uses TYPE_TZ_MPC, too, so it should be moved.

 Thomas
