Received: from eggs.gnu.org ([2001:4830:134:3::10]:40036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaaz-0001ny-31
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaay-0006xV-4k
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:17:57 -0400
References: <20180503222626.1303410-1-eblake@redhat.com>
	<e324b560-8902-4e88-76c4-17c4e16b6b1c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f58d0f6-f7f5-ba82-1584-5d7443e48311@redhat.com>
Date: Fri, 4 May 2018 08:17:46 -0500
MIME-Version: 1.0
In-Reply-To: <e324b560-8902-4e88-76c4-17c4e16b6b1c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Relax handling of large
 NBD_CMD_BLOCK_STATUS reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 05/04/2018 05:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> 04.05.2018 01:26, Eric Blake wrote:
>> The NBD spec is proposing a relaxation of NBD_CMD_BLOCK_STATUS
>> where a server may have the final extent per context give a
>> length beyond the original request, if it can easily prove that
>> subsequent bytes have the same status, on the grounds that a
>> client can take advantage of this information for fewer block
>> status requests.=C2=A0 Since qemu 2.12 as a client always sends
>> NBD_CMD_FLAG_REQ_ONE, and rejects a server that sends extra
>> length, the upstream NBD spec will probably limit this behavior
>> to clients that don't request REQ_ONE semantics; but it doesn't
>> hurt to relax qemu to always be permissive of this server
>> behavior, even if it continues to use REQ_ONE.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 block/nbd-client.c | 10 +++++++---
>> =C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)

>=20
> with s/=3D=3D/=3D/
>=20
>=20
> Reviewed-by:=C2=A0 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>

Thanks; queuing the fixed patch on my NBD tree.  Also, I think this=20
deserves to go in a stable release, to minimize the chance that we choke=20
on an incompatible server, so:

CC: qemu-stable@nongnu.org

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
