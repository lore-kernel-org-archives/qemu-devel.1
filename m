Received: from eggs.gnu.org ([2001:4830:134:3::10]:44363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO0nM-0001kV-Rj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO0nI-0003OC-5C
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fO0nI-0003Kv-0t
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:36 -0400
References: <20180530030109.22404-1-chen_han_xiao@126.com>
	<38cf2387-bbac-e4e8-4c7f-d7ba9bdcd0e2@redhat.com>
	<5e690898.591a.163afd447ec.Coremail.chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9335469d-ee0f-e6ac-7570-0b5ccab1ca57@redhat.com>
Date: Wed, 30 May 2018 08:05:34 -0500
MIME-Version: 1.0
In-Reply-To: <5e690898.591a.163afd447ec.Coremail.chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/30/2018 01:55 AM, Chen Hanxiao wrote:

>>> +    usage = u100 / nonroot_total + (u100 % nonroot_total != 0);
>>
>> Why integral instead of floating point?
> 
> I followed the style of df from coreutils.
> As the percentage already multiplied by 100,
> I think it has enough precision.

You're making an arbitrary policy decision.  Give the client a floating 
point, and they can still truncate to print out a 2-digit percentage. 
But give them a percentage, and for a 2T disk image, they are forced to 
guess whether they are 20G high or low on usage, which starts to take a 
non-trivial amount of time to copy that much data.  In other words, I 
think an int is wrong for being too imprecise.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
