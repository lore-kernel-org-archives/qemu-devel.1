Received: from eggs.gnu.org ([2001:4830:134:3::10]:44746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dpVYj-00055a-RR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dpVYf-0005u8-PY
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:19:41 -0400
References: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
	<04bb5a08-99fd-5c59-9be6-765a63a06412@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <ad95bfe5-22e1-6d62-4fe2-a2e8cfd9c82b@virtuozzo.com>
Date: Wed, 6 Sep 2017 11:19:25 +0300
MIME-Version: 1.0
In-Reply-To: <04bb5a08-99fd-5c59-9be6-765a63a06412@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 05.09.2017 22:30, Eric Blake wrote:
> On 09/04/2017 05:18 AM, Pavel Butsykin wrote:
>> After calling qcow2_inactivate(), all qcow2 caches must be flushed, but =
this
>> may not happen, because the last call qcow2_store_persistent_dirty_bitma=
ps()
>> can lead to marking l2/refcont cache as dirty.
>>
>> Let's move qcow2_store_persistent_dirty_bitmaps() before the ca=D1=81he =
flushing
>> to fix it.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   block/qcow2.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>=20
> Should this cc: qemu-stable?

The latest stable branch (2.8?) doesn't contain the persistent dirty bitmap=
.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
