Received: from eggs.gnu.org ([2001:4830:134:3::10]:51669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3ds-00024i-Bq
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3dp-00007d-AO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3dp-00007I-4e
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:46:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-38-git-send-email-armbru@redhat.com>
	<bc3be621-32d3-3c3f-2c9e-28de700742e3@redhat.com>
Date: Wed, 15 Mar 2017 08:46:37 +0100
In-Reply-To: <bc3be621-32d3-3c3f-2c9e-28de700742e3@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 15:58:41 -0500")
Message-ID: <877f3rq8wy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 37/47] qapi: Fix detection of bogus
 member documentation
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

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> check_definition_doc() checks for member documentation without a
>> matching member.  It laboriously second-guesses what members
>> QAPISchema._def_exprs() will create.  That's a stupid game.
>> 
>> Move the check into QAPISchema.check(), where the members are known.
>> Delegate the actual checking to new QAPIDoc.check().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi.py                             | 38 ++++++++++-------------------
>>  tests/qapi-schema/doc-bad-union-member.err  |  1 +
>>  tests/qapi-schema/doc-bad-union-member.exit |  2 +-
>>  tests/qapi-schema/doc-bad-union-member.out  | 11 ---------
>>  4 files changed, 15 insertions(+), 37 deletions(-)
>
> Nice diffstat.
>
>
>> +++ b/tests/qapi-schema/doc-bad-union-member.err
>> @@ -0,0 +1 @@
>> +tests/qapi-schema/doc-bad-union-member.json:3: The following documented members are not in the declaration: a, b
>
> Nice that you're able to report all problems within the doc, rather than
> stopping at the first.  (Wish we could do the same about the overall
> .json file, but that's harder, and out of scope for this series)

Nice to have, but whether it would be worth the error recovery
complications is doubtful.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
