Received: from eggs.gnu.org ([2001:4830:134:3::10]:59311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSQTs-0002pa-NV
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSQTp-0000VA-Cf
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:52:04 -0500
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:48578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSQTp-0000US-4F
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:52:01 -0500
Received: from player688.ha.ovh.net (unknown [10.109.159.7])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 97C28E8CDA
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 18:51:59 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-9-clg@kaod.org>
	<20181127234956.GR2251@umbus.fritz.box>
	<c16b55c5-8144-82bc-37f7-70427c6460a4@kaod.org>
	<20181129004718.GJ2251@umbus.fritz.box>
	<39eb027df3340121ba9877e689e4d0a2747c5e43.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <caa36063-dcf6-c415-3a50-8759e4d53072@kaod.org>
Date: Thu, 29 Nov 2018 18:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <39eb027df3340121ba9877e689e4d0a2747c5e43.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/36] ppc/xive: introduce a simplified
 XIVE presenter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/29/18 4:39 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-11-29 at 11:47 +1100, David Gibson wrote:
>>
>> 1) read/write accessors which take a word number

ok for single word updates of the structures.

>> 2) A "get" accessor which copies the whole structure, 

ok

>> but "write"
>> accessor which takes a word number.  The asymmetry is a bit ugly, but
>> it's the non-atomic writeback of the whole structure which I'm most
>> uncomfortable with.

And, how would you make the update of the whole structure in RAM look 
"atomic" under QEMU ? 

> It shouldn't be a big deal though, there are HW facilities to access
> the structures "atomically" anyway, due to the caching done by the
> XIVE.

Are you suggesting that the PowerNV model should update the VPC, EQC, 
IVC in the VST accessors before updating the VSTs in RAM ?
>> 3) A map/unmap interface which gives you / releases a pointer to the
>> "live" structure.  For powernv that would become
>> address_space_map()/unmap().  

yes.

>> For PAPR it would just be reutn pointer  / no-op.

ok

I think I will introduce these handlers progressively in the patchset.

Thanks,

C. 
