Received: from eggs.gnu.org ([2001:4830:134:3::10]:55826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiwgD-0002EF-Cf
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiwg8-0003vc-Jj
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:56:49 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:41415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fiwg8-0003tx-CS
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:56:44 -0400
Received: from player718.ha.ovh.net (unknown [10.109.146.143])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7DCC91CDAC
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 08:56:42 +0200 (CEST)
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-2-clg@kaod.org>
	<20180727035611.GG3694@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6218fc84-9050-8174-0b11-1c379823566a@kaod.org>
Date: Fri, 27 Jul 2018 08:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180727035611.GG3694@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

>> +        /*
>> +         * Other VIO devices register values, when allocated by
>> +         * livirt, are mapped in range [0x00 - 0xef].
>> +         */
>> +        irq = (reg >> 12) & 0xef;
> 
> This mask doesn't do what you intend - it will map 0x10 to 0, for

oops. yes indeed.

> example.  You could use % 0xf0, but actually you might as well just
> use & 0xff.  Yes, it could collide with the vty devices, but either
> way you can still have collisions if you try hard enough.  
> And, either way, they'll get detected later.

I will do that.

C.
