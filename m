Received: from eggs.gnu.org ([2001:4830:134:3::10]:46347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW1Dm-0000oM-UH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW1Dl-0004Eg-Ql
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:10:02 -0400
References: <152955990402.819.15911298646581883918@d39dc562802a>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12d4807d-7999-1a0c-c5bf-1364e90546bb@redhat.com>
Date: Thu, 21 Jun 2018 10:09:52 -0500
MIME-Version: 1.0
In-Reply-To: <152955990402.819.15911298646581883918@d39dc562802a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for
 testing server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

On 06/21/2018 12:45 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Type: series
> Message-id: 20180621032539.134944-1-eblake@redhat.com
> Subject: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for t=
esting server

>    CC      block/nfs.o
> /var/tmp/patchew-tester-tmp-3490cfwt/src/nbd/server.c: In function =E2=80=
=98nbd_trip=E2=80=99:
> /var/tmp/patchew-tester-tmp-3490cfwt/src/nbd/server.c:1979:19: error: =E2=
=80=98end=E2=80=99 may be used uninitialized in this function [-Werror=3D=
maybe-uninitialized]
>       *length =3D end - offset;
>                 ~~~~^~~~~~~~

That bug (rather, a gcc false-positive solved by adding an assertion=20
rather than an initialization) was in the 'Based-on' prerequisite=20
patches rather than this one.  Here's hoping that patchew will retry=20
when I point to the v2 pull request (oh, and how does patchew handle a=20
v2 pull request that intentionally only sent the patches that differed=20
from v1):

Based-on:=20
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06233.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
