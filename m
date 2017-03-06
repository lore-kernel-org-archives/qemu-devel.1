Received: from eggs.gnu.org ([2001:4830:134:3::10]:54656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cku86-0002bB-N5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cku83-0003Ry-LO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:00:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-15-git-send-email-armbru@redhat.com>
	<e67251ad-1f7c-d0da-4a82-12a10ae5e126@redhat.com>
	<87varqi0v7.fsf@dusky.pond.sub.org>
Date: Mon, 06 Mar 2017 16:00:35 +0100
In-Reply-To: <87varqi0v7.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 03 Mar 2017 21:03:40 +0100")
Message-ID: <87r32aqwks.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/15] qapi-schema: Rename
 SocketAddressFlat's variant tcp to inet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 03/02/2017 03:44 PM, Markus Armbruster wrote:
>>> QAPI type SocketAddressFlat differs from SocketAddress pointlessly:
>>> the discriminator value for variant InetSocketAddress is 'tcp' instead
>>> of 'inet'.  Rename.
>>> 
>>> The type is far only used by the Gluster block drivers.  Take care to
>>> keep 'tcp' working there.
>>
>> The old name was visible in QMP in 2.8, but only by blockdev-add, which
>> we've already argued was not stable (and where we've already made other
>> non-back-compat changes to it).  But that means this HAS to go into 2.9,
>> if we're declaring blockdev-add stable for 2.9.
>
> Yes.
>
> Note that the command line pseudo-filename's URI syntax stays the same
> (file=gluster+tcp://), and the command line's dotted key syntax keeps
> accepting tcp for compatiblity (file.server.0.type=tcp works in addition
> to =inet).
>
>> It wouldn't hurt to mention that additional information in the commit
>> message.
>
> I'll cook something up.

Replacing the second paragraph by

    The type is so far only used by the Gluster block drivers.  Take care
    to keep 'tcp' working in things like -drive's file.server.0.type=tcp.
    The "gluster+tcp" URI scheme in pseudo-filenames stays the same.
    blockdev-add changes, but it has changed incompatibly since 2.8
    already.

[...]
