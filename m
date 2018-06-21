Received: from eggs.gnu.org ([2001:4830:134:3::10]:50393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW7mP-0002lj-3y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW7mN-0006e3-G2
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:10:12 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-7-vsementsov@virtuozzo.com>
	<be6cae77-ed51-320f-8a86-fda7865c84b0@redhat.com>
	<4f1dd453-77a4-f45f-f2c9-15d42e95d429@virtuozzo.com>
	<5b4d2ffa-3489-6a93-0352-dbce9221519d@redhat.com>
	<43ed9c89-4730-d333-51ff-2befd03d5462@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <964c76f7-684a-17fc-933f-8c9e3212629b@redhat.com>
Date: Thu, 21 Jun 2018 18:10:03 -0400
MIME-Version: 1.0
In-Reply-To: <43ed9c89-4730-d333-51ff-2befd03d5462@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Incremental Backup Status (Was: Re: [Qemu-block]
 [PATCH v5 6/6] docs/interop: add nbd.txt)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com


On 06/21/2018 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 20.06.2018 23:58, John Snow wrote:
>> Vladimir, can you jog our memories and let us know which series still
>> need to hit QEMU for 3.0 for safe persistence/migration et al?
>>
>> (Not including any of my own qemu-img patches which I'll get to by
>> freeze.)
>=20
> not a trivial question :)
>=20
> at least, there are the following pending patches:
>=20
> migration
> =C2=A0=C2=A0 [PATCH] migration: invalidate cache before source start
>=20

I have to look.

> persistance
> =C2=A0=C2=A0 [PATCH v2] qcow2: add overlap check for bitmap directory

Needs an eye by Kevin or Max.

> =C2=A0=C2=A0 [PATCH] block/qcow2: fix logic around dirty_bitmaps_loaded

You're planning to send a V2, yes?

> =C2=A0=C2=A0 thread "bug in reopen arch", there is no final solution fo=
r now

I'll catch up.

> =C2=A0=C2=A0 also, I need to finally rethink and make a patch to don't =
have any
> persistent bitmaps in inactive mode
>

Or at least reload then on re-activate...

> fleecing
> =C2=A0=C2=A0 [PATCH] block/fleecing-filter: new filter driver for fleec=
ing (new
> patch, but I remember, I've already started to discuss this..)
>=20

On my plate to review.


Otherwise, I think Eric has pulled most of the patches he intended to,
had a spec-based fix for NBD (which you and I already reviewed) and has
a hack that serves as a PoC for libvirt-based testing I intend to look
over shortly.

>From my end, I need to rethink my qemu-img patches to either avoid the
bm_list cache issue or solve the problems you identified; and I'm
waiting to see if Nikolay or Eric would find the n-ary bitmap merge usefu=
l.


Thank you,
--John
