Received: from eggs.gnu.org ([2001:4830:134:3::10]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dgAOU-0002fu-EK
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dgAOT-0002oB-D2
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:54:30 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:58474
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dgAOT-0002na-66
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:54:29 -0400
References: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
	<4e23401d-0c39-feb1-13e8-0f3b4cc3b960@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <9b18135b-bbcc-893b-3d8c-43878cbce130@adacore.com>
Date: Fri, 11 Aug 2017 15:53:58 +0200
MIME-Version: 1.0
In-Reply-To: <4e23401d-0c39-feb1-13e8-0f3b4cc3b960@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, crosthwaite.peter@gmail.com, QEMU Developers <qemu-devel@nongnu.org>



On 08/11/2017 01:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Frederic,
>=20
> I'm slowly working on Hercules MCU peripherals and use a R4F core.
>=20
>> It seems that when I try to load a big endian image on a
>> Cortex-R5 it gets confused:
>>   * the instructions are fine it executes some code.
>=20
> So far no problem here
>=20
>>   * GDB address / insns are wrong endianness.
>=20
> Maybe I didn't hit this problem since I use the same setup than=20
> with openocd/real cpu with the following .gdbinit:
>=20
>      set architecture armv5te
>      set arm fpu vfp
>      set endian big
>      set remote hardware-breakpoint-limit 6
>      set breakpoint auto-hw on
>      set displaced-stepping on
>=20
>>   * in monitor x command is good endianness.
>>   * the data order seems to be wrong endianness:
>>     Here is my Hello World: lleHlroW
>=20
> Indeed I hit a similar problem and found that=20
> memory::access_with_adjusted_size() has some issues, I could=20
> never finish the unit-tests but this is the first entry on my=20
> 2.11 TODO.
>=20
> I'll send as RFC.

Hi Philippe,

It would be nice!

Thanks!
Fred

>=20
> Regards,
>=20
> Phil.
