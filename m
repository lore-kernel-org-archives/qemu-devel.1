Received: from eggs.gnu.org ([2001:4830:134:3::10]:47565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fEDQQ-0008U4-5Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fEDQN-000065-1l
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:33:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180503122241.GA6140@localhost.localdomain>
References: <w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
	<w51h8nqcijb.fsf@maestria.local.igalia.com>
	<aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
	<20180503122241.GA6140@localhost.localdomain>
Date: Thu, 03 May 2018 14:33:24 +0200
Message-ID: <w518t907wbv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu 03 May 2018 02:22:41 PM CEST, Kevin Wolf wrote:
> Am 02.05.2018 um 16:12 hat Max Reitz geschrieben:
>> On 2018-05-02 15:07, Alberto Garcia wrote:
>> > Were the (more or less) exact requirements of QMP blockdev-reopen
>> > discussed? How is it different from qemu-io's "reopen" command? What are
>> > the options that you can and can not change?
>> 
>> I can't quite remember, I'm afraid.  I think it was supposed to be
>> pretty much qemu-io's reopen (so just bdrv_reopen()).  I suppose you
>> cannot change the driver (obviously) or probably the node name, because
>> either would result in the node being replaced by a completely new one.
>> 
>> Other than that, it probably depends on what the block driver supports,
>> but ideally you should be able to change everything.
>
> Honestly the design of bdrv_reopen() is quite broken because of the way
> it tries to maintain old options if they aren't specified, and guesses
> what you might mean when you add flags to the mix. The exact semantics
> are quite complicated and I'd rather avoid them in a stable API.
>
> A clean QMP command would probably apply the same defaults as
> blockdev-add, so you just get to specify the full options again.

Ok, so the end result would be more or less equivalent to "open the new
block device with blockdev-add and the user-specified options, then
replace the old one with the new one", but implemented with reopen
instead of open + replace.

Berto
