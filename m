Received: from eggs.gnu.org ([2001:4830:134:3::10]:50106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gPjtq-0003iH-7q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gPjtl-0008Q9-4S
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:59:46 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:47258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gPjtk-0008Mv-RP
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:59:41 -0500
Received: from player711.ha.ovh.net (unknown [10.109.146.1])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9C6931EA9FA
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 08:59:38 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <731ece35-0584-63b5-60dc-e53c7a0c5a93@kaod.org>
Date: Thu, 22 Nov 2018 08:59:32 +0100
MIME-Version: 1.0
In-Reply-To: <121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
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

On 11/22/18 7:50 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
>>
>> Sorry, didn't think of this in my first reply.
>>
>> 1) Does the hardware ever actually write back to the EAS?  I know it
>> does for the END, but it's not clear why it would need to for the
>> EAS.  If not, we don't need the setter.
> 
> Nope, though the PAPR model will via hcalls

Indeed. The H_INT_SET_SOURCE_CONFIG hcall updates the EAT.

>> 2) The signatures are a bit odd here.  For the setter, a value would
>> make sense than a (XiveEAS *), since it's just a word.  For the getter
>> you could return the EAS value directly rather than using a pointer -
>> there's already a valid bit in the EAS so you can construct a value
>> with that cleared if the lisn is out of bounds.

Yes we could. I think I made it that way to be consistent with the 
other XIVE internal structures which are bigger : END, NVT

There might be other reasons in Pnv. One was to use generic accessors 
to the guest RAM but I didn't do it finally. Take a look at the Pnv
model and we might decide to change the prototype then. I don't 
think it's a major change.

Thanks,

C.
