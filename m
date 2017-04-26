Received: from eggs.gnu.org ([2001:4830:134:3::10]:45547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3N48-0002WF-2k
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3N44-0005In-5B
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:33:08 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:56313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d3N43-0005Hi-V2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:33:04 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 89E3C6F052
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:33:01 +0200 (CEST)
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
	<20170426023843.GJ16882@umbus.fritz.box>
	<fbf91cf1-53d1-4b75-74b3-fa9abefdd788@kaod.org>
	<CAFEAcA_WJP0tBKayzjZ4iVBCjfiQp+bGz_c2RpfwmhLwxM90ug@mail.gmail.com>
	<CAFEAcA-hhB4PC8QHDr3agixYqg-E=Z+7yQDGwAn78dARJWUY3Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <701a8274-5126-cc42-c438-d18a00f59f08@kaod.org>
Date: Wed, 26 Apr 2017 15:32:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hhB4PC8QHDr3agixYqg-E=Z+7yQDGwAn78dARJWUY3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 04/26/2017 03:15 PM, Peter Maydell wrote:
> On 26 April 2017 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>> All the stuff about shifts is false positives, because the sanitizer
>> doesn't know that -fwrapv makes these operations defined behaviour.
>>
>> Newer versions of clang I think get this correct, and less new
>> but not ancient clang has a flag that says "don't report that
>> particular set of shift errors".
> 
> I just looked into this, and I think the best set of configure options is:
> '--cc=clang' '--cxx=clang++' '--extra-cflags=-fsanitize=undefined
> -fno-sanitize=shift-base -Werror'

Ah ! Too fast you are for me :) you beat me to it. 

> Works with clang-3.8.0 at least.

Yes. confirmed.

Thanks,

C. 
