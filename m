Received: from eggs.gnu.org ([2001:4830:134:3::10]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciGwU-0003SB-4c
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciGwQ-0007cD-SB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:46:02 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:56019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciGwQ-0007a9-Ha
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:45:58 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1B269B0123
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:45:52 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-9-git-send-email-clg@kaod.org>
	<20170223022933.GW12577@umbus.fritz.box>
	<6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
	<20170227003050.GI17615@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2fc29a7a-ae6f-63a4-354b-4f4d9176d048@kaod.org>
Date: Mon, 27 Feb 2017 09:45:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170227003050.GI17615@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 08/22] ppc/xics: use the QOM
 interface to resend irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

>>>>  void icp_set_cppr(ICPState *ss, uint8_t cppr)
>>>> @@ -262,7 +261,7 @@ void icp_set_cppr(ICPState *ss, uint8_t cppr)
>>>>          }
>>>>      } else {
>>>>          if (!XISR(ss)) {
>>>> -            icp_resend(ss);
>>>> +            icp_resend(XICS_INTERFACE(qdev_get_machine()), ss);
>>>
>>> Here you're assuming that the machine is the implementor of the xics
>>> interface, which is kinda ugly.  The ICP should have a pointer to the
>>> xics interface, which will eventually replace the pointer to the
>>> overall xics object it has now.
>>
>> yes. I will try improve that. I don't like those calls to 
>> qdev_get_machine()either. 
>>
>> There are done in a couple of places though, under spapr_cpu_core
>> to get XICS for instance.
> 
> Right, but I'm happier with it there, in code that's definitely
> associated with a particular machine, rather than in the xics code
> which is at least somewhat reusable.

I fixed that with the backlink on the XICSFabric. 

C.
