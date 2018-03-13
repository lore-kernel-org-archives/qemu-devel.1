Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evaLc-0000iG-NO
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 23:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evaLb-0007SL-MN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 23:11:32 -0400
References: <152090675906.39.6932440748522025318@71c20359a636>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ccc79fb-1454-85db-5e31-c18a67a32b7c@redhat.com>
Date: Mon, 12 Mar 2018 22:11:09 -0500
MIME-Version: 1.0
In-Reply-To: <152090675906.39.6932440748522025318@71c20359a636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, vsementsov@virtuozzo.com
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/12/2018 09:06 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Type: series
> Message-id: 20180312152126.286890-1-vsementsov@virtuozzo.com
> Subject: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
>=20

>    CC      block/nbd-client.o
>    CC      block/sheepdog.o
> /var/tmp/patchew-tester-tmp-erqpie2w/src/block/nbd-client.c: In functio=
n =E2=80=98nbd_client_co_block_status=E2=80=99:
> /var/tmp/patchew-tester-tmp-erqpie2w/src/block/nbd-client.c:890:15: err=
or: =E2=80=98extent.flags=E2=80=99 may be used uninitialized in this func=
tion [-Werror=3Dmaybe-uninitialized]
>       NBDExtent extent;
>                 ^~~~~~
> /var/tmp/patchew-tester-tmp-erqpie2w/src/block/nbd-client.c:925:19: err=
or: =E2=80=98extent.length=E2=80=99 may be used uninitialized in this fun=
ction [-Werror=3Dmaybe-uninitialized]
>       *pnum =3D extent.length;
>               ~~~~~~^~~~~~~

May be a false positive where the compiler merely can't see through the=20
logic, or it might be a real bug; but I suspect either way that the=20
solution is to initialize this (I'm guessing patch 5), as in:

NBDExtent extent =3D { 0 };

Will squash that in when I get to that part of the review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
