Received: from eggs.gnu.org ([2001:4830:134:3::10]:49946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgnDT-0002Ri-Sw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgnDQ-0000oN-Oq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:49:27 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:34479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cgnDQ-0000o2-Hd
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:49:24 -0500
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 11EAA59D4F
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:49:21 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<20170222033423.GK12577@umbus.fritz.box>
	<e58f7cfa-c03c-ca25-a973-7894253d2dcc@kaod.org>
	<20170223030711.GC12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <57502359-c5d6-d189-8220-2a1752e788fa@kaod.org>
Date: Thu, 23 Feb 2017 07:49:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170223030711.GC12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/22] ppc/xics: simplify ICS and ICP
 creation
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

On 02/23/2017 04:07 AM, David Gibson wrote:
>> FYI, the xics-cleanup branch has some issue with migration :
>>
>> qemu-system-ppc64: VQ 0 size 0x80 < last_avail_idx 0x9f9 - used_idx 0x0
>> qemu-system-ppc64: Failed to load virtio-blk:virtio
>> qemu-system-ppc64: error while loading state for instance 0x0 of device 'pci@800000020000000:01.0/virtio-blk'
>>
>> This is most probably a temporary regression, unrelated to XICS 
>> though.
> Hmm.  I'm lss sure.  This series changes the qom paths of ics and icp
> devices, which I'd expect to mess with migration, though I haven't had
> a chance to actually check yet.
> 

Just to be clear, the problem occurs without this patchset. 
It's inherent to the branch, but you will need the fix on 
XICS to start the guest.

C.
