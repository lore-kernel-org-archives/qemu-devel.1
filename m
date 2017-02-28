Received: from eggs.gnu.org ([2001:4830:134:3::10]:41398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilIN-0007SS-Ar
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilIJ-0001Bu-Bw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:10:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilIJ-0001BW-6F
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:10:35 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 629818046A
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:10:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-19-git-send-email-armbru@redhat.com>
	<08607c1c-0293-1f5c-787a-029d08b92ef3@redhat.com>
	<87y3wql0cu.fsf@dusky.pond.sub.org>
Date: Tue, 28 Feb 2017 18:10:32 +0100
In-Reply-To: <87y3wql0cu.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 28 Feb 2017 17:57:21 +0100")
Message-ID: <87poi2jl6f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 18/26] tests-qobject-input-strict: Merge
 into test-qobject-input-visitor
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

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 02/26/2017 03:43 PM, Markus Armbruster wrote:
>>> Much test-qobject-input-strict.c duplicates
>>
>> s/Much/Much of/
>>
>>> test-qobject-input-strict.c less assertions on expected output:
>>
>> s/less/, but with less/
>
> Will fix.
>
>>
>> ...
>>> 
>>> Merge the remaining test cases into test-qobject-input-visitor.c, and
>>> drop the now redundant test-qobject-input-strict.c.
>>> 
>>> Test case "/visitor/input-strict/fail/list" isn't really about lists,
>>> it's about a bad struct nested in a list.  Rename accordingly.
>>> 
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>>
>>> -static void test_validate_struct_nested(TestInputVisitorData *data,
>>> -                                         const void *unused)
>>> -{
>>> -    UserDefTwo *udp = NULL;
>>> -    Visitor *v;
>>> -
>>> -    v = validate_test_init(data, "{ 'string0': 'string0', "
>>> -                           "'dict1': { 'string1': 'string1', "
>>> -                           "'dict2': { 'userdef': { 'integer': 42, "
>>> -                           "'string': 'string' }, 'string': 'string2'}}}");
>>> -
>>
>> Old code had semi-sane line wrapping...
>>
>>
>>> +++ b/tests/test-qobject-input-visitor.c
>>> @@ -5,6 +5,7 @@
>>>   *
>>
>>> +static void test_visitor_in_fail_struct_nested(TestInputVisitorData *data,
>>> +                                               const void *unused)
>>> +{
>>> +    UserDefTwo *udp = NULL;
>>> +    Error *err = NULL;
>>> +    Visitor *v;
>>> +
>>> +    v = visitor_input_test_init(data, "{ 'string0': 'string0', 'dict1': { 'string1': 'string1', 'dict2': { 'userdef1': { 'integer': 42, 'string': 'string', 'extra': [42, 23, {'foo':'bar'}] }, 'string2': 'string2'}}}");
>>
>>
>> ...new code has insanely long lines.  Not a show-stopper, but I wouldn't
>> mind if you added line breaks.
>
> Editing accident.  I'll restore the line breaks.

Actually, no: I moved it verbatim.  The code you quoted is a different
function.

I'll leave it unchanged.

>> It's a little bit hard to follow the patch alone, but I didn't spot any
>> obvious loss of coverage and the commit message definitely helps.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Thanks!
