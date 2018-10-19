Received: from eggs.gnu.org ([2001:4830:134:3::10]:53554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDVeM-0006Yi-6C
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDVeL-0006yg-6a
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:21:14 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-2-mreitz@redhat.com>
	<b208ed10-5763-23a1-c576-23aaa4fa22b2@redhat.com>
	<ed466764-8fdf-0737-5b8d-a469ee04bb06@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a6fdd27-14dd-f26f-3137-8a741bd7cd16@redhat.com>
Date: Fri, 19 Oct 2018 09:21:05 -0500
MIME-Version: 1.0
In-Reply-To: <ed466764-8fdf-0737-5b8d-a469ee04bb06@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 10/19/18 4:48 AM, Max Reitz wrote:
> On 16.10.18 20:07, Eric Blake wrote:
>> On 10/15/18 9:14 AM, Max Reitz wrote:
>>> When closing a connection, make the nbd-fault-injector flush the sock=
et.
>>> Without this, the output is a bit unreliable with Python 3.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  =C2=A0 tests/qemu-iotests/083.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++++++
>>>  =C2=A0 tests/qemu-iotests/nbd-fault-injector.py | 1 +
>>>  =C2=A0 2 files changed, 10 insertions(+)
>>
>> I already had a complaint that the error message in 083.out should NOT
>> be printing a message
>=20
> You mean the NBD server itself, right?

Yes, the NBD server should not be printing the redundant error messages=20
that 083.out exposes.

>=20
>>                        (whether the server is python 2 and auto-flushe=
s,
>> or python 3 and needs an explicit flush, the message itself is
>> pointless, and the test is racy as a result).=C2=A0 We may need to rev=
isit
>> this patch when that thread is resolved.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01041.html
>=20
> Well, it's not like the flush hurts either way. :-)

True. On that grounds:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
