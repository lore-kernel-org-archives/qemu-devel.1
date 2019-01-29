Received: from eggs.gnu.org ([209.51.188.92]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1goQF8-0001eQ-55
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1goQF3-0002Gb-Js
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:03:46 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <87tvhsy6en.fsf@dusky.pond.sub.org>
References: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
	<w51bm469xhh.fsf@maestria.local.igalia.com>
	<w518szam8em.fsf@maestria.local.igalia.com>
	<4236ceac-fd50-ad04-811a-0be7b3dbd667@redhat.com>
	<w51a7jkstdd.fsf@maestria.local.igalia.com>
	<87tvhsy6en.fsf@dusky.pond.sub.org>
Date: Tue, 29 Jan 2019 11:03:27 +0100
Message-ID: <w51ef8v3hn4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Consistency of iotests 093 and 136
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Mon 28 Jan 2019 07:38:08 PM CET, Markus Armbruster wrote:

>> 093 submits several I/O requests using aio_read and aio_write with
>> hmp_qemu_io(), then advances the clock using clock_step and finally
>> calls query-blockstats to see how much of the I/O has been completed
>> (it's an I/O throttling test).
>>
>> The expectation is that by the time query-blockstats is called all
>> submitted I/O requests have been processed (up to the amount allowed
>> by the throttling limits).
>
> Assumptions like "when we see the reply to QMP command X, surely the
> main loop has completed doing Y" are problematic.  When possible, rely
> on something more direct, such as a query command that shows you
> whether Y has been completed.

Right, but how to do that for aio_read / aio_write ?

Berto
