Received: from eggs.gnu.org ([2001:4830:134:3::10]:59402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1fOwuv-0000oY-3y
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1fOwur-0005oZ-55
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:09:21 -0400
Received: from mx1.riseup.net ([198.252.153.129]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <procmem@riseup.net>) id 1fOwuq-0005mN-UD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:09:17 -0400
References: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
	<20180601113444.GG8687@stefanha-x1.localdomain>
	<b25b3adb-bacc-bef1-7d18-c71a4933abc1@riseup.net>
	<20180601184855-mutt-send-email-mst@kernel.org>
From: procmem <procmem@riseup.net>
Message-ID: <1f4afbd1-e822-aa63-89a5-ba77c7110168@riseup.net>
Date: Sat, 2 Jun 2018 03:08:54 +0000
MIME-Version: 1.0
In-Reply-To: <20180601184855-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Virtio-net drivers immune to Nethammer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, whonix-devel@whonix.org, jasowang@redhat.com



Michael S. Tsirkin:
> On Fri, Jun 01, 2018 at 01:15:44PM +0000, procmem wrote:
>>
>>
>> Stefan Hajnoczi:
>>> On Mon, May 21, 2018 at 11:24:43PM +0000, procmem wrote:
>>>> Hi I'm a privacy distro maintainer investigating the implications of the
>>>> newly published nethammer attack [0] on KVM guests particularly the
>>>> virtio-net drivers. The summary of the paper is that rowhammer can be
>>>> remotely triggered by feeding susceptible* network driver crafted
>>>> traffic. This attack can do all kinds of nasty things such as modifying
>>>> SSL certs on the victim system.
>>>>
>>>> * Susceptible drivers are those relying on Intel CAT, uncached memory or
>>>> the clflush instruction.
>>>>
>>>> My question is, do virtio-net drivers do any of these things?
>>> I have CCed Michael Tsirkin and Jason Wang, the virtio maintainers.
>>>
>>>> ***
>>>>
>>>> [0] https://arxiv.org/abs/1805.04956
>>>>
>>>>
>>>>
>>
>> Thanks :) I thought my message was forgotten
> 
> 
> I don't think virtio is using either of these.
> 
> Linux does support CAT AFAIK but it has nothing to do with virtio.
> 

Thanks for confirming. This is good news indeed. I am considering
posting about this to kernel-hardening so it's on the sec team's radar
when considering upstream network drivers. What do you think?
