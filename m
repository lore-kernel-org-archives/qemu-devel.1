Received: from eggs.gnu.org ([2001:4830:134:3::10]:56558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1Z2p-00033M-QD
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1Z2m-00009I-IX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:28:35 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:54095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1Z2m-000063-BQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:28:32 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B1307D9D2E
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 16:28:27 +0200 (CEST)
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-2-clg@kaod.org>
	<20171006090722.GD10961@umbus.fritz.box>
	<1507283610.25065.148.camel@kernel.crashing.org>
	<20171006101010.GK10961@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <602aaf47-e805-c541-a4f1-cbb4b40a06e3@kaod.org>
Date: Mon, 9 Oct 2017 16:28:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171006101010.GK10961@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 10/06/2017 12:10 PM, David Gibson wrote:
> On Fri, Oct 06, 2017 at 11:53:30AM +0200, Benjamin Herrenschmidt wrote:
>> On Fri, 2017-10-06 at 20:07 +1100, David Gibson wrote:
>>> Hm.  Checking mmu_model doesn't seem right to me.  I mean, it'll get
>>> the right answer in practice, but the LPCR programming has nothing
>>> whatsoever to do with the MMU.
>>>
>>> I think explicitly checking if cpu_ is a POWER9 instance with
>>> object_dynamic_cast would be a better option.
>>
>> Best is ARCH 300 ... do we hvae arch versions outside of MMU model
>> these days ?
> 
> Not that I could spot easily.  Apart from implicitly in the cpu
> family.
> 

how about : 

	pcc->pvr_match(pcc, CPU_POWERPC_LOGICAL_3_00);

C.
