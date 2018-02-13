Received: from eggs.gnu.org ([2001:4830:134:3::10]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonathan.helman@oracle.com>) id 1elhD8-0001q0-1o
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonathan.helman@oracle.com>) id 1elhD4-0001TA-V5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:29:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jonathan.helman@oracle.com>)
	id 1elhD4-0001Rb-Gw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:29:50 -0500
References: <cover.1512476043.git.tgolembi@redhat.com>
	<938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
	<20180205130824.79f570bc@fiorina>
From: Jonathan Helman <jonathan.helman@oracle.com>
Message-ID: <1e6717d5-a1bc-3409-b01f-24ea761659fb@oracle.com>
Date: Tue, 13 Feb 2018 12:29:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180205130824.79f570bc@fiorina>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-balloon: include statistics
 of disk/file caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 02/05/2018 04:08 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> ping
>=20
> On Tue,  5 Dec 2017 13:14:46 +0100
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
>=20

It would be good to include the corresponding upstream kernel change in=20
the commit message. This would be similar to a previous change:=20
https://lists.gnu.org/archive/html/qemu-devel/2016-02/msg05555.html

>> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>> ---
>>   hw/virtio/virtio-balloon.c                      | 1 +
>>   include/standard-headers/linux/virtio_balloon.h | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 37cde38982..8141326a51 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -50,6 +50,7 @@ static const char *balloon_stat_names[] =3D {
>>      [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
>>      [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
>>      [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
>> +   [VIRTIO_BALLOON_S_CACHES] =3D "stat-disk-caches",
>>      [VIRTIO_BALLOON_S_NR] =3D NULL
>>   };
>>  =20
>> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include=
/standard-headers/linux/virtio_balloon.h
>> index 9d06ccd066..7b0a41b8fc 100644
>> --- a/include/standard-headers/linux/virtio_balloon.h
>> +++ b/include/standard-headers/linux/virtio_balloon.h
>> @@ -52,7 +52,8 @@ struct virtio_balloon_config {
>>   #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory=
 */
>>   #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>>   #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /pro=
c */
>> -#define VIRTIO_BALLOON_S_NR       7
>> +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */

I've been wondering, VIRTIO_BALLOON_S_AVAIL is not in the virtio spec=20
(see Section 5.5.6.3). It seems like this header file needs to be in=20
sync with the virtio spec in order to make this change.

I have a similar change to add a new statistic and was wondering this.

>> +#define VIRTIO_BALLOON_S_NR       8
>>  =20
>>   /*
>>    * Memory statistics structure.
>> --=20
>> 2.15.1
>>
>=20
>=20

You need to add your new stat to the list of stats in=20
docs/virtio-balloon-stats.txt.

Jon
