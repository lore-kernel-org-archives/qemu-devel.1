Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clBwC-00069Z-N1
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clBw8-0005O5-Rc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:01:48 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:36147 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1clBw8-0005Lb-Fu
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:01:44 -0500
References: <20170306223054.25666-1-eblake@redhat.com>
	<01052592-5c40-8dc6-da15-5376a6ee8354@amsat.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c81fe070-da3c-254c-2f2e-d19ce097f307@virtuozzo.com>
Date: Tue, 7 Mar 2017 13:01:39 +0300
MIME-Version: 1.0
In-Reply-To: <01052592-5c40-8dc6-da15-5376a6ee8354@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com

07.03.2017 03:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Vladimir,
>
> On 03/06/2017 07:30 PM, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Comparison symbol is misused. It may lead to memory corruption.
>> Introduced in commit 7d3123e.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
>> [eblake: add CVE details]
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <address@hidden>
>> ---
>>
>> This one still hasn't been merged in; sending separately since the
>> rest of my NBD series is now 2.10 material:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04528.html
>>
>>  nbd/client.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 5c9dee3..165b33e 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t siz=
e)
>>      char small[1024];
>>      char *buffer;
>>
>> -    buffer =3D sizeof(small) < size ? small : g_malloc(MIN(65536, siz=
e));
>> +    buffer =3D sizeof(small) > size ? small : g_malloc(MIN(65536, siz=
e));
>
> here ">=3D" seems correct/safe.
> (if size is 1024, use small stack buffer too).

Agree.

>
>>      while (size > 0) {
>>          ssize_t count =3D read_sync(ioc, buffer, MIN(65536, size));
>>


--=20
Best regards,
Vladimir
