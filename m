Received: from eggs.gnu.org ([2001:4830:134:3::10]:37773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1edWYn-0008Qt-OS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1edWYk-0007eW-GJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1edWYk-0007dQ-2E
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:26 -0500
Date: Mon, 22 Jan 2018 09:30:03 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180122073002.GA3446@yuvallap>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
	<1516308132-10272-10-git-send-email-mst@redhat.com>
	<abe7704a-0288-6345-0f3d-3fb0474a538a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <abe7704a-0288-6345-0f3d-3fb0474a538a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 09/29] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Jan 18, 2018 at 03:51:17PM -0600, Eric Blake wrote:
> On 01/18/2018 02:44 PM, Michael S. Tsirkin wrote:
> > From: Yuval Shaia <yuval.shaia@oracle.com>
> >=20
> > This function should be declared in generic header file so we can
> > utilize it.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/qemu/host-utils.h | 10 ++++++++++
> >  hw/pci/shpc.c             | 13 ++-----------
> >  2 files changed, 12 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> > index 5ac621c..38da849 100644
> > --- a/include/qemu/host-utils.h
> > +++ b/include/qemu/host-utils.h
> > @@ -400,6 +400,16 @@ static inline uint64_t pow2ceil(uint64_t value)
> >      return 0x8000000000000000ull >> (n - 1);
> >  }
> > =20
> > +static inline uint32_t pow2roundup32(uint32_t x)
> > +{
> > +    x |=3D (x >> 1);
> > +    x |=3D (x >> 2);
> > +    x |=3D (x >> 4);
> > +    x |=3D (x >> 8);
> > +    x |=3D (x >> 16);
> > +    return x + 1;
> > +}
>=20
> How does this differ from pow2ceil(), other than the difference in type=
?

Hi Michael,
I tested pvrdma device with pow2ceil and it works fine however i have no
idea how to test shpc.

So from pvrdma perspective this commit can be dropped. I can replace it
with one that change shpc_bar_size to use pow2ceil but again - compiled,
not tested.

Yuval

>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
