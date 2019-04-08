Received: from eggs.gnu.org ([209.51.188.92]:46327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDQqD-0004aB-MB
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDQqC-0008Nv-Lu
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:45:25 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 8 Apr 2019 09:45:17 +0000
Message-ID: <3bd0a942-f89b-5302-631a-1b7af3dc8702@virtuozzo.com>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190408090013.GJ15001@stefanha-x1.localdomain>
In-Reply-To: <20190408090013.GJ15001@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7502647989D87A45A286282D2EFCDB75@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 08/04/2019 12:00, Stefan Hajnoczi wrote:
> On Fri, Apr 05, 2019 at 05:24:04PM +0300, Andrey Shinkevich wrote:
>> On a file system used by the customer, fallocate() returns an error
>> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
>> fails. We can handle that case the same way as it is done for the
>> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
>> zeroes to an image for the unaligned chunk of the block.
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Thanks, applied to my block-next tree for QEMU 4.1:
> https://github.com/stefanha/qemu/commits/block-next
>=20
> Stefan
>=20

Thank you all!
--=20
With the best regards,
Andrey Shinkevich
