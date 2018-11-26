Received: from eggs.gnu.org ([2001:4830:134:3::10]:50884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRC2p-0001Uk-Aa
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRC2i-00087H-LB
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:15:03 -0500
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRC2i-00085g-Dm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:14:56 -0500
Received: from player793.ha.ovh.net (unknown [10.109.160.46])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C9CA11C2C94
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 09:14:54 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-2-clg@kaod.org>
	<20181122030516.GB10448@umbus.fritz.box>
	<658dc2ad-e862-4777-9ed5-1ba82a074aa6@kaod.org>
	<20181123003115.GR10448@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <88240454-793a-9770-db6e-489dc9647f94@kaod.org>
Date: Mon, 26 Nov 2018 09:14:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181123003115.GR10448@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/36] ppc/xive: introduce a XIVE
 interrupt source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

>>>> + */
>>>> +
>>>> +#ifndef PPC_XIVE_H
>>>> +#define PPC_XIVE_H
>>>> +
>>>> +#include "hw/sysbus.h"
>>>
>>> So, I'm a bit dubious about making the XiveSource a SysBus device -
>>> I'm concerned it won't play well with tying it into the other devices
>>> like PHB that "own" it in real hardware.
>>
>> It does but I can take a look at changing it to a DeviceState. The 
>> reset handlers might be a concern.
> 
> As "non bus" device I think you'd need to register your own reset
> handler rather than just setting dc->reset.  Otherwise, I think that
> should work.

I removed from XIVE the SysBus dependencies and indeed it's better 
not to rely on the default reset and mapping behavior of sysbus. 

I am addressing your comments in a WIP v6 branch on github.   

C.
