Received: from eggs.gnu.org ([2001:4830:134:3::10]:52214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dbDlJ-0005PK-CR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dbDlI-0006Xi-Gf
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:29:37 -0400
Date: Fri, 28 Jul 2017 15:29:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <a965a76e-3a63-e69c-18f1-dbfdc569cafd@amsat.org>
Message-ID: <alpine.DEB.2.10.1707281529090.22381@sstabellini-ThinkPad-X260>
References: <20170728131151.4802-1-olaf@aepfle.de>
	<a965a76e-3a63-e69c-18f1-dbfdc569cafd@amsat.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Olaf Hering <olaf@aepfle.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On Fri, 28 Jul 2017, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Olaf,
>=20
> On 07/28/2017 10:11 AM, Olaf Hering wrote:
> > g_malloc0_n is available since glib-2.24. To allow build with older g=
lib
> > versions use the generic g_new0, which is already used in many other
> > places in the code.
>=20
> Can you provide information about which distrib/release/version/[packag=
es?]
> you used? So we might add the same setup in QEMU continuous integration
> system.

FYI http://marc.info/?l=3Dqemu-devel&m=3D150113545516942&w=3D2



> >=20
> > Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared
> > rings")
> >=20
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > ---
> >   hw/block/xen_disk.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> > index d42ed7070d..536e2ee735 100644
> > --- a/hw/block/xen_disk.c
> > +++ b/hw/block/xen_disk.c
> > @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice *xendev=
)
> >           return -1;
> >       }
> >   -    domids =3D g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> > +    domids =3D g_new0(uint32_t, blkdev->nr_ring_ref);
> >       for (i =3D 0; i < blkdev->nr_ring_ref; i++) {
> >           domids[i] =3D blkdev->xendev.dom;
> >       }
> >=20
>=20
