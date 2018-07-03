Received: from eggs.gnu.org ([2001:4830:134:3::10]:45717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faMFO-00038J-Fi
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faMFL-0003Eo-41
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:25:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faMFK-0003Dx-Uo
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:25:35 -0400
Received: by mail-qt0-x244.google.com with SMTP id m13-v6so1706987qth.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 07:25:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180217192215.28581-1-paul.burton@mips.com>
	<20180217192215.28581-2-paul.burton@mips.com>
	<a67d6a92-7a00-e1e2-541e-843e676c9c19@amsat.org>
	<BN7PR08MB4868110F66E113B4E1C8AE7CC6420@BN7PR08MB4868.namprd08.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24289cad-a4bc-6c79-5aed-e15782592f05@amsat.org>
Date: Tue, 3 Jul 2018 11:25:27 -0300
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868110F66E113B4E1C8AE7CC6420@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

Hi Aleksandar,

On 07/03/2018 06:46 AM, Aleksandar Markovic wrote:
> On 03.07.2018. 01:37, Philippe Mathieu-Daudé wrote:
>> Cc'ing Jason, the "Network devices" maintainer.
>>
>> On 02/17/2018 04:22 PM, Paul Burton wrote:
>>> This patch introduces support for emulating the ethernet controller
>>> found in the Intel EG20T Platform Controller Hub, referred to as pch_gbe
>>> for consistency with both Linux & U-Boot.
>>>
>>> Documentation for the hardware can be found here:
>>>
>>>   https://www.intel.com/content/www/us/en/intelligent-systems/queens-bay/platform-controller-hub-eg20t-datasheet.html
>>>
>>> The device is used on MIPS Boston development boards as well as the
>>> Intel Crown Bay platform including devices such as the Minnowboard V1.
>>>
>>> Enough functionality is implemented for Linux to make use of the device,
>>> and has been tested using Linux v4.16-rc1.
> 
> Acked-by: Aleksandar Markovic <AMarkovic@wavecomp.com>
> 
> We need this device to complete QEMU's MIPS Boston board support. May I

I tried to test this device using the 'eng' branch of
git://git.linux-mips.org/pub/scm/linux-mti.git and using the
'64r2el_defconfig' config but I get:

qemu-system-mips64el: Unable to copy device tree in memory
unable to load FIT image

I noticed the PPC machines use the _FDT() macro (see "hw/ppc/fdt.h") to
eventually give more useful error message.

> ask Jason to take a closer look at the proposed code for this network
> device?
> 
> Regards,
> Aleksandar
> 
