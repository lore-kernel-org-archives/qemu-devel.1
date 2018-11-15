Received: from eggs.gnu.org ([2001:4830:134:3::10]:43334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNMVo-0001Ij-Ik
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNMVn-0007wC-NX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:37:08 -0500
References: <20181113230319.1008531-1-eblake@redhat.com>
	<20181114143526.GD10481@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e9c7103-cc52-7535-7b32-2169ec31775e@redhat.com>
Date: Thu, 15 Nov 2018 12:36:59 -0600
MIME-Version: 1.0
In-Reply-To: <20181114143526.GD10481@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 v3 0/3] minor qcow2 compression
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com

On 11/14/18 8:35 AM, Kevin Wolf wrote:
> Am 14.11.2018 um 00:03 hat Eric Blake geschrieben:
>> As the added iotests shows, we have a (corner case) data corruption
>> that is user triggerable, therefore, this is still appropriate for
>> inclusion in 3.1.
> 
> Thanks, applied to the block branch.

Patch 2 and 3 are fine; but Berto raised questions about patch 1 so I 
posted a v9 of that patch, in case you want to replace it in your queue 
and/or defer it out of 3.1 and instead save it for 4.0.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
