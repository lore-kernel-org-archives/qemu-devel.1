Received: from eggs.gnu.org ([2001:4830:134:3::10]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNZ7-0001nB-4w
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNZ6-0001jn-Cs
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:20:29 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<ca5bbf03-a506-b10b-2db9-cb6a7aad3075@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e90a52f9-e544-a316-56de-8370abd6df3f@redhat.com>
Date: Fri, 9 Mar 2018 13:20:06 -0600
MIME-Version: 1.0
In-Reply-To: <ca5bbf03-a506-b10b-2db9-cb6a7aad3075@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] nbd server fixing and refactoring
 before BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/09/2018 10:41 AM, Eric Blake wrote:
> On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 01 and 02 are splitted and updated "[PATCH] nbd/server: fix space read=
",
>> others are new.
>>
>> Vladimir Sementsov-Ogievskiy (5):
>> =C2=A0=C2=A0 nbd/server: move nbd_co_send_structured_error up
>> =C2=A0=C2=A0 nbd/server: fix sparse read
>> =C2=A0=C2=A0 nbd/server: fix: check client->closing before reply sendi=
ng
>> =C2=A0=C2=A0 nbd/server: refactor nbd_trip: cmd_read and generic reply
>> =C2=A0=C2=A0 nbd/server: refactor nbd_trip: split out nbd_handle_reque=
st
>=20
> I had a tough time applying this one:
>=20
> Applying: nbd/server: move nbd_co_send_structured_error up
> Applying: nbd/server: fix: check client->closing before reply sending
> Applying: nbd/server: refactor nbd_trip: cmd_read and generic reply
> error: sha1 information is lacking or useless (nbd/server.c).
> error: could not build fake ancestor
> Patch failed at 0004 nbd/server: refactor nbd_trip: cmd_read and generi=
c=20
> reply

Aha - I see my problem - the patches were applied out of order because=20
only patch 2 had a 'v2' in the subject line.  If I tell git to apply=20
them one at a time, instead of trying to apply them on 'maildir/*' where=20
the sorting botches the ordering, things work better.

> I think I've resolved the conflicts correctly, but if I get through=20
> reviewing this series and posting it to my NBD queue, you may want to=20
> double-check things.

No need to repost this series, I'm doing a lot better now that I see my=20
mistake.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
