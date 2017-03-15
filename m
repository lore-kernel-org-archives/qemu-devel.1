Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coAcO-0003mn-R4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coAcI-0007eb-P0
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coAcI-0007e7-IA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:13:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-3-git-send-email-armbru@redhat.com>
	<3a9be3bd-4634-8ce8-8d95-04b4efa645d0@redhat.com>
Date: Wed, 15 Mar 2017 16:13:31 +0100
In-Reply-To: <3a9be3bd-4634-8ce8-8d95-04b4efa645d0@redhat.com> (Eric Blake's
	message of "Wed, 15 Mar 2017 09:25:38 -0500")
Message-ID: <87vara8tes.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 02/47] qapi: Make doc comments
 optional where we don't need them
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

> On 03/15/2017 07:56 AM, Markus Armbruster wrote:
>> Since we added the documentation generator in commit 3313b61, doc
>> comments are mandatory.  That's a very good idea for a schema that
>> needs to be documented, but has proven to be annoying for testing.
>> 
>> Make doc comments optional again, but add a new directive
>> 
>>     { 'pragma': { 'doc-required': true } }
>> 
>> to let a QAPI schema require them.
>> 
>> Add test cases for the new pragma directive.  While there, plug a
>> minor hole in includ directive test coverage.
>
> s/includ/include/

Will fix.

>> Require documentation in the schemas we actually want documented:
>> qapi-schema.json and qga/qapi-schema.json.
>> 
>> We could probably make qapi2texi.py cope with incomplete
>> documentation, but for now, simply make it refuse to run unless the
>> schema has 'doc-required': true.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +=== Pragma directives ===
>> +
>> +Usage: { 'pragma': DICT }
>> +
>> +The pragma directive lets you control optional generator behavior.
>> +The dictionary's entries are pragma names and values.
>> +
>> +Pragma's scope is currently the complete schema.  Setting it to
>
> You can do:
>
> { 'pragma': { 'doc-required': true } }
> { 'pragma': { 'whitelist': [...] } }
>
> what you can't do is:
>
> { 'pragma': { 'doc-required': true } }
> { 'pragma': { 'doc-required': false } }
>
> Maybe s/Setting it/Setting a given pragma name/

Yes, that's better.  Perhaps "Setting the same pragma to ..."

>> +different values in parts of the schema doesn't work.

I considered rejecting all but the first pragma for any given pragma,
but decided just add this note for now.

>> +
>> +Pragma 'doc-required' takes a boolean value.  If true, documentation
>> +is required.  Default is false.
>> +
>> +
>
> The new tests are nice; thanks.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
