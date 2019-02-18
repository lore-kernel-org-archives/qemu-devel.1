Received: from eggs.gnu.org ([209.51.188.92]:42479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvg5s-0007Uk-4u
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvg5r-0003X6-4t
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:24:12 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 10:24:03 +0000
Message-ID: <3b789e65-4d40-b69d-9e2d-cd838000ea99@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190213081951.GA13081@stefanha-x1.localdomain>
In-Reply-To: <20190213081951.GA13081@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E238794D714EE44CB44945D6E4CD2F3A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, "fam@euphon.net" <fam@euphon.net>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>

13.02.2019 11:19, Stefan Hajnoczi wrote:
> On Thu, Feb 07, 2019 at 01:24:28PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> Here is a new simple helper for a very often patter
>> around qemu_iovec_init_external, when we need simple qiov with only
>> one iov, initialized from external buffer.
>>
>> v3:
>=20
> Hi Vladimir,
> "make check" is failing:
>=20
>    TEST    check-qtest-x86_64: tests/ide-test
> qemu-system-x86_64: /home/stefanha/qemu/include/qemu/iov.h:195: qemu_iove=
c_get_buf: Assertion `qiov->niov =3D=3D -1 && qiov->iov =3D=3D &qiov->local=
_iov' failed.
>=20
> Please take a look and send v4.
>=20
> Stefan
>=20

Oops, sorry for this, it obviously should be qiov->nalloc =3D=3D -1 in asse=
rtion. I'll resend and rename s/qemu_iovec_get_buf/qemu_iovec_embedded_buf/=
 to make it more obvious.

--=20
Best regards,
Vladimir
