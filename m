Received: from eggs.gnu.org ([2001:4830:134:3::10]:50627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUuCx-0008J6-4v
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUuCs-0005L4-1h
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:00:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gUuCr-0005Kg-Pz
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:00:45 -0500
From: Jason Wang <jasowang@redhat.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
Message-ID: <97d2d163-a09b-ec5c-1278-f5d2450f30ad@redhat.com>
Date: Thu, 6 Dec 2018 22:00:26 +0800
MIME-Version: 1.0
In-Reply-To: <561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>, Maxime Coquelin <maxime.coquelin@redhat.com>


On 2018/12/6 =E4=B8=8B=E5=8D=889:57, Jason Wang wrote:
>
> On 2018/12/6 =E4=B8=8B=E5=8D=882:35, elohimes@gmail.com wrote:
>> From: Xie Yongji <xieyongji@baidu.com>
>>
>> This patchset is aimed at supporting qemu to reconnect
>> vhost-user-blk backend after vhost-user-blk backend crash or
>> restart.
>>
>> The patch 1 tries to implenment the sync connection for
>> "reconnect socket".
>>
>> The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
>> to support offering shared memory to backend to record
>> its inflight I/O.
>>
>> The patch 3,4 are the corresponding libvhost-user patches of
>> patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
>>
>> The patch 5 supports vhost-user-blk to reconnect backend when
>> connection closed.
>>
>> The patch 6 tells qemu that we support reconnecting now.
>>
>> To use it, we could start qemu with:
>>
>> qemu-system-x86_64 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -chardev=20
>> socket,id=3Dchar0,path=3D/path/vhost.socket,reconnect=3D1,wait \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device vhost-user-bl=
k-pci,chardev=3Dchar0 \
>>
>> and start vhost-user-blk backend with:
>>
>> vhost-user-blk -b /path/file -s /path/vhost.socket
>>
>> Then we can restart vhost-user-blk at any time during VM running.
>
>
> I wonder whether or not it's better to handle this at the level of=20
> virtio protocol itself instead of vhost-user level. E.g expose=20
> last_avail_idx to driver might be sufficient?
>
> Another possible issue is, looks like you need to deal with different=20
> kinds of ring layouts e.g packed virtqueues.
>
> Thanks=20


Cc Maxime who wrote vhost-user reconnecting for more thoughts.

Thanks
