Received: from eggs.gnu.org ([2001:4830:134:3::10]:35968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfihl-0004JA-5E
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfihf-0003Q7-UX
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:20:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-2-git-send-email-armbru@redhat.com>
	<546a1140-e5e1-b6b9-2671-0dba6a274227@redhat.com>
Date: Thu, 10 Aug 2017 10:20:06 +0200
In-Reply-To: <546a1140-e5e1-b6b9-2671-0dba6a274227@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 09:39:42 -0500")
Message-ID: <87valvhm15.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 01/56] qobject: Touch up comments to
 say @param instead of 'param'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 08/07/2017 09:45 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qobject/qdict.c | 68 ++++++++++++++++++++++++++++-----------------------------
>>  qobject/qlist.c |  2 +-
>>  2 files changed, 35 insertions(+), 35 deletions(-)
>> 
>> diff --git a/qobject/qdict.c b/qobject/qdict.c
>> index 576018e..d795079 100644
>> --- a/qobject/qdict.c
>> +++ b/qobject/qdict.c
>> @@ -116,13 +116,13 @@ static QDictEntry *qdict_find(const QDict *qdict,
>>  /**
>>   * qdict_put_obj(): Put a new QObject into the dictionary
>>   *
>> - * Insert the pair 'key:value' into 'qdict', if 'key' already exists
>> - * its 'value' will be replaced.
>> + * Insert the pair @key:@value into @qdict, if @key already exists
>> + * its value will be replaced.
>
> Maybe s/,/;/ while at it.

Or even *gasp* a period.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
