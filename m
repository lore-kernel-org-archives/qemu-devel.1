Received: from eggs.gnu.org ([2001:4830:134:3::10]:37319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1faHtL-0002qe-Pv
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1faHtH-0005oC-0q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:46:35 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com
	([104.47.34.132]:1472
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1faHtG-0005mO-J3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:46:30 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 3 Jul 2018 09:46:26 +0000
Message-ID: <BN7PR08MB4868110F66E113B4E1C8AE7CC6420@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180217192215.28581-1-paul.burton@mips.com>
	<20180217192215.28581-2-paul.burton@mips.com>
	<a67d6a92-7a00-e1e2-541e-843e676c9c19@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/net: Add support for Intel pch_gbe
 ethernet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Paul Burton <pburton@wavecomp.com>, Jason Wang <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 03.07.2018. 01:37, Philippe Mathieu-Daud=E9 wrote:=0A=
> Cc'ing Jason, the "Network devices" maintainer.=0A=
>=0A=
> On 02/17/2018 04:22 PM, Paul Burton wrote:=0A=
>> This patch introduces support for emulating the ethernet controller=0A=
>> found in the Intel EG20T Platform Controller Hub, referred to as pch_gbe=
=0A=
>> for consistency with both Linux & U-Boot.=0A=
>>=0A=
>> Documentation for the hardware can be found here:=0A=
>>=0A=
>>   https://www.intel.com/content/www/us/en/intelligent-systems/queens-bay=
/platform-controller-hub-eg20t-datasheet.html=0A=
>>=0A=
>> The device is used on MIPS Boston development boards as well as the=0A=
>> Intel Crown Bay platform including devices such as the Minnowboard V1.=
=0A=
>>=0A=
>> Enough functionality is implemented for Linux to make use of the device,=
=0A=
>> and has been tested using Linux v4.16-rc1.=0A=
=0A=
Acked-by: Aleksandar Markovic <AMarkovic@wavecomp.com>=0A=
=0A=
We need this device to complete QEMU's MIPS Boston board support. May I=0A=
ask Jason to take a closer look at the proposed code for this network=0A=
device?=0A=
=0A=
Regards,=0A=
Aleksandar=0A=
