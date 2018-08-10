Received: from eggs.gnu.org ([2001:4830:134:3::10]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8Rw-00024e-0x
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8Rs-0007Ho-2P
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:31:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo8Rr-0007HK-Tp
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:31:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-19-armbru@redhat.com>
	<d2dd81e0-c8d0-a934-d750-c8b97e8010cf@redhat.com>
Date: Fri, 10 Aug 2018 16:31:24 +0200
In-Reply-To: <d2dd81e0-c8d0-a934-d750-c8b97e8010cf@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 13:49:56 -0500")
Message-ID: <877ekyl2df.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/56] json: Revamp lexer documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c | 80 +++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 71 insertions(+), 9 deletions(-)
>>
>
>> + *
>> + * [Numbers:]
>
> Worth also calling out:
>
> [Objects:]
>       object = begin-object [ member *( value-separator member ) ]
>                end-object
>
>       member = string name-separator value
> [Arrays:]
>    array = begin-array [ value *( value-separator value ) ] end-array
>
> so as to completely cover the RFC grammar?

Should this go into json-parser.c?

>> + *
>> + * Extensions over RFC 7159:
>> + * - Extra escape sequence in strings:
>> + *   0x27 (apostrophe) is recognized after escape, too
>> + * - Single-quoted strings:
>> + *   Like double-quoted strings, except they're delimited by %x27
>> + *   (apostrophe) instead of %x22 (quotation mark), and can't contain
>> + *   unescaped apostrophe, but can contain unescaped quotation mark.
>> + * - Interpolation:
>> + *   interpolation = %((l|ll|I64)[du]|[ipsf])
>
> Not in your series, but we recently discussed adding %% (only inside
> strings); coupled with enforcing that all other interpolation occurs
> outside of strings.  I guess we can update this comment at that time.

Message-ID: <87bmaoszf0.fsf@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg05844.html

I meant to do that in this series, but got overwhelmed by all the other
stuff, and forgot.  Thanks for the reminder.  I may still do it in v2.
If not, we can do it on top.

>> + *
>> + * Note:
>> + * - Input must be encoded in UTF-8.
>> + * - Decoding and validating is left to the parser.
>>    */
>>     enum json_lexer_state {
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
