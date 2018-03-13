Received: from eggs.gnu.org ([2001:4830:134:3::10]:41658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evYjb-00065v-OS
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evYja-0003FR-VH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:28:11 -0400
References: <20180306204819.11266-1-stefanha@redhat.com>
	<b0babfd7-71b7-c1cb-52a2-994c7cff843b@redhat.com>
	<20180308173742.GH2769@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <784c7895-d140-8236-2ca5-a88946853b09@redhat.com>
Date: Mon, 12 Mar 2018 20:27:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180308173742.GH2769@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block: fix
 nbd-server-stop crash after blockdev-snapshot-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>

On 03/08/2018 11:37 AM, Stefan Hajnoczi wrote:
> On Wed, Mar 07, 2018 at 05:27:45PM -0600, Eric Blake wrote:
>> On 03/06/2018 02:48 PM, Stefan Hajnoczi wrote:
>>> The blockdev-snapshot-sync command uses bdrv_append() to update all parents to
>>> point at the external snapshot node.  This breaks BlockBackend's
>>> blk_add/remove_aio_context_notifier(), which doesn't expect a BDS change.
>>>

>> Whose tree should this series go through?  MAINTAINERS didn't flag it as
>> directly touching any files that normally affect my NBD queue, but given
>> that the iotest that reproduces the problem uses NBD, I'm fine if you want
>> it to go through me.
> 
> Good question.  Max and Kevin maintain block/block-backend.c so one of
> them should be happy with this series before it gets merged.
> 
> When a patch affects multiple trees, the last sub-maintainer to review
> it can do the merge.
> 
> So if they have already posted their R-b when you are finished, then
> feel free to merge it!  And vice versa.

Max has reviewed, so this is now queued on my NBD tree, pull request to 
come shortly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
