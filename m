Received: from eggs.gnu.org ([2001:4830:134:3::10]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqrG0-00011A-JE
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 21:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqrFx-0003px-TI
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 21:09:40 -0400
Received: from [45.249.212.188] (port=2966 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqrFx-0003ZT-0r
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 21:09:37 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 23 Mar 2017 01:09:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1FFB71@DGGEMA505-MBX.china.huawei.com>
References: <20170322123655.32085-1-pasic@linux.vnet.ibm.com>
	<9f770dc9-f26c-796a-67a7-dc37997efc69@linux.vnet.ibm.com>
In-Reply-To: <9f770dc9-f26c-796a-67a7-dc37997efc69@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cryptodev: fix asserting single queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>=20
>=20
> On 03/22/2017 01:36 PM, Halil Pasic wrote:
> > We already check for queues =3D=3D 1 in cryptodev_builtin_init and when=
 that
> > is not true raise an error. But before that error is reported the
> > assertion in cryptodev_builtin_cleanup kicks in (because object is bein=
g
> > finalized and freed).
> >
> > Let's remove assert(queues =3D=3D 1) form cryptodev_builtin_cleanup as =
it
> > does only harm and no good.
> >
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>=20
> Sorry guys, I forgot to give credit to the reporter.
>=20
> Reported-by: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

Applied, thanks!


> > ---
> >  backends/cryptodev-builtin.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.=
c
> > index 82a068e..137c7a6 100644
> > --- a/backends/cryptodev-builtin.c
> > +++ b/backends/cryptodev-builtin.c
> > @@ -359,8 +359,6 @@ static void cryptodev_builtin_cleanup(
> >          }
> >      }
> >
> > -    assert(queues =3D=3D 1);
> > -
> >      for (i =3D 0; i < queues; i++) {
> >          cc =3D backend->conf.peers.ccs[i];
> >          if (cc) {
> >
