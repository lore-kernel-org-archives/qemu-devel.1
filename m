Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7LnC-0005hb-Jy
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7LnA-0008SB-Rv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:54 -0400
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-2-vsementsov@virtuozzo.com>
	<5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
	<ef7c913f-21a6-a85a-55e2-22761dd03084@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1e14dad-78bc-f504-9f7f-738ca53af3f6@redhat.com>
Date: Tue, 2 Oct 2018 09:35:50 -0500
MIME-Version: 1.0
In-Reply-To: <ef7c913f-21a6-a85a-55e2-22761dd03084@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

On 10/2/18 9:30 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> -# @device: device name to set latency histogram for.
>>> +# @device: device name to set latency histogram for (better use @id)=
.
>>> +#
>>> +# @id: The name or QOM path of the guest device.
>>
>> As long as we are renaming the command, there's no need to keep a=20
>> legacy parameter around. Just get rid of device and replace it by id,=20
>> rather than worrying about both.=C2=A0 The introduction of the stable=20
>> command does not have to carry any baggage left over from the x-=20
>> preliminary version.
>>
>=20
> Libvirt don't need both for now, for different scenarios?

If you want both to work because libvirt has reasons to use both, then=20
the documentation needs to be more precise. "(better use @id)" does not=20
tell me why I shouldn't use @device, or what difference in behavior I=20
get by using one instead of the other. Furthermore, if @id is able to=20
use the name of the guest device as an alternative to the QOM path, then=20
how is that different from @device being the name of the guest device?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
