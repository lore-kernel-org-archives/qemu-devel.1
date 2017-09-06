Received: from eggs.gnu.org ([2001:4830:134:3::10]:48766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpZdu-0006sN-JB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpZdo-0007Ut-Oi
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:41:18 -0400
Date: Wed, 6 Sep 2017 14:40:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906124050.GG3753@dhcp-200-186.str.redhat.com>
References: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
	<04bb5a08-99fd-5c59-9be6-765a63a06412@redhat.com>
	<ad95bfe5-22e1-6d62-4fe2-a2e8cfd9c82b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad95bfe5-22e1-6d62-4fe2-a2e8cfd9c82b@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com

Am 06.09.2017 um 10:19 hat Pavel Butsykin geschrieben:
> On 05.09.2017 22:30, Eric Blake wrote:
> > On 09/04/2017 05:18 AM, Pavel Butsykin wrote:
> > > After calling qcow2_inactivate(), all qcow2 caches must be flushed,=
 but this
> > > may not happen, because the last call qcow2_store_persistent_dirty_=
bitmaps()
> > > can lead to marking l2/refcont cache as dirty.
> > >=20
> > > Let's move qcow2_store_persistent_dirty_bitmaps() before the ca=D1=81=
he flushing
> > > to fix it.
> > >=20
> > > Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> > > ---
> > >   block/qcow2.c | 16 ++++++++--------
> > >   1 file changed, 8 insertions(+), 8 deletions(-)
> > >=20
> >=20
> > Should this cc: qemu-stable?
>=20
> The latest stable branch (2.8?) doesn't contain the persistent dirty bi=
tmap.

Cc: qemu-stable would now be for qemu 2.10.1, which I think does need
the fix. I'm adding the tag.

Thanks, applied to the block branch.

Kevin
