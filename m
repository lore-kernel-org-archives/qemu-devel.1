Received: from eggs.gnu.org ([2001:4830:134:3::10]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gSYlR-0005J8-Jo
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gSYlQ-0003Nk-Fc
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:42:45 -0500
Date: Fri, 30 Nov 2018 03:42:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <71296170-f917-2b24-e1e6-1c525265c2a6@roeck-us.net>
Message-ID: <alpine.BSF.2.21.9999.1811300305450.787@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
	<a05ba14f-b261-bb8c-12a1-4c91d005961f@redhat.com>
	<71296170-f917-2b24-e1e6-1c525265c2a6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Clement Deschamps <clement.deschamps@antfield.fr>

On Thu, 29 Nov 2018, Guenter Roeck wrote:
> On 11/29/18 4:43 PM, Philippe Mathieu-Daud=E9 wrote:
>> Hi Zoltan,
>>=20
>> On 29/11/18 21:29, BALATON Zoltan wrote:
>>> Hello,
>>>=20
>>> I could not boot Raspbian on QEMU's raspi emulation and I'm not sure =
why
>>> it fails. So question is if this is supposed to work or am I doing
>>> something wrong or any clues what may be missing? I'm trying with thi=
s
>>> command line with v3.1.0-rc3:
>>>=20
>>> qemu-system-arm -M raspi2 -serial stdio \
>>> -kernel rpi-kernel7.img -dtb bcm2709-rpi-2-b.dtb \
>>> -append "rw earlyprintk loglevel=3D8 console=3DttyAMA0,115200
>>> dwc_otg.lpm_enable=3D0 root=3D/dev/mmcblk0p2" \
>>> -drive file=3D2018-10-09-raspbian-stretch-lite.img,format=3Draw,if=3D=
sd
>>>=20
>>> Kernel starts to boot, I see raspberries on the guest screen and log
>>> output to serial:
>>>=20
>>> Booting Linux on physical CPU 0xf00
>>> Linux version 4.14.71-v7+ (dc4@dc4-XPS13-9333) (gcc version 4.9.3
>>> (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1145 SMP Fri Sep 21
>>> 15:38:35 BST 2018
>>> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D10c5387d
>>> [...]
>>>=20
>>=20
>
> My version (https://github.com/groeck/qemu) seems to work, using

Tried with your v3.1.0-local branch but got same results (does not find=20
mmcblk0 on raspi2, nothing on raspi3) so probably it's not one of the=20
patches in your tree that's missing.

> multi_v7_defconfig.

Then maybe it's your kernel config that's different? Do you have compiled=
=20
kernels available that I could try?

Thank you,
BALATON Zoltan

> Logs from boots with qemu 3.0 and 3.1 attached.
>
> Command line:
>
> /opt/buildbot/qemu-install/v3.0/bin/qemu-system-arm \
> 	-M raspi2 -kernel arch/arm/boot/zImage -no-reboot \
> 	-snapshot -drive=20
> file=3Dcore-image-minimal-qemuarm.ext3,format=3Draw,if=3Dsd \
> 	--append 'earlycon=3Dpl011,0x3f201000 root=3D/dev/mmcblk0 rootwait rw=20
> console=3DttyAMA0 noreboot' \
> 	-dtb arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
> 	-nographic -monitor null -serial stdio
>
> Guenter
>
