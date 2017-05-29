Received: from eggs.gnu.org ([2001:4830:134:3::10]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dFRkC-0003fL-T4
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dFRk9-0007Wp-Ru
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:58:28 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:49656)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dFRk9-0007Qd-Gq
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:58:25 -0400
Date: Mon, 29 May 2017 23:57:37 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170529205737.fpbiakja36txmsnm@postretch>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
	<w517f0z4sb6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <w517f0z4sb6.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On Mon, May 29, 2017 at 05:05:17PM +0200, Alberto Garcia wrote:
>On Sat 27 May 2017 09:56:03 AM CEST, Stefan Hajnoczi wrote:
>> A quirk in the current implementation is that the throttling limits
>> for the group are overwritten by each -drive throttling.group=group0.
>> Limits for all but the last -drive in a group are ignored.
>   - bps or iops != 0   -> set the I/O limits of a throttling group. The
>                           selected device is moved to that group if it
>                           wasn't there yet.
>
>   - bps and iops == 0  -> remove a device from a throttling group
>                           without touching that group's I/O limits.

These are very unintuitive. However, even without considering backwards 
compatibility, I think that using -object notation (eg "object-add 
throttle-group,id=foo,iops=...) is intuitive in the case of groups, but 
not when you need individual limits for each device as the syntax would 
be too verbose.  Of course the old interface covers that.  

In any case, is having multiple interfaces a problem or not? And, is 
using QOM straightforward implementation-wise?
