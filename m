Received: from eggs.gnu.org ([2001:4830:134:3::10]:42978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqKWM-0005UB-Bu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqKWI-0004on-3u
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:49:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqKWD-0004nv-Rq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:49:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-52-armbru@redhat.com>
	<fbe4443d-5c86-70dc-4d81-cd882283782e@redhat.com>
Date: Thu, 16 Aug 2018 17:48:58 +0200
In-Reply-To: <fbe4443d-5c86-70dc-4d81-cd882283782e@redhat.com> (Eric Blake's
	message of "Thu, 16 Aug 2018 08:45:32 -0500")
Message-ID: <87bma271n9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 51/56] json: Eliminate lexer state IN_ERROR
 and pseudo-token JSON_MIN
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

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/qmp/json-lexer.h | 10 ++++------
>>   qobject/json-lexer.c          | 18 ++++++++----------
>>   2 files changed, 12 insertions(+), 16 deletions(-)
>>
>
>> @@ -335,8 +334,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
>>               json_message_process_token(lexer, lexer->token, JSON_ERROR,
>>                                          lexer->x, lexer->y);
>>               g_string_truncate(lexer->token, 0);
>> -            new_state = lexer->start_state;
>> -            lexer->state = new_state;
>> +            lexer->state = lexer->start_state;
>
> Does this simplification belong in an earlier patch?

Hmm, PATCH 37 would be a better fit indeed.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
