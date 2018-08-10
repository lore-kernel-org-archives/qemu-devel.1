Received: from eggs.gnu.org ([2001:4830:134:3::10]:42344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8DL-0003fM-1S
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8DG-000289-45
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:16:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo8DF-00027s-Uz
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:16:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-10-armbru@redhat.com>
	<536be1d2-05ed-44f8-405c-5a821bee6d82@redhat.com>
Date: Fri, 10 Aug 2018 16:16:20 +0200
In-Reply-To: <536be1d2-05ed-44f8-405c-5a821bee6d82@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 09:03:36 -0500")
Message-ID: <87pnyql32j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/56] check-qjson: Cover escaped
 characters more thoroughly, part 2
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

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> Cover surrogates, invalid escapes, and noncharacters.  This
>> demonstrates that valid surrogate pairs are misinterpreted, and
>> invalid surrogates and noncharacters aren't rejected.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 53 ++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 45 insertions(+), 8 deletions(-)
>>
>
>> +        { "\\u12x", NULL },
>> +        { "\\u123x", NULL },
>> +        { "\\u12345", "\341\210\2645" },
>> +        { "\\u12345", "\341\210\2645" },
>
> Why is this one duplicated?

Editing accident, fixing.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
