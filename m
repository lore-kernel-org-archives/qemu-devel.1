Received: from eggs.gnu.org ([2001:4830:134:3::10]:33346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7hu-0007Z5-B8
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7hq-0002mS-7h
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:43:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo7hq-0002ly-2d
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:43:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-4-armbru@redhat.com>
	<bd935f52-11d1-8fee-a239-9d32cdff261a@redhat.com>
Date: Fri, 10 Aug 2018 15:43:51 +0200
In-Reply-To: <bd935f52-11d1-8fee-a239-9d32cdff261a@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:36:02 -0500")
Message-ID: <87o9eamj54.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/56] check-qjson: Cover whitespace more
 thoroughly
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
>>   tests/check-qjson.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
>> index 81b92d6b0c..0a9a054c7b 100644
>> --- a/tests/check-qjson.c
>> +++ b/tests/check-qjson.c
>> @@ -1236,7 +1236,7 @@ static void simple_whitespace(void)
>>                       })),
>>           },
>>           {
>> -            .encoded = " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
>> +            .encoded = "\t[ 43 , { 'h' : 'b' },\n\t[ ], 42 ]\n",
>
> I would also test \r, since that is the final whitespace character
> mentioned in RFC 7159.

Easy to do, so why not.
