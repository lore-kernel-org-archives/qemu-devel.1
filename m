Received: from eggs.gnu.org ([2001:4830:134:3::10]:45330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnosY-0008RK-Mr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnosX-00024l-Oj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:37:42 -0400
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-3-lbloch@janustech.com>
	<w51r2j7butk.fsf@maestria.local.igalia.com>
	<4e5aaa3e-0ad5-74b1-2569-7d3cbec279eb@janustech.com>
	<w51k1ozblpd.fsf@maestria.local.igalia.com>
	<93a5da55-b5d8-05fc-6643-98e71c423237@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <246853e7-2873-974b-fa0f-d0daeb5fcc4a@redhat.com>
Date: Thu, 9 Aug 2018 12:37:28 -0500
MIME-Version: 1.0
In-Reply-To: <93a5da55-b5d8-05fc-6643-98e71c423237@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Assign the L2 cache
 relatively to image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 08/09/2018 11:46 AM, Leonid Bloch wrote:
>>>> There are no functional changes, why do you need to change the
>>>> indentation here?
>>>
>>> It's in the "immediate area (few lines) of the lines [I'm] changing".
>>
>> But there's no need to change those lines unless there's an obvious
>> mistake. In this case it's just a matter of style so they just add noise
>> to the patch.
> 
> Again, it just looks nicer, more readable, compliant to the generally 
> accepted style, and right next to the functional changes. It's a style 
> improvement which is in the immediate vicinity of the functional 
> improvements. I made another one, you must have seen it already, in v5.
> 
> Look, it just looks better. It's possible to make another patch for 
> these cosmetic changes, but is it worth it when they are right next to 
> the functional changes? It's a bit of noise in the patch, versus noise 
> in the Git history.

Patch splitting is an art form. But it IS easier to review two patches 
(one that fixes style but has no semantic change, and one that does 
semantic change in as few lines as possible) than to review one (that 
mixes both steps at once).  The more things you do in a single patch, 
the more likely you were to be better off by having split it into 
independent patches.

A longer git history is not a problem. Our bottleneck is reviewer time, 
and everything you can do to make life easier for reviewers is a net win 
in overall time spent on the project. And splitting two distinct changes 
  IS worthwhile, especially when a reviewer has requested that split.

Along those lines, I'll also comment that I've seen Berto request that 
you consider splitting even the functional part of this patch into two 
pieces - one raising the default value, and the other fixing things to 
use only what is needed rather than the full specified length when the 
specified/default length is larger than necessary.  It's not a hard 
split, and while you've continued to argue against the split, I tend to 
agree that doing the two parts separately makes the series a bit easier 
to backport to other stable branches (for example, if a distro wants to 
change to yet a different default value, but still use your patch that 
changes to not overallocate when the specified/default is larger than 
needed).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
