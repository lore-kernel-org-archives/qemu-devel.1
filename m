Received: from eggs.gnu.org ([209.51.188.92]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIyIk-0004OA-RX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIyA6-0000B3-1P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:20:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 23 Apr 2019 16:20:27 +0000
Message-ID: <66748c66-f2d3-c33b-cd76-52c158fa3519@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
	<20190423130629.GH32465@stefanha-x1.localdomain>
In-Reply-To: <20190423130629.GH32465@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <DF0C9ADB4484944CB0464F3EE19AB530@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "jsnow@redhat.com" <jsnow@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

23.04.2019 16:06, Stefan Hajnoczi wrote:
> On Mon, Apr 22, 2019 at 05:58:29PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> We often need to do read/write with buffer, not qiov. Instead of
>> creating qiov in such cases, let's introduce corresponding helpers.
>>
>> Vladimir Sementsov-Ogievskiy (9):
>>    block: introduce byte-based io helpers
>>    block/qcow2: use buffer-based io
>>    block/qcow: use buffer-based io
>>    block/qed: use buffer-based io
>>    block/parallels: use buffer-based io
>>    block/backup: use buffer-based io
>>    block/commit: use buffer-based io
>>    block/stream: use buffer-based io
>>    qemu-img: use buffer-based io
>>
>>   include/block/block_int.h      | 16 ++++++++++++++++
>>   include/sysemu/block-backend.h | 19 +++++++++++++++++++
>>   block/backup.c                 | 14 ++++++--------
>>   block/commit.c                 |  5 ++---
>>   block/parallels.c              | 14 ++++++--------
>>   block/qcow.c                   | 19 ++++++-------------
>>   block/qcow2.c                  |  9 ++-------
>>   block/qed-table.c              | 12 +++++-------
>>   block/qed.c                    |  6 ++----
>>   block/stream.c                 |  4 +---
>>   qemu-img.c                     | 13 ++++---------
>>   11 files changed, 69 insertions(+), 62 deletions(-)
>>
>> --=20
>> 2.18.0
>>
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Thanks!

--=20
Best regards,
Vladimir
