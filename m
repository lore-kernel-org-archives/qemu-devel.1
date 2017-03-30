Received: from eggs.gnu.org ([2001:4830:134:3::10]:38310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbYF-0008Mp-Q7
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbYF-0004Bt-1Q
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:59:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-7-git-send-email-armbru@redhat.com>
	<88188f21-a5b3-2e0f-99f1-66b13d772b96@redhat.com>
Date: Thu, 30 Mar 2017 16:59:43 +0200
In-Reply-To: <88188f21-a5b3-2e0f-99f1-66b13d772b96@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 09:36:40 -0500")
Message-ID: <87mvc2zu74.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 06/10] qapi-schema:
 SocketAddressFlat variants 'vsock' and 'fd'
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
>> Note that the new variants are impossible in qemu_gluster_glfs_init(),
>> because the gconf->server can only come from qemu_gluster_parse_uri()
>> or qemu_gluster_parse_json(), and neither can create anything but
>> 'inet' or 'unix'.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/gluster.c  |  2 ++
>>  qapi-schema.json | 19 ++++++++-----------
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>
>> -# 2. SocketAddressFlat supports only types 'unix' and 'inet', because
>> -#    that's what its current users need.
>> +# This is just like SocketAddress, except it's a flat union rather
>> +# than a simple union.  Nicer because it avoids nesting (i.e. more {})
>> +# on the wire.
>
> I know that you are explaining that it is "nesting" which means "more
> {}", but it is SocketAddress that has the extra {}, not
> SocketAddressFlat.  I wonder if it reads any better as:
>
> Nicer because it avoids nesting on the wire (i.e. this form has fewer {}).

Sold!  (Except I'm peeling off the parenthesis)
