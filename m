Received: from eggs.gnu.org ([2001:4830:134:3::10]:54033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f72kt-0000sy-PM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 13:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f72ks-0002IF-SH
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 13:44:59 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-3-vsementsov@virtuozzo.com>
	<b3976794-7cb4-912d-d457-762dca65a2f8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a5e15d04-9d0c-65f0-2368-4313f721dfc2@virtuozzo.com>
Date: Fri, 13 Apr 2018 20:44:46 +0300
MIME-Version: 1.0
In-Reply-To: <b3976794-7cb4-912d-d457-762dca65a2f8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] nbd/server: add nbd_meta_single_query
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

21.03.2018 18:05, Eric Blake wrote:
> On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The helper will be reused for bitmaps namespace.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 nbd/server.c | 41 ++++++++++++++++++++++++++++-------------
>> =C2=A0 1 file changed, 28 insertions(+), 13 deletions(-)
>>
>
>> +/* Read len bytes and check matching to the pattern.
>> + * @match is set to true on empty query for _LIST_ and for query=20
>> matching the
>> + * @pattern. @match is never set to false.
>
> How about:
>
> Read @len bytes, and set @match to true if they match @pattern, or if=20
> @len is 0 and the client is performing _LIST_.=C2=A0 @match is never set =
to=20
> false.

will add, as always, thank you for natural rewording) Hm, I have a=20
question: why do you often use double white-space "=C2=A0 " between=20
sentences? Is it something meaningful?

>
> At any rate, the refactoring is sane; and comment touchups are=20
> trivial, so
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>


--=20
Best regards,
Vladimir
