Received: from eggs.gnu.org ([2001:4830:134:3::10]:35893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHcGE-0007rc-C2
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHcGD-0005yZ-F0
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:08:46 -0500
MIME-Version: 1.0
In-Reply-To: <20171122163426.13f3ed3f@redhat.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-30-andrew.smirnov@gmail.com>
	<20171122163426.13f3ed3f@redhat.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 13:08:42 -0800
Message-ID: <CAHQ1cqGQ-_k6n=Dfj9qQSkiDCbzDVbJBRXyKf+MsVj0tYWNrBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 29/30] i.MX: Add i.MX7 SOC
 implementation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Wed, Nov 22, 2017 at 7:34 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Mon,  6 Nov 2017 07:48:12 -0800
> Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
>> The following interfaces are partially or fully emulated:
>>
>>     * up to 2 Cortex A9 cores (SMP works with PSCI)
>>     * A7 MPCORE (identical to A15 MPCORE)
>>     * 4 GPTs modules
>>     * 7 GPIO controllers
>>     * 2 IOMUXC controllers
>>     * 1 CCM module
>>     * 1 SVNS module
>>     * 1 SRC module
>>     * 1 GPCv2 controller
>>     * 4 eCSPI controllers
>>     * 4 I2C controllers
>>     * 7 i.MX UART controllers
>>     * 2 FlexCAN controllers
>>     * 2 Ethernet controllers (FEC)
>>     * 3 SD controllers (USDHC)
>>     * 4 WDT modules
>>     * 1 SDMA module
>>     * 1 GPR module
>>     * 2 USBMISC modules
>>     * 2 ADC modules
>>     * 1 PCIe controller
>>
>> Tested to boot and work with upstream Linux (4.13+) guest.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
> ...
>> +
>> +static void fsl_imx7_init(Object *obj)
>> +{
>> +    BusState *sysbus =3D sysbus_get_default();
>> +    FslIMX7State *s =3D FSL_IMX7(obj);
>> +    char name[NAME_SIZE];
>> +    int i;
>> +
>> +    if (smp_cpus > FSL_IMX7_NUM_CPUS) {
>> +        error_report("%s: Only %d CPUs are supported (%d requested)",
>> +                     TYPE_FSL_IMX7, FSL_IMX7_NUM_CPUS, smp_cpus);
>> +        exit(1);
>> +    }
>> +
>> +    for (i =3D 0; i < smp_cpus; i++) {
>> +        object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
>> +                          "cortex-a7-" TYPE_ARM_CPU);
> pls reuse ARM_CPU_TYPE_NAME() macro here

Will do in v4.

Thanks,
Andrey Smirnov
