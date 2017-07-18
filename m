Received: from eggs.gnu.org ([2001:4830:134:3::10]:49359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXYi4-0005jC-Dp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXYi3-0004Ce-MV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
	<c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
	<87y3rlrct2.fsf@dusky.pond.sub.org>
	<87lgnlcyz7.fsf@dusky.pond.sub.org>
	<e69c0e46-8470-c994-0caa-3498d1f429c2@redhat.com>
Date: Tue, 18 Jul 2017 22:02:57 +0200
In-Reply-To: <e69c0e46-8470-c994-0caa-3498d1f429c2@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 14:47:01 -0500")
Message-ID: <87wp75a4y6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 02:43 PM, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>> 
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> On 07/18/2017 09:53 AM, Eric Blake wrote:
>>>>> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>>>>>> I expect the 'null' type to be useful mostly for members of alternate
>>>>>> types.
>>>>>>
>>>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>>> ---
>>>>>
>>>>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>
>>>> Actually, do we need to update any qapi docs to mention the new builtin
>>>> type?
>>>
>>> Yes, we do.  I'll give it a shot.
>> 
>> Incremental patch appended.  May I keep your R-by?
>> 
>> 
>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index 52e3874..6d8e00c 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -283,6 +283,7 @@ The following types are predefined, and map to C as follows:
>>                         accepts size suffixes
>>    bool      bool       JSON true or false
>>    any       QObject *  any JSON value
>> +  null      QNull *    JSON null
>>    QType     QType      JSON string matching enum QType values
>
> I might have grouped 'null' next to 'bool', but your layout is also
> okay.  Yes, my R-b is still valid with this addition.

I like your order better; lines swapped.  Thanks!
