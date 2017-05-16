Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAWuC-0005de-5R
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAWu7-0007OC-Dn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAWu7-0007Nv-8A
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:28:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 320F27F6A8
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:28:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1494866344-11013-1-git-send-email-armbru@redhat.com>
	<764477dc-99b9-ead7-ba97-8c0f6fa4bd9b@redhat.com>
Date: Tue, 16 May 2017 09:28:20 +0200
In-Reply-To: <764477dc-99b9-ead7-ba97-8c0f6fa4bd9b@redhat.com> (Eric Blake's
	message of "Mon, 15 May 2017 12:44:25 -0500")
Message-ID: <87wp9hi7l7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] sockets: Plug memory leak in
 socket_address_flatten()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 05/15/2017 11:39 AM, Markus Armbruster wrote:
>> socket_address_flatten() leaks a SocketAddress when its argument is
>> null.  Happens when opening a ChardevBackend of type 'udp' that is
>> configured without a local address.  Screwed up in commit bd269ebc due
>> to last minute semantic conflict resolution.  Spotted by Coverity.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/qemu-sockets.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Matches the fix I had proposed here against the v2 pull request:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01825.html
>
> I guess in the confusion of the rebasing, you didn't quite implement it
> in v3 the way I had proposed.

I had started to resolve conflicts myself when the message carrying your
solution arrived, and I obviously screwed up merging it into my unclean
tree.  In other words: it's all my fault.
