Received: from eggs.gnu.org ([209.51.188.92]:34835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1Wbp-0004Es-Ur
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1Wbp-0005YK-6V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:29:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:48980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1Wbo-0005Xo-Qm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:29:21 -0500
Date: Wed, 6 Mar 2019 14:29:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <ad80f2f0-535f-0fe8-abef-6cd0855f09c1@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1903061423000.30260@zero.eik.bme.hu>
References: <201903061321.58890.randrianasulu@gmail.com>
	<ad80f2f0-535f-0fe8-abef-6cd0855f09c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>, =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-devel@nongnu.org

On Wed, 6 Mar 2019, Philippe Mathieu-Daud=E9 wrote:
>> Oh, and sadly my little "disable bitblit" patch was still needed:
>>
>> diff --git a/fb/cfb_console.c b/fb/cfb_console.c
>> index 6663ef7..f29c43f 100644
>> --- a/fb/cfb_console.c
>> +++ b/fb/cfb_console.c
>> @@ -113,7 +113,7 @@ CONFIG_VIDEO_HW_CURSOR:          - Uses the hardwa=
re cursor capability of the
>>  #define CONFIG_VIDEO_LOGO
>>  #define        CONFIG_VIDEO_BMP_LOGO
>>  //#define DEBUG_CFG_CONSOLE
>> -#define VIDEO_HW_BITBLT
>> +//#define VIDEO_HW_BITBLT
>>  #elif defined(SMI712)
>>  #define CONFIG_VIDEO_SW_CURSOR
>>  //#define CONFIG_VIDEO_LOGO
>>
>> otherwise pmon was not scrolling help text or any messages up.
>
> This doesn't seem PMON related but a feature of the fulong2e that QEMU
> doesn't model yet.

It is ati-vga specific not fulong2e specific and it's entirely possible=20
(even likely) that my minimal ati-vga emulation is not correct for 2d=20
acceleration yet but I've tested it with the pmon_2e.bin binary from the=20
same place and it worked with that. So if it does not work with the binar=
y=20
pmon for you then that's not the same what I see or if it works with the=20
binary but not with the one compiled then either you're compiling another=
=20
version that does something differently or there's a difference in config=
.=20
There are several Bonito configs in pmon and the fulong2e might use=20
another one or different options.

Regards,
BALATON Zoltan
