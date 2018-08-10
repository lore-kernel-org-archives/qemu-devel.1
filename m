Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8CI-00030C-LI
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8CD-0001F2-Nh
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:15:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo8CD-0001ER-Iy
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:15:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-9-armbru@redhat.com>
	<c045c1b3-8f75-9078-85db-9b1a5dcca447@redhat.com>
Date: Fri, 10 Aug 2018 16:15:15 +0200
In-Reply-To: <c045c1b3-8f75-9078-85db-9b1a5dcca447@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:57:38 -0500")
Message-ID: <87va8il34c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/56] check-qjson: Streamline
 escaped_string()'s test strings
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
>> Merge a few closely related test strings, and drop a few redundant
>> ones.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>
>>       } test_cases[] = {
>> -        { "\\b", "\b" },
>> -        { "\\f", "\f" },
>> -        { "\\n", "\n" },
>> -        { "\\r", "\r" },
>> -        { "\\t", "\t" },
>> -        { "/", "/" },
>> -        { "\\/", "/", .skip = 1 },
>> -        { "\\\\", "\\" },
>> -        { "\\\"", "\"" },
>> -        { "hello world \\\"embedded string\\\"",
>> -          "hello world \"embedded string\"" },
>> -        { "hello world\\nwith new line", "hello world\nwith new line" },
>> +        { "\\b\\f\\n\\r\\t\\\\\\\"", "\b\f\n\r\t\\\"" },
>> +        { "\\/\\'", "/'", .skip = 1 },
>
> Aha - this adds coverage of the escaped ' not present in 7/56.

You're right.  I'll move that part there.

> Aha - this adds coverage of the escaped ' not present in 7/56. (Still
> nothing about the unescaped versions of ' or " with correct quoting).
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
