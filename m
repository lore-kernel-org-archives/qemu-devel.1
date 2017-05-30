Received: from eggs.gnu.org ([2001:4830:134:3::10]:35250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFgwp-0008Ra-Lu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFgwk-0002ic-L6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:12:31 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:48828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dFgwk-0002hW-7y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:12:26 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170529205737.fpbiakja36txmsnm@postretch>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
	<w517f0z4sb6.fsf@maestria.local.igalia.com>
	<20170529205737.fpbiakja36txmsnm@postretch>
Date: Tue, 30 May 2017 15:12:21 +0200
Message-ID: <w51a85u32ve.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On Mon 29 May 2017 10:57:37 PM CEST, Manos Pitsidianakis wrote:
>>> A quirk in the current implementation is that the throttling limits
>>> for the group are overwritten by each -drive throttling.group=group0.
>>> Limits for all but the last -drive in a group are ignored.
>>   - bps or iops != 0   -> set the I/O limits of a throttling group. The
>>                           selected device is moved to that group if it
>>                           wasn't there yet.
>>
>>   - bps and iops == 0  -> remove a device from a throttling group
>>                           without touching that group's I/O limits.
>
> These are very unintuitive. However, even without considering
> backwards compatibility, I think that using -object notation (eg
> "object-add throttle-group,id=foo,iops=...) is intuitive in the case
> of groups, but not when you need individual limits for each device as
> the syntax would be too verbose.  Of course the old interface covers
> that.

Yes, that's clear. I think that when adding drives, the command-line UI
-drive throttling.iops=XXX notation is good enough for individual
devices and the -object notation is good for groups.

My question was about the block_set_io_throttle QMP command, which you
can use to change the limits of existing drives.

But I think Kevin is right and we should probably think of an
alternative interface for that.

Berto
