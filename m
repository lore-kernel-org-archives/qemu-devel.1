Received: from eggs.gnu.org ([2001:4830:134:3::10]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctcPh-0008KC-Ix
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctcPg-0003Fx-LF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:55:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-10-git-send-email-armbru@redhat.com>
	<803b1948-3968-7068-8f75-a3d77746ea22@redhat.com>
Date: Thu, 30 Mar 2017 17:54:57 +0200
In-Reply-To: <803b1948-3968-7068-8f75-a3d77746ea22@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 10:19:55 -0500")
Message-ID: <878tnmsqsu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 09/10] squash! nbd: Tidy up
 blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/30/2017 08:15 AM, Markus Armbruster wrote:
>> Drop backward -drive server.data.* compatibility gunk.  On squash,
>> replace commit message's last paragraph "Unfortunately, SocketAddress
>> is also visible..." by:
>
> Maybe I should glance at the whole thread before reviewing without
> realizing what is coming later ;)

Maybe I should point out such stunts in my cover letters :)

>> Unfortunately, SocketAddress is also visible in -drive since 2.8:
>> 
>>     -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345
>> 
>> Nobody should be using it, as it's fairly new and has never been
>> documented, so adding still more compatibility gunk to keep it working
>> isn't worth the trouble.  You now have to use
>> 
>>     -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345
>
> As pointed out on 8/10, it might be worth documenting that while legacy
> 'port' is optional, the new 'server.port' is mandatory.

The combined commit message doesn't mention the "bare" legacy syntax.
I'd have to explain it first.  I'm afraid it would be a distraction.
server.port is mandatory elsewhere, too.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/nbd.c | 41 +----------------------------------------
>>  1 file changed, 1 insertion(+), 40 deletions(-)
>> 
>
> When squashed with 8/10, it does make that patch more palatable (all the
> concerns I expressed there were ripped out here).  So if no one else has
> a strong argument for keeping 'server.data.*' back-compat, then the
> squash of 8+9 together can have:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
