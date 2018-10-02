Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Lmf-0005Hu-Qy
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7LhI-0005Wi-8L
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:30:53 -0400
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-2-vsementsov@virtuozzo.com>
	<5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ef7c913f-21a6-a85a-55e2-22761dd03084@virtuozzo.com>
Date: Tue, 2 Oct 2018 17:30:35 +0300
MIME-Version: 1.0
In-Reply-To: <5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support device id for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

02.10.2018 17:22, Eric Blake wrote:
> On 10/2/18 6:33 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Support modern way of device selecting.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block-core.json | 6 ++++--
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 8 +++++---
>> =C2=A0 2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index ac3b48ee54..4efd60d8ab 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -489,7 +489,9 @@
>> =C2=A0 # If only @device parameter is specified, remove all present=20
>> latency histograms
>> =C2=A0 # for the device. Otherwise, add/reset some of (or all) latency=20
>> histograms.
>> =C2=A0 #
>> -# @device: device name to set latency histogram for.
>> +# @device: device name to set latency histogram for (better use @id).
>> +#
>> +# @id: The name or QOM path of the guest device.
>
> As long as we are renaming the command, there's no need to keep a=20
> legacy parameter around. Just get rid of device and replace it by id,=20
> rather than worrying about both.=C2=A0 The introduction of the stable=20
> command does not have to carry any baggage left over from the x-=20
> preliminary version.
>

Libvirt don't need both for now, for different scenarios?

--=20
Best regards,
Vladimir
