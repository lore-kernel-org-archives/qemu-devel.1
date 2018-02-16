Received: from eggs.gnu.org ([2001:4830:134:3::10]:33733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emeSm-0005W5-7M
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emeSl-0006Td-Bd
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:46:00 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
	<ac33f176-0f15-107f-1c64-4fa3bac77520@redhat.com>
	<2b30632c-4028-2726-fd61-81ae3893cfd4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f52c2ad0-34d3-9255-b87f-169d923cc128@redhat.com>
Date: Fri, 16 Feb 2018 05:45:36 -0600
MIME-Version: 1.0
In-Reply-To: <2b30632c-4028-2726-fd61-81ae3893cfd4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/16/2018 05:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> 16.02.2018 02:02, Eric Blake wrote:
>> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Minimal realization: only one extent in server answer is supported.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 include/block/nbd.h |=C2=A0 33 ++++++
>>> =C2=A0 nbd/common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 10 ++
>>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 310=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>> =C2=A0 3 files changed, 352 insertions(+), 1 deletion(-)
>>>
>>
>>> @@ -200,9 +227,15 @@ enum {
>>> =C2=A0 #define NBD_REPLY_TYPE_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0
>>> =C2=A0 #define NBD_REPLY_TYPE_OFFSET_DATA=C2=A0=C2=A0 1
>>> =C2=A0 #define NBD_REPLY_TYPE_OFFSET_HOLE=C2=A0=C2=A0 2
>>> +#define NBD_REPLY_TYPE_BLOCK_STATUS=C2=A0 5
>>
>> Stale; see nbd.git commit 56c77720 which changed this to 3.
>=20
> Very unpleasant surprise. I understand that this is still experimental=20
> extension, but actually we use it =3D5 in production about one year. Ca=
n=20
> we revert it to 5?

For that, you'll have to ask on the upstream NBD list.  There may be=20
other things that turn out to need tweaking as I get through the rest of=20
your initial implementation, vs. what works well for interoperability,=20
so having a distinct number for experimental vs. actual may be=20
worthwhile for other reasons as well, even if it requires some glue code=20
on your side to handle an older server sending 5 instead of 3 to a newer=20
client.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
