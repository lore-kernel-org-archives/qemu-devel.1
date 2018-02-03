Received: from eggs.gnu.org ([2001:4830:134:3::10]:59165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtRk-0003Yt-Dc
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtRh-0003nX-C1
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:45:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtRh-0003mW-51
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:45:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-2-armbru@redhat.com>
	<b39ec0c6-b2b4-6719-c7ca-0815b6fc76b8@redhat.com>
Date: Sat, 03 Feb 2018 09:45:08 +0100
In-Reply-To: <b39ec0c6-b2b4-6719-c7ca-0815b6fc76b8@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 09:08:40 -0600")
Message-ID: <878tca5unf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 01/21] qapi: Streamline boilerplate
 comment generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>> Every generator has separate boilerplate for .h and .c, and their
>> differences are boring.  All of them repeat the license note.
>> 
>> Reduce the repetition as follows.  Move common text like the license
>> note to common open_output(), next to the existintg common text there.
>
> s/existintg/existing/

Fixing...

>> For each generator, replace the two separate descriptions by a single
>> one.
>> 
>> While there, emit an "automatically generated" note into generated
>> documentation, too.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/scripts/qapi2texi.py
>> @@ -282,7 +282,8 @@ def main(argv):
>>          print >>sys.stderr, ("%s: need pragma 'doc-required' "
>>                               "to generate documentation" % argv[0])
>>          sys.exit(1)
>> -    print texi_schema(schema)
>> +    print '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n'
>> +    print texi_schema(schema),
>
> Spurious addition of trailing comma. Otherwise,

This is Python's (rather unobvious) way to print without adding a
newline.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
