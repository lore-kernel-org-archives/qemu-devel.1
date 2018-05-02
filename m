Received: from eggs.gnu.org ([2001:4830:134:3::10]:37774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fDrUp-0003kq-Jm
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fDrUm-0005KX-FC
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:08:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
Date: Wed, 02 May 2018 15:07:52 +0200
Message-ID: <w51h8nqcijb.fsf@maestria.local.igalia.com>
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 25 Apr 2018 04:03:22 PM CEST, Max Reitz wrote:
>>> But the question stands whether we need simple node replacement when
>>> we want bdrv_reopen() anyway.  In addition, we don't need just
>>> replacement, we also need addition and removal (e.g. for backing
>>> files or quorum children) -- and especially in the case of quorum,
>>> that is going to be a pain (mostly naming the children).
>>>
>>> With bdrv_reopen(), we can just require the user to respecify all
>>> children, so we don't run into the issue of how to name things at
>>> least.
>> 
>> So in this example, if you want to replace [B] with [E] you would
>> reopen [C] specifying the new backing file?
>> 
>>    [A] <- [B] <- [C] <- [D]
>> 
>>           [E]
>
> You can just use child node name references like in blockdev-add.

Were the (more or less) exact requirements of QMP blockdev-reopen
discussed? How is it different from qemu-io's "reopen" command? What are
the options that you can and can not change?

Also, you could replace an element in the backing chain using reopen,
but can you replace a node that is not a backing image of another one?

With QMP blockdev-replace you could use the existing blockdev-add
command and create an arbitrary tree and then simply do blockdev-replace
so I suppose that for some use cases at least it would be pretty
straightforward.

Berto
