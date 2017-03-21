Received: from eggs.gnu.org ([2001:4830:134:3::10]:59320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE0M-0003Hw-E1
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE0L-0004fr-MP
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:14:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-5-git-send-email-armbru@redhat.com>
	<9775458f-7adc-d8d8-4549-0f4f397c025d@redhat.com>
Date: Tue, 21 Mar 2017 08:14:44 +0100
In-Reply-To: <9775458f-7adc-d8d8-4549-0f4f397c025d@redhat.com> (Eric Blake's
	message of "Mon, 20 Mar 2017 15:02:17 -0500")
Message-ID: <871strummz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] keyval: Document issues with
 'any' and alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 03/20/2017 07:55 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/keyval.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/util/keyval.c b/util/keyval.c
>> index 46cd540..93d5db6 100644
>> --- a/util/keyval.c
>> +++ b/util/keyval.c
>> @@ -61,6 +61,16 @@
>>   * "key absent" already means "optional object/array absent", which
>>   * isn't the same as "empty object/array present".
>>   *
>> + * Design flaw: scalar values can only be strings; there is no way to
>> + * denote numbers, true, false or null.  The special QObject input
>> + * visitor returned by qobject_input_visitor_new_keyval() mostly hides
>> + * this by automatically converting strings to the type the visitor
>> + * expects.  Breaks down for alternate types and type 'any', where the
>> + * visitor's expectation isn't clear.  Code visiting such types needs
>> + * to do the conversion itself, but only when using this keyval
>> + * visitor.  Awkward.  Alternate types without a string member don't
>> + * work at all.
>
> We've toyed with the idea of making socket parsing accept an alternate
> between string and integer (right now it's string due to named port
> support, even though most users end up accessing an integer causing a
> lot of in-tree parsing/formatting between integers and strings) - that
> will be one case that is particularly impacted by this design flaw, if
> we ever go through with that idea.

I'll reply to this in "Re: Non-flat command line option argument
syntax".

>                                     But enough speculation about the
> future - your patch as written is accurate for the present.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
