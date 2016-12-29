Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cMPCG-00032z-5w
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 20:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cMPCC-00032N-WB
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 20:07:56 -0500
Received: from [59.151.112.132] (port=5786 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cMPCC-0002t8-Jf
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 20:07:52 -0500
References: <1482824413-25837-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<6daeb5be-96d5-b474-9708-5d9041cdd0e2@redhat.com>
	<20161228152150.qpnf25jsf5ps4yna@kamzik.brq.redhat.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58646305.6080402@cn.fujitsu.com>
Date: Thu, 29 Dec 2016 09:12:37 +0800
MIME-Version: 1.0
In-Reply-To: <20161228152150.qpnf25jsf5ps4yna@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] doc/pcie: correct command line examples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com



On 12/28/2016 11:21 PM, Andrew Jones wrote:
> On Wed, Dec 28, 2016 at 03:24:30PM +0200, Marcel Apfelbaum wrote:
>> On 12/27/2016 09:40 AM, Cao jin wrote:
>>> Nit picking: Multi-function PCI Express Root Ports should mean that
>>> 'addr' property is mandatory, and slot is optional because it is default
>>> to 0, and 'chassis' is mandatory for 2nd & 3rd root port because it is
>>> default to 0 too.
>>>
>>> Bonus: fix a typo(2->3)
>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>> ---
>>>  docs/pcie.txt | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/docs/pcie.txt b/docs/pcie.txt
>>> index 9fb20aaed9f4..54f05eaa71dc 100644
>>> --- a/docs/pcie.txt
>>> +++ b/docs/pcie.txt
>>> @@ -110,18 +110,18 @@ Plug only PCI Express devices into PCI Express Ports.
>>>            -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
>>>            -device <dev>,bus=root_port1
>>>  2.2.2 Using multi-function PCI Express Root Ports:
>>> -      -device ioh3420,id=root_port1,multifunction=on,chassis=x,slot=y[,bus=pcie.0][,addr=z.0] \
>>> -      -device ioh3420,id=root_port2,chassis=x1,slot=y1[,bus=pcie.0][,addr=z.1] \
>>> -      -device ioh3420,id=root_port3,chassis=x2,slot=y2[,bus=pcie.0][,addr=z.2] \
>>> -2.2.2 Plugging a PCI Express device into a Switch:
>>> +      -device ioh3420,id=root_port1,multifunction=on,chassis=x,addr=z.0[,slot=y][,bus=pcie.0] \
>>> +      -device ioh3420,id=root_port2,chassis=x1,addr=z.1[,slot=y1][,bus=pcie.0] \
>>> +      -device ioh3420,id=root_port3,chassis=x2,addr=z.2[,slot=y2][,bus=pcie.0] \
>>> +2.2.3 Plugging a PCI Express device into a Switch:
>>>        -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
>>>        -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]          \
>>>        -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]] \
>>>        -device <dev>,bus=downstream_port1
>>>
>>>  Notes:
>>> -  - (slot, chassis) pair is mandatory and must be
>>> -     unique for each PCI Express Root Port.
>>> +  - (slot, chassis) pair is mandatory and must be unique for each
>>> +    PCI Express Root Port. slot is default to 0 when doesn't specify it.
> 
> Please rewrite last sentence as
> 
>  slot defaults to 0 when not specified.

Thanks for pointing it out, v2 is on the way.

-- 
Sincerely,
Cao jin

> 
>>>    - 'addr' parameter can be 0 for all the examples above.
>>>
>>>
>>>
>>
>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>>
>> Thanks,
>> Marcel
>>
> 
> Thanks,
> drew
> 
> 
> .
> 
