Received: from eggs.gnu.org ([2001:4830:134:3::10]:60529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgbvm-00047i-Ir
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgbvj-0000H5-Gg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:46:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgbvj-0000Gv-Ac
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:46:23 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487709988-14322-1-git-send-email-armbru@redhat.com>
	<1487709988-14322-4-git-send-email-armbru@redhat.com>
	<ba4677a9-6ef4-0e7e-43d4-7314aea26933@redhat.com>
Date: Wed, 22 Feb 2017 19:46:20 +0100
In-Reply-To: <ba4677a9-6ef4-0e7e-43d4-7314aea26933@redhat.com> (Eric Blake's
	message of "Wed, 22 Feb 2017 09:14:32 -0600")
Message-ID: <87fuj6ukqr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/3] i386/cpu: net: Flatten simple union
 GuestPanicInformationType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V . Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/21/2017 02:46 PM, Markus Armbruster wrote:
>> Simple unions are simpler than flat unions in the schema, but more
>> complicated in C and on the QMP wire: there's extra indirection in C
>> and extra nesting on the wire, both pointless.  They're best avoided
>> in new code.  Fix up recent commit d187e08 accordingly.
>> 
>> Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Cc: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi-schema.json  | 14 ++++++++++++--
>>  target/i386/cpu.c | 17 ++++++-----------
>>  vl.c              | 12 ++++++------
>>  3 files changed, 24 insertions(+), 19 deletions(-)
>
> Very similar to Anton's patch which is on Paolo's queue:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04448.html

Wasn't cc'ed, so I missed it.  No biggie.

> I don't care which version goes in, but will leave it to Markus and
> Paolo to decide which queue it should go through.

My commit message is more verbose, and I fix space style in the QAPI
schema.  On the other hand, Anton has an extra QAPI schema comment line.

Picking Anton's is probably simpler, because it's 2/3, and mine looks
like it conflicts with his 1/3.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
